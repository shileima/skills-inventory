# Skills Inventory

> 统一管理本地所有 Claude Code 类客户端的技能 - 查看、搜索、打开、删除，一个技能全搞定！

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/shileima/skills-inventory)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](https://github.com/shileima/skills-inventory)

## 🎯 项目简介

**Skills Inventory** 是一个强大的技能仓库管理器，可以统一管理本地所有类 Claude Code 客户端的 skills，包括：

- 🤖 **Claude Code** - Anthropic 官方 CLI
- 🦞 **OpenClaw** - 开源 AI 助手
- ✏️ **Cursor** - AI 代码编辑器
- 🤖 **ClawdBot** - 服务集成工具
- 🎯 **Trae/Trae-CN** - AI 编辑器
- 🔮 **.agents** - Agent 系统

**总计可管理 233+ 个技能！**

## ✨ 核心功能

| 功能 | 说明 | 示例 |
|------|------|------|
| 📋 **列出技能** | 查看所有客户端的技能清单 | `skills list` |
| 🔍 **搜索技能** | 根据关键词搜索技能 | `skills search browser` |
| 📂 **打开技能** | 查看技能的 SKILL.md 内容 | 在 Claude 中："打开 docx 技能" |
| 🗑️ **删除技能** | 安全删除技能（支持备份） | `skills delete test-skill true` |
| 📊 **统计分析** | 各客户端技能数量统计 | 自动统计 |

## 🚀 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/shileima/skills-inventory.git
cd skills-inventory

# 运行安装脚本
./install.sh
```

按提示选择：
1. 选择安装方式（推荐：符号链接）
2. 选择目标客户端（或选择全部安装）

### 验证安装

```bash
# 测试脚本
./skills-manager.sh list

# 应该看到类似输出：
# ==========================================
# 本地所有 Skills 清单
# ==========================================
#
# 📦 claude-code: 20 个
# 📦 qa-cowork-main: 54 个
# ...
# 总计: 233 个 skills
```

### 基本使用

#### 在终端中使用

```bash
# 列出所有技能
./skills-manager.sh list

# 搜索技能
./skills-manager.sh search browser

# 查看技能信息
./skills-manager.sh info docx

# 查找技能路径
./skills-manager.sh find agent-browser

# 删除技能（带备份）
./skills-manager.sh delete test-skill true
```

#### 在 Claude Code 中使用

安装完成后，直接向 Claude 发送自然语言指令：

```
列出所有技能
搜索 browser 相关的技能
打开 agent-browser 技能
删除 test-skill 技能
```

## 📖 详细文档

| 文档 | 说明 |
|------|------|
| [QUICKSTART.md](QUICKSTART.md) | 5分钟快速上手指南 |
| [INSTALL.md](INSTALL.md) | 详细安装步骤和配置 |
| [EXAMPLES.md](EXAMPLES.md) | 丰富的使用示例 |
| [PROJECT.md](PROJECT.md) | 技术文档和架构设计 |

## 🎬 使用示例

### 示例 1: 查看所有技能

```bash
$ ./skills-manager.sh list

==========================================
本地所有 Skills 清单
==========================================

📦 claude-code: 20 个
📦 qa-cowork-hot: 38 个
📦 qa-cowork-main: 54 个
📦 cursor: 4 个
📦 clawdbot: 52 个
...

总计: 233 个 skills
```

### 示例 2: 搜索技能

```bash
$ ./skills-manager.sh search browser

🔍 搜索关键词: browser
==========================================

📦 claude-code
  • agent-browser
  • intranet-browser

📦 qa-cowork-main
  • agent-browser
  • chrome-bridge-automation
```

### 示例 3: 在 Claude Code 中管理

**用户**: "搜索 pdf 相关的技能"

**Claude 输出**:
```
找到以下 PDF 相关技能：

📦 Claude Code
  • pdf

📦 QA-Cowork
  • pdf
  • nano-pdf
  • extract-pdf-text

📦 OpenClaw
  • pdf

共找到 5 个匹配的技能
```

## 🛡️ 安全特性

- ✅ **删除前确认** - 必须用户明确确认才能删除
- ✅ **自动备份** - 默认将删除的技能备份到 `~/.trash/skills/`
- ✅ **系统保护** - 防止误删系统内置技能（如 GitLens）
- ✅ **路径验证** - 验证技能路径是否在已知目录中

## 📦 支持的客户端

| 客户端 | 目录 | Skills 数量 |
|--------|------|------------|
| Claude Code | `~/.claude/skills/` | ~20 |
| QA-Cowork (hot) | `~/.qa-cowork/hot-update/resources/skills/` | ~38 |
| QA-Cowork (main) | `~/.qa-cowork/skills/` | ~54 |
| Cursor | `~/.cursor/skills/` | ~4 |
| ClawdBot | `~/.nvm/.../clawdbot/skills/` | ~52 |
| Trae-CN | `~/.trae-cn/skills/` | ~2 |
| .agents | `~/.agents/skills/` | ~4 |
| OpenClaw (home) | `~/.openclaw/skills/` | ~9 |
| OpenClaw (app) | `~/Library/Application Support/.../skills/` | ~50 |

## 🔧 配置

### 添加新客户端

编辑 `skills-manager.sh`，在 `SKILL_DIRS_KEYS` 和 `SKILL_DIRS_VALUES` 数组中添加：

```bash
SKILL_DIRS_KEYS+=(
    "your-client"
)

SKILL_DIRS_VALUES+=(
    "$HOME/.your-client/skills"
)
```

### 修改备份目录

编辑 `skills-manager.sh`，修改 `BACKUP_DIR` 变量：

```bash
BACKUP_DIR="$HOME/your-backup-dir"
```

## 💡 实用技巧

### 创建命令别名

```bash
# 添加到 ~/.zshrc 或 ~/.bashrc
alias skills='~/skills-inventory/skills-manager.sh'

# 使用
skills list
skills search pdf
```

### 定期维护

```bash
# 每月清理旧备份
ls -la ~/.trash/skills/
rm -rf ~/.trash/skills/2026* # 清理旧备份
```

### 批量操作

```bash
# 查找所有测试技能
./skills-manager.sh search test

# 在 Claude Code 中批量清理
# "搜索 test 相关的技能，帮我清理一下"
```

## 🚨 故障排除

### 问题 1: 脚本没有执行权限

```bash
chmod +x skills-manager.sh
chmod +x install.sh
```

### 问题 2: Claude 无法识别技能

检查 SKILL.md 是否在正确的目录中：

```bash
ls -la ~/.claude/skills/skills-inventory/SKILL.md
```

### 问题 3: macOS bash 版本过低

使用 bash 明确指定：

```bash
bash skills-manager.sh list
```

或安装新版本 bash：

```bash
brew install bash
```

## 📊 项目统计

- **代码行数**: ~2200 行
- **支持客户端**: 9 种
- **管理技能**: 233+ 个
- **文档覆盖**: 100%

## 🎯 后续计划

### v1.1
- [ ] 添加技能导出功能
- [ ] 支持批量删除
- [ ] 改进搜索算法（模糊搜索）

### v1.2
- [ ] Web UI 界面
- [ ] 技能依赖分析
- [ ] 使用统计

### v2.0
- [ ] 技能市场集成
- [ ] 云端同步
- [ ] 团队协作

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

### 贡献步骤

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情


## 🙏 致谢

感谢以下项目和工具：

- [Claude Code](https://www.anthropic.com) - Anthropic 官方 CLI
- [OpenClaw](https://github.com/openclaw) - 开源 AI 助手

## ⭐ Star History

如果这个项目对你有帮助，请给个 Star ⭐️

## 📞 联系方式

- GitHub: [@shileima](https://github.com/shileima)
- 项目 Issues: [提交问题](https://github.com/shileima/skills-inventory/issues)

---

**开始管理你的技能吧！** 🚀

Made with ❤️ by mashilei
