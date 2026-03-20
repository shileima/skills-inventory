---
name: skills-inventory
description: 管理本地所有 Claude Code 类客户端的 skills，支持查看、搜索、打开和删除技能
version: 1.0.0
author: 小美助手
tags: [skills, management, claude-code, openclaw, qa-cowork]
---

# Skills Inventory - 技能仓库管理器

统一管理本地所有类 Claude Code 客户端的 skills，包括 Claude Code、OpenClaw、QA-Cowork、Cursor、ClawdBot 等。

## 功能特性

1. **📋 列出所有技能** - 查看本地所有客户端的 skills 清单
2. **🔍 搜索技能** - 根据名称或关键词搜索技能
3. **📂 打开技能** - 快速打开技能的 SKILL.md 文件查看或编辑
4. **🗑️ 删除技能** - 安全删除指定的技能（支持备份）
5. **📊 统计分析** - 各客户端的技能数量统计

## 使用方式

用户可以这样请求：

- "列出所有技能"
- "查看 Claude Code 的所有 skills"
- "搜索 browser 相关的技能"
- "打开 agent-browser 技能"
- "删除 xxx 技能"
- "统计各客户端的技能数量"

## 执行流程

### 1. 列出所有技能

当用户请求查看技能列表时：

1. 扫描所有已知的 skills 目录
2. 按客户端分组展示
3. 显示技能数量统计

### 2. 搜索技能

当用户搜索技能时：

1. 在所有 skills 目录中搜索匹配的技能名称
2. 显示技能所属的客户端和完整路径
3. 列出匹配的技能列表

### 3. 打开技能

当用户请求打开技能时：

1. 搜索指定名称的技能
2. 如果有多个同名技能，询问用户选择哪一个
3. 使用 Read 工具读取并显示 SKILL.md 内容

### 4. 删除技能

当用户请求删除技能时：

1. 搜索指定名称的技能
2. 显示技能信息并要求用户确认
3. **询问是否备份**（默认备份到 `~/.trash/skills/`）
4. 执行删除操作
5. 报告删除结果

### 5. 统计分析

显示各客户端的技能数量和总计。

## 技能目录配置

支持的客户端及其 skills 目录：

```bash
# Claude Code
~/.claude/skills/

# QA-Cowork (小美搭档)
~/.qa-cowork/hot-update/resources/skills/
~/.qa-cowork/skills/

# Cursor
~/.cursor/skills/

# ClawdBot
~/.nvm/versions/node/v20.19.6/lib/node_modules/clawdbot/skills/

# Trae-CN
~/.trae-cn/skills/

# .agents
~/.agents/skills/

# OpenClaw
~/.openclaw/skills/
~/Library/Application Support/automan-desktop/openclaw/.openclaw/skills/
```

## 安全措施

1. **删除前确认** - 必须用户明确确认才能删除
2. **自动备份** - 默认将删除的技能备份到 `~/.trash/skills/备份时间_技能名称/`
3. **只读操作优先** - 优先使用 Read 工具而不是 Bash 命令
4. **路径验证** - 验证技能路径是否在已知目录中

## 实现工具

使用以下工具实现功能：

- **Glob** - 搜索技能文件
- **Read** - 读取技能内容
- **Bash** - 执行删除和备份操作
- **AskUserQuestion** - 用户确认和选择

## 示例对话

**用户**: "列出所有技能"
**助手**: 执行扫描并展示分类列表和统计信息

**用户**: "搜索 browser 相关的技能"
**助手**: 列出所有包含 browser 关键词的技能

**用户**: "打开 agent-browser 技能"
**助手**: 读取并显示该技能的 SKILL.md 内容

**用户**: "删除 test-skill 技能"
**助手**:
1. 显示技能信息
2. 询问是否确认删除
3. 询问是否需要备份
4. 执行删除并报告结果

## 注意事项

1. 删除操作不可逆，请谨慎使用
2. 建议在删除前先查看技能内容
3. 系统内置技能（如 GitLens skills）建议不要删除
4. 备份文件保存在 `~/.trash/skills/` 目录
