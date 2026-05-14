#!/usr/bin/env bash
# 密钥扫描脚本：本地 pre-commit 钩子和 CI 共用。
# 用法：
#   bash scripts/scan-secrets.sh             # 全量扫描整个工作树（CI 用）
#   bash scripts/scan-secrets.sh --staged    # 仅扫描 git staged 文件（pre-commit 用）
#   bash scripts/scan-secrets.sh --self-test # 对每条规则跑回归用例（CI 用，本地也可手动跑）
#
# 退出码：
#   0 - 未发现可疑模式 / 自检全部通过
#   1 - 发现可疑模式（提交应被阻断）/ 自检失败
#   2 - 脚本本身错误（如未安装 git、参数错误）

set -u
set -o pipefail

MODE="${1:-full}"
case "$MODE" in
  --staged)    MODE="staged" ;;
  --self-test) MODE="self-test" ;;
  full|--full|"") MODE="full" ;;
  *) echo "用法: $0 [--staged|--full|--self-test]" >&2; exit 2 ;;
esac

# 检查依赖命令（自检模式不需要 git）
if [[ "$MODE" != "self-test" ]]; then
  for cmd in git file; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "[scan-secrets] 错误: 未找到命令 '$cmd'，请先安装" >&2
      exit 2
    fi
  done
fi

# 1. 收集要扫描的文件列表（兼容 macOS bash 3.2，不用 mapfile）
FILES=()
if [[ "$MODE" == "staged" ]]; then
  while IFS= read -r line; do FILES+=("$line"); done \
    < <(git diff --cached --name-only --diff-filter=ACMR)
elif [[ "$MODE" == "full" ]]; then
  while IFS= read -r line; do FILES+=("$line"); done \
    < <(git ls-files --cached --others --exclude-standard)
fi

if [[ "$MODE" != "self-test" && ${#FILES[@]} -eq 0 ]]; then
  echo "[scan-secrets] 无文件可扫描（模式: $MODE）"
  exit 0
fi

# 2. 可疑模式表（基于全局军规第 10 条 + 常见服务）
#    使用平行数组：P_REGEX[i] 配套 P_LABEL[i]，避免与正则内 `|` 冲突。
#    含单引号的正则必须使用 ANSI-C 引用 $'...' 形式，以便 \x27 被 shell 转成真正的
#    单引号；普通单引号串里写 \x27 在 GNU grep（Linux/CI）中会被当作字面 4 字符
#    （\、x、2、7），既漏报又会错误地排除掉合法用户名/密码字符。
DB_URI_PATTERN=$'(postgres|postgresql|mysql|mongodb|mongodb\\+srv|redis|amqp)://[^[:space:]"\x27]*:[^[:space:]"\x27]+@'

P_REGEX=()
P_LABEL=()
add_pattern() { P_REGEX+=("$1"); P_LABEL+=("$2"); }

add_pattern 'sk-[A-Za-z0-9]{20,}'                                                     'OpenAI API key'
add_pattern 'sk-ant-[A-Za-z0-9_-]{20,}'                                               'Anthropic API key'
add_pattern 'AKIA[0-9A-Z]{16}'                                                        'AWS Access Key ID'
add_pattern 'aws_secret_access_key[[:space:]]*=[[:space:]]*[A-Za-z0-9/+=]{40}'        'AWS Secret Access Key'
add_pattern 'AIza[0-9A-Za-z_-]{35}'                                                   'Google API key'
add_pattern 'ya29\.[0-9A-Za-z_-]+'                                                    'Google OAuth access token'
add_pattern 'ghp_[A-Za-z0-9]{36}'                                                     'GitHub personal access token'
add_pattern 'gho_[A-Za-z0-9]{36}'                                                     'GitHub OAuth token'
add_pattern 'ghs_[A-Za-z0-9]{36}'                                                     'GitHub Server token'
add_pattern 'ghr_[A-Za-z0-9]{36}'                                                     'GitHub refresh token'
add_pattern 'xox[abprs]-[A-Za-z0-9-]{10,}'                                            'Slack token'
add_pattern '-----BEGIN ([A-Z]+ )?PRIVATE KEY-----'                                   'PEM 私钥块'
add_pattern "$DB_URI_PATTERN"                                                         '包含密码的数据库连接串'
add_pattern 'GITALK_CLIENT_SECRET[[:space:]]*=[[:space:]]*[A-Za-z0-9_]{10,}'          'Gitalk OAuth Client Secret'

# 2.5 自检：对每条规则用一个已知正例验证 regex 真的能匹中；用一个已知反例验证
#     不会误报。任何新增规则都应在这里同步加一组用例，防止类似"分隔符冲突"或
#     "ANSI-C 引用错误"等问题在 CI 上才被发现。
if [[ "$MODE" == "self-test" ]]; then
  # 用例字符串在源码中以拼接形式出现，避免外部密钥扫描服务（如 GitGuardian）
  # 把脚本自带的回归 fixtures 当作真实泄露
  _j() { printf '%s%s' "$1" "$2"; }
  # 索引必须与上面 add_pattern 调用顺序一一对应
  POSITIVES=(
    "$(_j 'sk-'      'aBcDeFgHiJkLmNoPqRsT0123456789')"
    "$(_j 'sk-ant-'  'AbCdEfGh1234567890XYZ_-')"
    "$(_j 'AKIA'     'IOSFODNN7EXAMPLE')"
    "$(_j 'aws_secret_access_key = ' 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY00')"
    "$(_j 'AIza'     'SyA1B2C3D4E5F6G7H8I9J0K1L2M3N4O5P6Q7R')"
    "$(_j 'ya29.'    'A0AfH6SMBxxxxxxx')"
    "$(_j 'ghp_'     '1234567890abcdefghij1234567890abcdef')"
    "$(_j 'gho_'     '1234567890abcdefghij1234567890abcdef')"
    "$(_j 'ghs_'     '1234567890abcdefghij1234567890abcdef')"
    "$(_j 'ghr_'     '1234567890abcdefghij1234567890abcdef')"
    "$(_j 'xoxb-'    '12345-67890-abcdefABCDEF')"
    "$(_j '-----BEGIN ' 'RSA PRIVATE KEY-----')"
    "$(_j 'postgres://user2:' 'Pass2x7Secret@host/db')"
    "$(_j 'GITALK_CLIENT_SECRET=' 'Xx1234567890Yy')"
  )
  # 已知反例（任何规则都不应匹中），覆盖容易误报的边界：
  #   - 普通文本含数字 2/x/7（验证旧的 \x27 漏洞修复）
  #   - 单/双引号字符串里的伪 URI（验证规则不会跨越字符串边界）
  #   - 占位符 / 短随机串
  NEGATIVES=(
    'this is plain text with x and 2 and 7 in it'
    "config = 'postgres://placeholder_no_at_sign'"
    'short=abc123'
    'sk-too-short'
    'ghp_short'
  )

  FAIL=0
  if [[ ${#POSITIVES[@]} -ne ${#P_REGEX[@]} ]]; then
    echo "[scan-secrets][self-test] 错误: POSITIVES 用例数 ${#POSITIVES[@]} 与规则数 ${#P_REGEX[@]} 不一致" >&2
    exit 1
  fi
  for i in "${!P_REGEX[@]}"; do
    if echo "${POSITIVES[$i]}" | grep -qE -e "${P_REGEX[$i]}"; then
      echo "[scan-secrets][self-test] ✓ ${P_LABEL[$i]}"
    else
      echo "[scan-secrets][self-test] ✗ ${P_LABEL[$i]} 未匹中正例: ${POSITIVES[$i]}" >&2
      FAIL=1
    fi
  done
  for neg in "${NEGATIVES[@]}"; do
    for i in "${!P_REGEX[@]}"; do
      if echo "$neg" | grep -qE -e "${P_REGEX[$i]}"; then
        echo "[scan-secrets][self-test] ✗ 规则 [${P_LABEL[$i]}] 误报反例: $neg" >&2
        FAIL=1
      fi
    done
  done
  if [[ $FAIL -eq 0 ]]; then
    echo "[scan-secrets][self-test] ✓ 全部 ${#P_REGEX[@]} 条规则与 ${#NEGATIVES[@]} 条反例通过"
    exit 0
  else
    exit 1
  fi
fi

# 3. 排除项：
#    - 本脚本本身（包含模式定义，会自匹配）
#    - 安全文档（SECURITY.md / ADR / CLAUDE.md 中允许出现模式作为说明）
#    - *.example / *.sample 文件（按惯例只放占位值）
EXCLUDES_REGEX='(^(scripts/scan-secrets\.sh|SECURITY\.md|CLAUDE\.md)$|^docs/decisions/.*\.md$|\.(example|sample|template)$|\.(example|sample|template)\.[A-Za-z0-9]+$)'

FOUND=0
for file in "${FILES[@]}"; do
  # 跳过自身和文档（这些里允许出现模式作为示例 / 文档说明）
  if [[ "$file" =~ $EXCLUDES_REGEX ]]; then continue; fi
  # 跳过二进制 / 大文件
  if [[ ! -f "$file" ]]; then continue; fi
  if [[ "$(file -b --mime-encoding "$file" 2>/dev/null)" == "binary" ]]; then continue; fi
  size=$(wc -c < "$file" 2>/dev/null || echo 0)
  if (( size > 1048576 )); then continue; fi  # >1MB 跳过

  for i in "${!P_REGEX[@]}"; do
    # 使用 -e 显式声明模式，避免以 `-` 开头的正则（如 PEM 头）被当作选项
    if matches=$(grep -nEH -e "${P_REGEX[$i]}" "$file" 2>/dev/null); then
      echo "[scan-secrets] ✗ 可能泄露: ${P_LABEL[$i]}"
      echo "$matches" | sed 's/^/    /'
      FOUND=1
    fi
  done
done

if [[ $FOUND -eq 1 ]]; then
  echo ""
  echo "[scan-secrets] 发现疑似密钥。如确认为误报，请："
  echo "  1) 修改文件，避开该模式（推荐）；或"
  echo "  2) 在 scripts/scan-secrets.sh 的 EXCLUDES_REGEX 或 PATTERNS 中调整规则，并在 PR 中说明原因"
  exit 1
fi

echo "[scan-secrets] ✓ 通过（扫描 ${#FILES[@]} 个文件，模式: ${MODE}）"
exit 0
