#!/usr/bin/env bash
#
# AI News Card — Skill 安装脚本
#
# 用法：
#   ./skill/install.sh                    # 安装到 ~/.hermes/skills/
#   ./skill/install.sh /custom/skill/dir   # 安装到指定目录
#
set -e

# 获取项目根目录
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_SOURCE="$PROJECT_DIR/skill/SKILL.md"

# 目标目录
TARGET_BASE="${1:-$HOME/.hermes/skills}"
TARGET_DIR="$TARGET_BASE/ai-news-card"

# 检查源文件
if [ ! -f "$SKILL_SOURCE" ]; then
  echo "❌ 找不到 skill/SKILL.md，请在项目根目录运行此脚本"
  exit 1
fi

# 创建目标目录
mkdir -p "$TARGET_DIR"

# 复制 SKILL.md
cp "$SKILL_SOURCE" "$TARGET_DIR/SKILL.md"

# 如果项目不在 node_modules 里，创建一个指向项目根目录的指针文件
echo "$PROJECT_DIR" > "$TARGET_DIR/project-path.txt"

echo "✅ Skill 已安装到: $TARGET_DIR"
echo ""
echo "📋 接下来："
echo "  1. 确保已安装项目依赖："
echo "     cd $PROJECT_DIR && npm install && npx playwright install chromium"
echo "  2. 重启你的 AI Agent，skill 即可使用"
echo ""
echo "💡 Skill 中的脚本路径指向: $PROJECT_DIR"
