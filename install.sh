#!/usr/bin/env bash

# Skills Inventory 快速安装脚本
# 自动将技能安装到各个客户端

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================="
echo "Skills Inventory 安装脚本"
echo "=========================================="
echo ""
echo "当前技能目录: $SKILL_DIR"
echo ""

# 检查必需文件
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo "错误: 未找到 SKILL.md 文件"
    exit 1
fi

if [ ! -f "$SKILL_DIR/skills-manager.sh" ]; then
    echo "错误: 未找到 skills-manager.sh 文件"
    exit 1
fi

# 确保脚本有执行权限
chmod +x "$SKILL_DIR/skills-manager.sh"

echo "选择安装方式:"
echo "1) 符号链接（推荐，便于更新）"
echo "2) 复制文件"
echo ""
read -p "请选择 [1-2]: " install_method

if [ "$install_method" != "1" ] && [ "$install_method" != "2" ]; then
    echo "无效的选择"
    exit 1
fi

echo ""
echo "选择要安装到的客户端:"
echo "1) Claude Code (~/.claude/skills/)"
echo "2) QA-Cowork (~/.qa-cowork/skills/)"
echo "3) OpenClaw (~/.openclaw/skills/)"
echo "4) Cursor (~/.cursor/skills/)"
echo "5) 全部安装"
echo ""
read -p "请选择 [1-5]: " client_choice

install_to_client() {
    local client_name="$1"
    local target_dir="$2"
    local skill_name="skills-inventory"

    # 创建目标目录
    mkdir -p "$target_dir"

    local target_path="$target_dir/$skill_name"

    # 检查是否已存在
    if [ -e "$target_path" ]; then
        echo -e "${YELLOW}⚠ $client_name 中已存在 skills-inventory${NC}"
        read -p "是否覆盖？[y/N]: " overwrite
        if [ "$overwrite" != "y" ] && [ "$overwrite" != "Y" ]; then
            echo "跳过 $client_name"
            return
        fi
        rm -rf "$target_path"
    fi

    # 安装
    if [ "$install_method" = "1" ]; then
        # 符号链接
        ln -s "$SKILL_DIR" "$target_path"
        echo -e "${GREEN}✓ 已创建符号链接到 $client_name${NC}"
    else
        # 复制
        cp -r "$SKILL_DIR" "$target_path"
        echo -e "${GREEN}✓ 已复制到 $client_name${NC}"
    fi
}

# 执行安装
case "$client_choice" in
    1)
        install_to_client "Claude Code" "$HOME/.claude/skills"
        ;;
    2)
        install_to_client "QA-Cowork" "$HOME/.qa-cowork/skills"
        ;;
    3)
        install_to_client "OpenClaw" "$HOME/.openclaw/skills"
        ;;
    4)
        install_to_client "Cursor" "$HOME/.cursor/skills"
        ;;
    5)
        install_to_client "Claude Code" "$HOME/.claude/skills"
        install_to_client "QA-Cowork" "$HOME/.qa-cowork/skills"
        install_to_client "OpenClaw" "$HOME/.openclaw/skills"
        install_to_client "Cursor" "$HOME/.cursor/skills"
        ;;
    *)
        echo "无效的选择"
        exit 1
        ;;
esac

echo ""
echo "=========================================="
echo -e "${GREEN}✓ 安装完成！${NC}"
echo "=========================================="
echo ""
echo "验证安装:"
echo "  $SKILL_DIR/skills-manager.sh list"
echo ""
echo "在 Claude Code 中使用:"
echo '  发送消息: "列出所有技能"'
echo ""
echo "查看更多帮助:"
echo "  cat $SKILL_DIR/README.md"
echo "  cat $SKILL_DIR/EXAMPLES.md"
echo ""
