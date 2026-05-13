#!/usr/bin/env bash
# 一键安装本仓库的 git hooks。首次 clone 仓库后请运行一次。
# 用法: bash scripts/install-hooks.sh

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
HOOKS_DIR="$REPO_ROOT/.git/hooks"

mkdir -p "$HOOKS_DIR"

# pre-commit：调用 scan-secrets.sh --staged
cat > "$HOOKS_DIR/pre-commit" <<'HOOK'
#!/usr/bin/env bash
# 自动生成于 scripts/install-hooks.sh，请勿手动修改；如需调整规则请改 scripts/scan-secrets.sh
set -e
REPO_ROOT="$(git rev-parse --show-toplevel)"
bash "$REPO_ROOT/scripts/scan-secrets.sh" --staged
HOOK

chmod +x "$HOOKS_DIR/pre-commit"

echo "✓ 已安装 pre-commit 钩子: $HOOKS_DIR/pre-commit"
echo "  下次 git commit 时将自动扫描 staged 文件"
echo ""
echo "也可手动跑全量扫描:  bash scripts/scan-secrets.sh"
