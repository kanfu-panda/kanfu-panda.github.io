#!/usr/bin/env bash
# 密钥扫描脚本：本地 pre-commit 钩子和 CI 共用。
# 用法：
#   bash scripts/scan-secrets.sh             # 全量扫描整个工作树（CI 用）
#   bash scripts/scan-secrets.sh --staged    # 仅扫描 git staged 文件（pre-commit 用）
#
# 退出码：
#   0 - 未发现可疑模式
#   1 - 发现可疑模式（提交应被阻断）
#   2 - 脚本本身错误（如未安装 git、参数错误）

set -u
set -o pipefail

# 检查依赖命令
for cmd in git file; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "[scan-secrets] 错误: 未找到命令 '$cmd'，请先安装" >&2
    exit 2
  fi
done

MODE="${1:-full}"
case "$MODE" in
  --staged) MODE="staged" ;;
  full|--full|"") MODE="full" ;;
  *) echo "用法: $0 [--staged|--full]" >&2; exit 2 ;;
esac

# 1. 收集要扫描的文件列表（兼容 macOS bash 3.2，不用 mapfile）
FILES=()
if [[ "$MODE" == "staged" ]]; then
  while IFS= read -r line; do FILES+=("$line"); done \
    < <(git diff --cached --name-only --diff-filter=ACMR)
else
  while IFS= read -r line; do FILES+=("$line"); done \
    < <(git ls-files --cached --others --exclude-standard)
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "[scan-secrets] 无文件可扫描（模式: $MODE）"
  exit 0
fi

# 2. 可疑模式表（基于全局军规第 10 条 + 常见服务）
#    每条：[正则] [说明]。注意 grep -E 使用扩展正则。
declare -a PATTERNS=(
  'sk-[A-Za-z0-9]{20,}|OpenAI API key'
  'sk-ant-[A-Za-z0-9_-]{20,}|Anthropic API key'
  'AKIA[0-9A-Z]{16}|AWS Access Key ID'
  'aws_secret_access_key[[:space:]]*=[[:space:]]*[A-Za-z0-9/+=]{40}|AWS Secret Access Key'
  'AIza[0-9A-Za-z_-]{35}|Google API key'
  'ya29\.[0-9A-Za-z_-]+|Google OAuth access token'
  'ghp_[A-Za-z0-9]{36}|GitHub personal access token'
  'gho_[A-Za-z0-9]{36}|GitHub OAuth token'
  'ghs_[A-Za-z0-9]{36}|GitHub Server token'
  'ghr_[A-Za-z0-9]{36}|GitHub refresh token'
  'xox[abprs]-[A-Za-z0-9-]{10,}|Slack token'
  '-----BEGIN ([A-Z]+ )?PRIVATE KEY-----|PEM 私钥块'
  '(postgres|postgresql|mysql|mongodb|mongodb\+srv|redis|amqp)://[^[:space:]\"\x27]*:[^[:space:]\"\x27]+@|包含密码的数据库连接串'
  'GITALK_CLIENT_SECRET[[:space:]]*=[[:space:]]*[A-Za-z0-9_]{10,}|Gitalk OAuth Client Secret'
)

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

  for entry in "${PATTERNS[@]}"; do
    pattern="${entry%%|*}"
    label="${entry##*|}"
    if matches=$(grep -nEH "$pattern" "$file" 2>/dev/null); then
      echo "[scan-secrets] ✗ 可能泄露: $label"
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
