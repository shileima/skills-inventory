#!/usr/bin/env bash

# Skills Inventory Manager
# 技能仓库管理脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 备份目录
BACKUP_DIR="$HOME/.trash/skills"

# 技能目录列表（使用数组存储键值对）
SKILL_DIRS_KEYS=(
    "claude-code"
    "qa-cowork-hot"
    "qa-cowork-main"
    "cursor"
    "clawdbot"
    "trae-cn"
    "agents"
    "openclaw-home"
    "openclaw-app"
)

SKILL_DIRS_VALUES=(
    "$HOME/.claude/skills"
    "$HOME/.qa-cowork/hot-update/resources/skills"
    "$HOME/.qa-cowork/skills"
    "$HOME/.cursor/skills"
    "$HOME/.nvm/versions/node/v20.19.6/lib/node_modules/clawdbot/skills"
    "$HOME/.trae-cn/skills"
    "$HOME/.agents/skills"
    "$HOME/.openclaw/skills"
    "$HOME/Library/Application Support/automan-desktop/openclaw/.openclaw/skills"
)

# 获取目录路径的辅助函数
get_skill_dir() {
    local key="$1"
    for i in "${!SKILL_DIRS_KEYS[@]}"; do
        if [ "${SKILL_DIRS_KEYS[$i]}" = "$key" ]; then
            echo "${SKILL_DIRS_VALUES[$i]}"
            return 0
        fi
    done
    return 1
}

# 功能：列出所有技能
list_all_skills() {
    echo "=========================================="
    echo "本地所有 Skills 清单"
    echo "=========================================="
    echo ""

    local total=0

    for i in "${!SKILL_DIRS_KEYS[@]}"; do
        local client="${SKILL_DIRS_KEYS[$i]}"
        local dir="${SKILL_DIRS_VALUES[$i]}"
        if [ -d "$dir" ]; then
            local count=$(ls -1 "$dir" 2>/dev/null | grep -v "^\." | wc -l | tr -d ' ')
            total=$((total + count))
            echo "📦 $client: $count 个"
        fi
    done

    echo ""
    echo "总计: $total 个 skills"
}

# 功能：搜索技能
search_skill() {
    local keyword="$1"
    if [ -z "$keyword" ]; then
        echo -e "${RED}错误: 请提供搜索关键词${NC}"
        return 1
    fi

    echo "🔍 搜索关键词: $keyword"
    echo "=========================================="

    local found=0

    for i in "${!SKILL_DIRS_KEYS[@]}"; do
        local client="${SKILL_DIRS_KEYS[$i]}"
        local dir="${SKILL_DIRS_VALUES[$i]}"
        if [ -d "$dir" ]; then
            local results=$(ls -1 "$dir" 2>/dev/null | grep -i "$keyword" || true)
            if [ -n "$results" ]; then
                echo ""
                echo -e "${BLUE}📦 $client${NC}"
                echo "$results" | while read skill; do
                    echo "  • $skill"
                    found=$((found + 1))
                done
            fi
        fi
    done

    if [ $found -eq 0 ]; then
        echo -e "${YELLOW}未找到匹配的技能${NC}"
    fi
}

# 功能：查找技能路径
find_skill_path() {
    local skill_name="$1"
    local results=()

    for i in "${!SKILL_DIRS_KEYS[@]}"; do
        local client="${SKILL_DIRS_KEYS[$i]}"
        local dir="${SKILL_DIRS_VALUES[$i]}"
        if [ -d "$dir/$skill_name" ]; then
            results+=("$client|$dir/$skill_name")
        fi
    done

    printf '%s\n' "${results[@]}"
}

# 功能：删除技能
delete_skill() {
    local skill_name="$1"
    local backup="$2"

    if [ -z "$skill_name" ]; then
        echo -e "${RED}错误: 请提供技能名称${NC}"
        return 1
    fi

    # 查找技能
    local paths=($(find_skill_path "$skill_name"))

    if [ ${#paths[@]} -eq 0 ]; then
        echo -e "${RED}错误: 未找到技能 '$skill_name'${NC}"
        return 1
    fi

    # 如果找到多个，列出所有
    if [ ${#paths[@]} -gt 1 ]; then
        echo -e "${YELLOW}找到多个同名技能:${NC}"
        for i in "${!paths[@]}"; do
            IFS='|' read -r client path <<< "${paths[$i]}"
            echo "  $((i+1)). $client: $path"
        done
        echo ""
        echo "请在 Claude 中指定要删除哪一个"
        return 1
    fi

    # 解析路径
    IFS='|' read -r client skill_path <<< "${paths[0]}"

    echo -e "${BLUE}找到技能:${NC}"
    echo "  客户端: $client"
    echo "  路径: $skill_path"
    echo ""

    # 备份
    if [ "$backup" = "true" ]; then
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup_path="$BACKUP_DIR/${timestamp}_${skill_name}"

        mkdir -p "$BACKUP_DIR"
        cp -r "$skill_path" "$backup_path"

        echo -e "${GREEN}✓ 已备份到: $backup_path${NC}"
    fi

    # 删除
    rm -rf "$skill_path"

    if [ ! -d "$skill_path" ]; then
        echo -e "${GREEN}✓ 技能已成功删除${NC}"
        return 0
    else
        echo -e "${RED}✗ 删除失败${NC}"
        return 1
    fi
}

# 功能：获取技能信息
get_skill_info() {
    local skill_name="$1"

    if [ -z "$skill_name" ]; then
        echo -e "${RED}错误: 请提供技能名称${NC}"
        return 1
    fi

    # 查找技能
    local paths=($(find_skill_path "$skill_name"))

    if [ ${#paths[@]} -eq 0 ]; then
        echo -e "${RED}错误: 未找到技能 '$skill_name'${NC}"
        return 1
    fi

    echo "=========================================="
    echo "技能信息: $skill_name"
    echo "=========================================="
    echo ""

    for path_info in "${paths[@]}"; do
        IFS='|' read -r client skill_path <<< "$path_info"

        echo -e "${BLUE}客户端:${NC} $client"
        echo -e "${BLUE}路径:${NC} $skill_path"

        if [ -f "$skill_path/SKILL.md" ]; then
            echo -e "${BLUE}SKILL.md:${NC} 存在"
            echo ""
            echo "--- 文件内容预览 (前 20 行) ---"
            head -20 "$skill_path/SKILL.md"
        else
            echo -e "${YELLOW}SKILL.md: 不存在${NC}"
        fi

        echo ""
        echo "=========================================="
        echo ""
    done
}

# 主函数
main() {
    local command="$1"
    shift

    case "$command" in
        list)
            list_all_skills
            ;;
        search)
            search_skill "$@"
            ;;
        find)
            find_skill_path "$@"
            ;;
        info)
            get_skill_info "$@"
            ;;
        delete)
            delete_skill "$@"
            ;;
        *)
            echo "用法: $0 {list|search|find|info|delete} [参数]"
            echo ""
            echo "命令:"
            echo "  list                  - 列出所有技能"
            echo "  search <keyword>      - 搜索技能"
            echo "  find <skill_name>     - 查找技能路径"
            echo "  info <skill_name>     - 显示技能信息"
            echo "  delete <skill_name> [backup]  - 删除技能 (backup=true/false)"
            exit 1
            ;;
    esac
}

main "$@"
