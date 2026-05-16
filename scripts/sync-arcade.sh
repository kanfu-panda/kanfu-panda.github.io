#!/usr/bin/env bash
#
# sync-arcade.sh —— 从 arcade_emulator 私有仓库拉取最新编译产物到博客 /arcade/ 子目录
#
# 用法（在博客仓库根目录运行）：
#   bash scripts/sync-arcade.sh
#
# 前置条件：
#   1. arcade_emulator 源码已 clone 在 $ARCADE_SRC（默认 ~/projects/arcade_emulator）
#   2. 源码中已开启"自传 BIOS"模式 + EmulatorJS 走 CDN（feat/public-safe-deploy 分支起）
#   3. 本机已 npm install
#
# 流程：
#   1. 进 arcade 源码目录 → npm run build → dist/
#   2. 清空博客 arcade/ → 把 dist 拷贝过来
#   3. 跑安全红线校验：拒绝任何 BIOS / ROM 类二进制残留
#   4. 提示提交
#
set -euo pipefail

# 配置
ARCADE_SRC="${ARCADE_SRC:-$HOME/projects/arcade_emulator}"
BLOG_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ARCADE_DEST="$BLOG_ROOT/arcade/play"

# 颜色
RED='\033[31m'; GREEN='\033[32m'; YELLOW='\033[33m'; NC='\033[0m'

# 前置检查
if [ ! -d "$ARCADE_SRC" ]; then
  echo -e "${RED}❌ arcade 源码不存在: $ARCADE_SRC${NC}"
  echo "   设置环境变量 ARCADE_SRC 或 clone 到默认路径"
  exit 1
fi
if [ ! -f "$ARCADE_SRC/package.json" ]; then
  echo -e "${RED}❌ $ARCADE_SRC 不像是 arcade 项目（缺 package.json）${NC}"
  exit 1
fi

# 构建
echo -e "${GREEN}==>${NC} 构建 arcade ($ARCADE_SRC)"
cd "$ARCADE_SRC"
if [ ! -d node_modules ]; then
  echo "   安装依赖..."
  npm install --silent
fi
npm run build

# 校验源端 dist
if [ ! -f "$ARCADE_SRC/dist/index.html" ]; then
  echo -e "${RED}❌ 构建失败：dist/index.html 不存在${NC}"
  exit 1
fi

# 同步到博客
echo -e "${GREEN}==>${NC} 同步到 $ARCADE_DEST"
rm -rf "$ARCADE_DEST"
mkdir -p "$ARCADE_DEST"
# 排除可能残留的 BIOS / 旧 emulatorjs 目录（即使源端意外存在也不带过去）
rsync -a \
  --exclude='bios/' \
  --exclude='emulatorjs/' \
  --exclude='*.bios' \
  --exclude='neogeo*' \
  --exclude='scph*.bin' \
  --exclude='gba_bios*' \
  "$ARCADE_SRC/dist/" "$ARCADE_DEST/"

# 安全红线校验（双重保险）
echo -e "${GREEN}==>${NC} 安全红线扫描"
SUSPICIOUS=$(find "$ARCADE_DEST" -type f \( \
  -name '*.zip' -o \
  -name '*.bios' -o \
  -name 'neogeo*' -o \
  -name 'scph*.bin' -o \
  -name 'gba_bios*' \
\) 2>/dev/null || true)
if [ -n "$SUSPICIOUS" ]; then
  echo -e "${RED}❌ 检测到禁止的 BIOS / ROM 类文件，拒绝同步：${NC}"
  echo "$SUSPICIOUS"
  rm -rf "$ARCADE_DEST"
  exit 1
fi

# 体积校验：编译产物应 < 5MB（实际 ~200KB）
SIZE_KB=$(du -sk "$ARCADE_DEST" | awk '{print $1}')
if [ "$SIZE_KB" -gt 5120 ]; then
  echo -e "${YELLOW}⚠️  arcade/ 体积异常: ${SIZE_KB} KB（预期 < 5 MB）${NC}"
  echo "   可能误带了二进制核心，请检查 arcade dist 输出"
  exit 1
fi

# 结果
echo
echo -e "${GREEN}✅ 同步完成${NC}"
echo "   位置：$ARCADE_DEST"
echo "   体积：${SIZE_KB} KB"
echo "   文件："
find "$ARCADE_DEST" -type f | sed "s|$ARCADE_DEST/|     |"
echo
echo "下一步："
echo "   1. 浏览器测试 http://127.0.0.1:4000/arcade/play/（先跑 bundle exec jekyll serve）"
echo "   2. git add arcade/ && git commit -m 'feat(arcade): 同步 arcade vX.Y.Z'"
