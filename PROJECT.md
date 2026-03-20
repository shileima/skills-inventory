# Skills Inventory - 项目总览

## 📁 项目结构

```
~/ai/skills-inventory/
├── SKILL.md              # ⭐ 技能定义文件（Claude Code 识别）
├── README.md             # 📖 完整功能介绍和使用指南
├── QUICKSTART.md         # 🚀 5分钟快速开始指南
├── EXAMPLES.md           # 📝 详细使用示例
├── INSTALL.md            # 💿 详细安装指南
├── PROJECT.md            # 📋 本文档 - 项目总览
├── VERSION               # 🔖 版本信息和更新日志
├── config.json           # ⚙️ 配置文件（客户端目录定义）
├── skills-manager.sh     # 🔧 核心管理脚本（可执行）
└── install.sh            # 📦 快速安装脚本（可执行）
```

## 🎯 项目目标

统一管理本地所有类 Claude Code 客户端的 skills，包括：
- Claude Code
- QA-Cowork (小美搭档)
- OpenClaw
- Cursor
- ClawdBot
- Trae-CN
- .agents

**总计管理 233+ 个技能** 🚀

## 🔑 核心功能

| 功能 | 说明 | 实现方式 |
|------|------|----------|
| 📋 列出技能 | 显示所有客户端的技能清单 | `skills-manager.sh list` |
| 🔍 搜索技能 | 根据关键词搜索技能 | `skills-manager.sh search <keyword>` |
| 📂 打开技能 | 查看技能的 SKILL.md 内容 | Read 工具 + `find` 命令 |
| 🗑️ 删除技能 | 安全删除技能（支持备份） | `skills-manager.sh delete <name> <backup>` |
| 📊 统计分析 | 各客户端技能数量统计 | 自动统计 |

## 🛠️ 技术实现

### 1. 核心脚本 (skills-manager.sh)

**语言**: Bash (兼容 macOS 默认 bash 3.x)

**主要函数**:
- `list_all_skills()` - 列出所有技能
- `search_skill()` - 搜索技能
- `find_skill_path()` - 查找技能路径
- `get_skill_info()` - 获取技能信息
- `delete_skill()` - 删除技能

**数据结构**:
```bash
SKILL_DIRS_KEYS=(...)      # 客户端名称数组
SKILL_DIRS_VALUES=(...)    # 对应的目录路径数组
```

### 2. 技能定义 (SKILL.md)

**格式**: YAML Front Matter + Markdown

**结构**:
```yaml
---
name: skills-inventory
description: 管理本地所有 Claude Code 类客户端的 skills
version: 1.0.0
author: 小美助手
tags: [skills, management, claude-code]
---

# 技能说明文档
...
```

### 3. Claude Code 集成

当用户发送指令时，Claude Code 会：
1. 识别用户意图（列出/搜索/打开/删除）
2. 调用相应的工具（Bash/Read/AskUserQuestion）
3. 执行 skills-manager.sh 脚本
4. 处理输出并友好地展示给用户

## 📊 支持的客户端

| 客户端 | 目录 | Skills 数量 | 可删除 |
|--------|------|------------|--------|
| Claude Code | `~/.claude/skills/` | 20 | ✅ |
| QA-Cowork (hot) | `~/.qa-cowork/hot-update/resources/skills/` | 38 | ✅ |
| QA-Cowork (main) | `~/.qa-cowork/skills/` | 54 | ✅ |
| Cursor | `~/.cursor/skills/` | 4 | ✅ |
| Cursor GitLens | `~/.cursor/extensions/*/​.claude/skills/` | 11 | ❌ |
| ClawdBot | `~/.nvm/.../clawdbot/skills/` | 52 | ✅ |
| Trae | `~/.trae/extensions/*/​.claude/skills/` | 20 | ❌ |
| Trae-CN | `~/.trae-cn/skills/` | 2 | ✅ |
| .agents | `~/.agents/skills/` | 4 | ✅ |
| OpenClaw (home) | `~/.openclaw/skills/` | 9 | ✅ |
| OpenClaw (app) | `~/Library/Application Support/automan-desktop/openclaw/.openclaw/skills/` | 50 | ✅ |

**总计**: 264 个 skills (去重后约 233 个)

## 🔒 安全特性

### 1. 删除保护
- ❌ 系统内置技能不允许删除（通过 `canDelete: false` 标记）
- ✅ 删除前必须用户确认（通过 AskUserQuestion）
- ✅ 支持自动备份（默认到 `~/.trash/skills/`）

### 2. 路径验证
- ✅ 只能操作已知目录中的技能
- ✅ 防止路径遍历攻击
- ✅ 验证技能目录存在性

### 3. 备份机制
```bash
# 备份格式
~/.trash/skills/时间戳_技能名称/

# 示例
~/.trash/skills/20260320_143000_test-skill/
```

## 🔄 工作流程

### 列出技能流程
```
用户: "列出所有技能"
  ↓
Claude 识别意图
  ↓
执行: skills-manager.sh list
  ↓
展示: 格式化的技能列表
```

### 搜索技能流程
```
用户: "搜索 browser 技能"
  ↓
Claude 提取关键词: "browser"
  ↓
执行: skills-manager.sh search browser
  ↓
展示: 匹配的技能列表（按客户端分组）
```

### 打开技能流程
```
用户: "打开 docx 技能"
  ↓
Claude 执行: skills-manager.sh find docx
  ↓
如果找到多个 → 询问用户选择
如果找到一个 → 使用 Read 工具读取
  ↓
展示: SKILL.md 完整内容
```

### 删除技能流程
```
用户: "删除 test-skill 技能"
  ↓
Claude 执行: skills-manager.sh find test-skill
  ↓
显示技能信息
  ↓
询问: "确认删除吗？" (AskUserQuestion)
  ↓
如果确认 → 询问: "是否备份？"
  ↓
执行: skills-manager.sh delete test-skill true/false
  ↓
展示: 删除结果和备份位置
```

## 📝 配置文件说明

### config.json
```json
{
  "skillsDirectories": {
    "client-id": {
      "name": "显示名称",
      "paths": ["目录路径"],
      "icon": "图标",
      "description": "说明",
      "canDelete": true/false
    }
  },
  "backupDirectory": "~/.trash/skills",
  "searchPatterns": ["*/SKILL.md"]
}
```

## 🚀 扩展开发

### 添加新客户端支持

1. 编辑 `skills-manager.sh`:
```bash
SKILL_DIRS_KEYS+=(
    "new-client"
)

SKILL_DIRS_VALUES+=(
    "$HOME/.new-client/skills"
)
```

2. 编辑 `config.json`:
```json
{
  "skillsDirectories": {
    "new-client": {
      "name": "New Client",
      "paths": ["~/.new-client/skills"],
      "canDelete": true
    }
  }
}
```

### 添加新功能

在 `skills-manager.sh` 中添加新函数：
```bash
# 新功能
my_new_feature() {
    local param="$1"
    # 实现逻辑
}

# 在 main 函数中添加
case "$command" in
    my-feature)
        my_new_feature "$@"
        ;;
    ...
esac
```

## 📦 版本管理

### 当前版本
**v1.0.0** (2026-03-20)

### 版本号规则
- **主版本号**: 重大架构变更或不兼容更新
- **次版本号**: 新功能添加
- **修订号**: Bug 修复和小改进

### 更新日志
参见 `VERSION` 文件

## 🧪 测试

### 功能测试
```bash
# 测试列出功能
~/ai/skills-inventory/skills-manager.sh list

# 测试搜索功能
~/ai/skills-inventory/skills-manager.sh search test

# 测试查找功能
~/ai/skills-inventory/skills-manager.sh find docx

# 测试信息查看
~/ai/skills-inventory/skills-manager.sh info docx
```

### Claude Code 集成测试
```
列出所有技能
搜索 browser 技能
打开 docx 技能
```

## 📚 文档导航

| 文档 | 用途 | 适合人群 |
|------|------|----------|
| [QUICKSTART.md](QUICKSTART.md) | 5分钟快速上手 | 新用户 |
| [README.md](README.md) | 完整功能介绍 | 所有用户 |
| [EXAMPLES.md](EXAMPLES.md) | 详细使用示例 | 进阶用户 |
| [INSTALL.md](INSTALL.md) | 详细安装指南 | 管理员 |
| [PROJECT.md](PROJECT.md) | 项目技术文档 | 开发者 |

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

### 贡献指南
1. Fork 项目
2. 创建特性分支
3. 提交更改
4. 发起 Pull Request

## 📄 许可证

MIT License

## 👥 作者

**小美助手** - 美团 QA AI 团队

## 🙏 致谢

感谢以下项目和工具：
- Claude Code - Anthropic 官方 CLI
- OpenClaw - 开源 AI 助手
- QA-Cowork (小美搭档) - 美团内部工具

---

**最后更新**: 2026-03-20
**项目状态**: ✅ 稳定版本
**维护状态**: 🟢 积极维护中
