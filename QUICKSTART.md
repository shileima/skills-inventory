# Skills Inventory - 快速开始

## 🚀 5 分钟快速上手

### 第一步：安装技能

#### 方法 A: 使用安装脚本（推荐）

```bash
cd ~/ai/skills-inventory
./install.sh
```

按提示选择：
1. 选择 `1` (符号链接，推荐)
2. 选择安装到哪个客户端（或选择 `5` 全部安装）

#### 方法 B: 手动安装

```bash
# 安装到 Claude Code
ln -s ~/ai/skills-inventory ~/.claude/skills/skills-inventory
```

### 第二步：验证安装

```bash
~/ai/skills-inventory/skills-manager.sh list
```

应该看到所有技能的列表。

### 第三步：在 Claude Code 中使用

启动 Claude Code，发送以下消息：

```
列出所有技能
```

如果 Claude 正确显示技能列表，说明安装成功！✅

## 📝 常用命令

### 在 Claude Code 中

| 命令 | 说明 |
|------|------|
| "列出所有技能" | 查看所有技能清单 |
| "搜索 browser 技能" | 搜索包含 browser 的技能 |
| "打开 docx 技能" | 查看 docx 技能的内容 |
| "删除 test-skill 技能" | 删除指定技能（会确认） |

### 在终端中

```bash
# 列出所有技能
~/ai/skills-inventory/skills-manager.sh list

# 搜索技能
~/ai/skills-inventory/skills-manager.sh search pdf

# 查看技能信息
~/ai/skills-inventory/skills-manager.sh info docx

# 查找技能路径
~/ai/skills-inventory/skills-manager.sh find agent-browser
```

## 📚 进一步学习

- [README.md](README.md) - 完整功能介绍
- [EXAMPLES.md](EXAMPLES.md) - 详细使用示例
- [INSTALL.md](INSTALL.md) - 详细安装指南

## 🎯 实用技巧

### 1. 快速搜索
```bash
# 创建别名（添加到 ~/.zshrc 或 ~/.bashrc）
alias skills='~/ai/skills-inventory/skills-manager.sh'

# 使用
skills list
skills search browser
```

### 2. 查看特定客户端的技能
```
查看 Claude Code 的所有 skills
```

### 3. 清理重复技能
```
搜索 test 相关的技能，帮我清理一下
```

## ⚠️ 注意事项

1. ❌ **不要删除系统内置技能**（如 GitLens skills）
2. ✅ **删除前先查看内容**（使用 "打开 XXX 技能"）
3. ✅ **删除时选择备份**（默认备份到 `~/.trash/skills/`）

## 🆘 遇到问题？

1. 检查安装：`ls -la ~/.claude/skills/skills-inventory/`
2. 测试脚本：`~/ai/skills-inventory/skills-manager.sh list`
3. 在 Claude Code 中询问："skills-inventory 技能如何使用？"

---

**准备好了？开始管理你的 233+ 个技能吧！** 🎉
