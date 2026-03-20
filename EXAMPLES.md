# Skills Inventory 使用示例

本文档提供了 skills-inventory 技能的详细使用示例。

## 📋 示例 1: 列出所有技能

### 用户请求
```
列出所有技能
```

或

```
查看本地所有 skills
```

### Claude 执行
```bash
~/ai/skills-inventory/skills-manager.sh list
```

### 输出示例
```
==========================================
本地所有 Skills 清单
==========================================

📦 claude-code: 20 个
📦 qa-cowork-hot: 38 个
📦 qa-cowork-main: 54 个
📦 cursor: 4 个
📦 clawdbot: 52 个
📦 trae-cn: 2 个
📦 agents: 4 个
📦 openclaw-home: 9 个
📦 openclaw-app: 50 个

总计: 233 个 skills
```

---

## 🔍 示例 2: 搜索技能

### 用户请求
```
搜索 browser 相关的技能
```

或

```
找一下有关 pdf 的 skills
```

### Claude 执行
```bash
~/ai/skills-inventory/skills-manager.sh search browser
```

### 输出示例
```
🔍 搜索关键词: browser
==========================================

📦 claude-code
  • agent-browser
  • intranet-browser

📦 qa-cowork-main
  • agent-browser
  • intranet-browser
  • openbrowser

📦 trae-cn
  • browser-automation
```

---

## 📂 示例 3: 查看技能详情

### 用户请求
```
打开 agent-browser 技能
```

或

```
查看 docx 技能的内容
```

### Claude 执行步骤

1. **查找技能路径**
```bash
~/ai/skills-inventory/skills-manager.sh find agent-browser
```

2. **使用 Read 工具读取 SKILL.md**
```
Read tool: /Users/shilei/.claude/skills/agent-browser/SKILL.md
```

3. **显示内容**

Claude 会显示完整的 SKILL.md 内容。

### 处理多个同名技能

如果找到多个同名技能（例如 agent-browser 在多个客户端都有），Claude 会：

1. 列出所有匹配的技能
2. 询问用户要查看哪一个

**询问示例**：
```
找到 3 个 agent-browser 技能：
1. claude-code - ~/.claude/skills/agent-browser
2. qa-cowork-hot - ~/.qa-cowork/hot-update/resources/skills/agent-browser
3. qa-cowork-main - ~/.qa-cowork/skills/agent-browser

请问您想查看哪一个？
```

---

## 🗑️ 示例 4: 删除技能

### 用户请求
```
删除 test-skill 技能
```

### Claude 执行流程

#### 步骤 1: 查找技能
```bash
~/ai/skills-inventory/skills-manager.sh find test-skill
```

#### 步骤 2: 显示技能信息
```
找到技能:
  客户端: claude-code
  路径: /Users/shilei/.claude/skills/test-skill
```

#### 步骤 3: 询问用户确认
使用 AskUserQuestion 工具：
```
确认要删除 test-skill 技能吗？
选项:
  • 是，删除 (推荐备份)
  • 否，取消
```

#### 步骤 4: 询问是否备份
如果用户确认删除：
```
是否需要备份？（删除前会自动备份到 ~/.trash/skills/）
选项:
  • 是，备份后删除 (推荐)
  • 否，直接删除
```

#### 步骤 5: 执行删除
```bash
# 带备份
~/ai/skills-inventory/skills-manager.sh delete test-skill true

# 不备份
~/ai/skills-inventory/skills-manager.sh delete test-skill false
```

#### 步骤 6: 显示结果
```
✓ 已备份到: ~/.trash/skills/20260320_143000_test-skill
✓ 技能已成功删除
```

---

## 🔍 示例 5: 查看技能信息

### 用户请求
```
查看 docx 技能的信息
```

### Claude 执行
```bash
~/ai/skills-inventory/skills-manager.sh info docx
```

### 输出示例
```
==========================================
技能信息: docx
==========================================

客户端: claude-code
路径: /Users/shilei/.claude/skills/docx
SKILL.md: 存在

--- 文件内容预览 (前 20 行) ---
---
name: docx
description: Comprehensive document creation, editing...
---

# Document Management

[内容预览...]

==========================================

客户端: qa-cowork-main
路径: /Users/shilei/.qa-cowork/skills/docx
SKILL.md: 存在

--- 文件内容预览 (前 20 行) ---
...
```

---

## 📊 示例 6: 复杂场景 - 清理重复技能

### 用户请求
```
我发现有 3 个 agent-browser 技能，帮我看看哪个是最新的，把旧的删掉
```

### Claude 执行流程

#### 步骤 1: 搜索技能
```bash
~/ai/skills-inventory/skills-manager.sh search agent-browser
```

#### 步骤 2: 逐个查看信息
```bash
~/ai/skills-inventory/skills-manager.sh info agent-browser
```

#### 步骤 3: 分析并建议

Claude 会读取每个技能的内容，比较：
- 版本号（如果有）
- 最后修改时间
- 功能描述

然后给出建议：
```
我查看了 3 个 agent-browser 技能：

1. claude-code (20 行) - 最新版本，功能最完整
2. qa-cowork-hot (15 行) - 旧版本，功能较少
3. qa-cowork-main (15 行) - 同 qa-cowork-hot

建议：保留 claude-code 的版本，删除其他两个。

是否继续删除？
```

#### 步骤 4: 执行删除

用户确认后，逐个删除：
```bash
~/ai/skills-inventory/skills-manager.sh delete agent-browser true
# 选择 qa-cowork-hot 版本删除

~/ai/skills-inventory/skills-manager.sh delete agent-browser true
# 选择 qa-cowork-main 版本删除
```

---

## 🛡️ 示例 7: 安全场景 - 尝试删除系统技能

### 用户请求
```
删除 commit 技能
```

### Claude 执行流程

#### 步骤 1: 查找技能
```bash
~/ai/skills-inventory/skills-manager.sh find commit
```

#### 步骤 2: 检测到系统技能

Claude 发现 commit 是 GitLens 的内置技能，位于：
```
~/.cursor/extensions/eamodio.gitlens-xxx/.claude/skills/commit
```

#### 步骤 3: 警告用户

```
⚠️ 警告：commit 是 Cursor GitLens 的内置技能。

删除此技能可能会导致：
- GitLens 扩展功能异常
- 无法使用 /commit 命令
- 需要重新安装 GitLens 才能恢复

建议：不要删除系统内置技能。

是否仍要继续删除？（不推荐）
```

---

## 🔄 示例 8: 恢复已删除的技能

### 用户请求
```
刚才删除的 test-skill 我想恢复一下
```

### Claude 执行流程

#### 步骤 1: 查找备份
```bash
ls -la ~/.trash/skills/ | grep test-skill
```

#### 步骤 2: 显示备份列表
```
找到以下备份：
- 20260320_143000_test-skill
- 20260319_120000_test-skill

请问要恢复哪一个？（选择最新的）
```

#### 步骤 3: 恢复技能
```bash
cp -r ~/.trash/skills/20260320_143000_test-skill \
      ~/.claude/skills/test-skill
```

#### 步骤 4: 验证恢复
```bash
~/ai/skills-inventory/skills-manager.sh info test-skill
```

---

## 💡 高级使用技巧

### 技巧 1: 批量搜索
```
搜索所有包含 "test" 或 "browser" 的技能
```

### 技巧 2: 跨客户端对比
```
对比 Claude Code 和 QA-Cowork 中的 docx 技能有什么区别
```

### 技巧 3: 技能迁移
```
把 OpenClaw 的 pdf 技能复制到 Claude Code
```

### 技巧 4: 定期清理
```
列出所有 test 开头的技能，我想清理一下测试技能
```

---

## 🎯 最佳实践

1. **删除前先查看** - 务必先用 "打开 XXX 技能" 查看内容
2. **保留备份** - 删除时建议选择备份选项
3. **避免删除系统技能** - 不要删除 GitLens、Python 等内置技能
4. **定期清理备份** - `~/.trash/skills/` 会占用空间，定期清理旧备份
5. **保留原始版本** - 如果有多个同名技能，保留最原始的版本

---

## ❓ 常见问题

### Q: 如何知道哪个技能是系统内置的？
A: 通常位于以下目录的技能是系统内置的：
- `~/.cursor/extensions/*/​.claude/skills/`
- `~/.trae/extensions/*/​.claude/skills/`

### Q: 删除技能后能恢复吗？
A: 可以，前提是删除时选择了备份。从 `~/.trash/skills/` 目录恢复。

### Q: 能不能直接修改技能内容？
A: 可以！使用 Read 查看内容后，可以使用 Edit 工具直接修改 SKILL.md 文件。

### Q: 如何添加新的客户端支持？
A: 修改 `skills-manager.sh` 中的 `SKILL_DIRS_KEYS` 和 `SKILL_DIRS_VALUES` 数组。

---

**更新时间**: 2026-03-20
