# Skills Inventory - 技能仓库管理器

统一管理本地所有类 Claude Code 客户端的 skills，包括 Claude Code、OpenClaw、QA-Cowork、Cursor、ClawdBot 等。

## 📋 功能特性

- ✅ **列出所有技能** - 查看本地所有客户端的 skills 清单
- 🔍 **搜索技能** - 根据名称或关键词搜索技能
- 📂 **打开技能** - 快速打开技能的 SKILL.md 文件查看或编辑
- 🗑️ **删除技能** - 安全删除指定的技能（支持自动备份）
- 📊 **统计分析** - 各客户端的技能数量统计

## 🚀 快速开始

### 在 Claude Code 中使用

直接向 Claude 发送指令：

```
列出所有技能
搜索 browser 相关的技能
打开 agent-browser 技能
删除 test-skill 技能
```

### 使用命令行脚本

```bash
# 列出所有技能
~/ai/skills-inventory/skills-manager.sh list

# 搜索技能
~/ai/skills-inventory/skills-manager.sh search browser

# 查看技能信息
~/ai/skills-inventory/skills-manager.sh info agent-browser

# 查找技能路径
~/ai/skills-inventory/skills-manager.sh find agent-browser

# 删除技能（带备份）
~/ai/skills-inventory/skills-manager.sh delete test-skill true

# 删除技能（不备份）
~/ai/skills-inventory/skills-manager.sh delete test-skill false
```

## 📦 支持的客户端

| 客户端 | 目录 | 说明 |
|--------|------|------|
| Claude Code | `~/.claude/skills/` | 官方 CLI 工具 |
| QA-Cowork (hot) | `~/.qa-cowork/hot-update/resources/skills/` | 小美搭档热更新 |
| QA-Cowork (main) | `~/.qa-cowork/skills/` | 小美搭档主要技能 |
| Cursor | `~/.cursor/skills/` | Cursor 编辑器 |
| ClawdBot | `~/.nvm/.../clawdbot/skills/` | ClawdBot 服务集成 |
| Trae-CN | `~/.trae-cn/skills/` | Trae 中文版 |
| .agents | `~/.agents/skills/` | Agent 系统核心 |
| OpenClaw (home) | `~/.openclaw/skills/` | OpenClaw 主目录 |
| OpenClaw (app) | `~/Library/Application Support/automan-desktop/openclaw/.openclaw/skills/` | OpenClaw 应用程序 |

## 🛡️ 安全措施

1. **删除前确认** - 必须用户明确确认才能删除
2. **自动备份** - 默认将删除的技能备份到 `~/.trash/skills/`
3. **防止误删** - 系统内置技能（如 GitLens）不允许删除
4. **路径验证** - 验证技能路径是否在已知目录中

## 📝 使用示例

### 示例 1: 查看所有技能

**用户**: "列出所有技能"

**输出**:
```
==========================================
本地所有 Skills 清单
==========================================

📦 claude-code: 20 个
📦 qa-cowork-hot: 38 个
📦 qa-cowork-main: 54 个
...

总计: 233 个 skills
```

### 示例 2: 搜索技能

**用户**: "搜索 browser 相关的技能"

**输出**:
```
🔍 搜索关键词: browser
==========================================

📦 claude-code
  • agent-browser
  • intranet-browser

📦 qa-cowork-main
  • agent-browser
  • chrome-bridge-automation
```

### 示例 3: 查看技能内容

**用户**: "打开 agent-browser 技能"

Claude 会自动使用 Read 工具读取 `SKILL.md` 并显示内容。

### 示例 4: 删除技能

**用户**: "删除 test-skill 技能"

**流程**:
1. Claude 显示技能信息
2. 询问: "确认删除吗？"
3. 询问: "是否需要备份？（推荐：是）"
4. 执行删除并显示结果

## 🔧 配置文件

### config.json

包含所有支持的客户端目录配置，可以根据需要修改：

```json
{
  "skillsDirectories": {
    "claude-code": {
      "name": "Claude Code",
      "paths": ["~/.claude/skills"],
      "canDelete": true
    },
    ...
  }
}
```

### skills-manager.sh

命令行管理脚本，支持以下命令：

- `list` - 列出所有技能
- `search <keyword>` - 搜索技能
- `find <skill_name>` - 查找技能路径
- `info <skill_name>` - 显示技能信息
- `delete <skill_name> <backup>` - 删除技能

## 📂 备份位置

删除的技能自动备份到：`~/.trash/skills/时间戳_技能名称/`

例如：`~/.trash/skills/20260320_143000_test-skill/`

## ⚠️ 注意事项

1. **系统内置技能不要删除** - 如 Cursor GitLens、Trae 的内置 skills
2. **删除前先查看** - 建议先用 "打开 XXX 技能" 查看内容
3. **定期清理备份** - 备份文件会占用磁盘空间
4. **谨慎使用删除** - 删除操作虽然有备份，但恢复需要手动操作

## 🔄 恢复已删除的技能

如果需要恢复已删除的技能：

```bash
# 查看备份
ls -la ~/.trash/skills/

# 恢复技能（示例）
cp -r ~/.trash/skills/20260320_143000_test-skill \
      ~/.claude/skills/test-skill
```

## 📚 相关文件

- `SKILL.md` - 技能定义文件（Claude Code 识别）
- `config.json` - 配置文件
- `skills-manager.sh` - 命令行管理脚本
- `README.md` - 本文档

## 🤝 贡献

如果需要添加新的客户端支持，请修改：

1. `config.json` - 添加新的目录配置
2. `skills-manager.sh` - 更新 `SKILL_DIRS` 数组
3. `SKILL.md` - 更新支持的客户端列表

## 📄 许可

MIT License

---

**作者**: 小美助手
**版本**: 1.0.0
**更新时间**: 2026-03-20
