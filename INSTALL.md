# Skills Inventory 安装指南

## 📦 安装方式

skills-inventory 已经创建在 `~/ai/skills-inventory/` 目录中。

### 方式 1: 复制到 Claude Code（推荐）

将技能复制到 Claude Code 的 skills 目录：

```bash
# 创建 Claude Code skills 目录（如果不存在）
mkdir -p ~/.claude/skills

# 复制技能
cp -r ~/ai/skills-inventory ~/.claude/skills/

# 或创建符号链接（推荐，便于更新）
ln -s ~/ai/skills-inventory ~/.claude/skills/skills-inventory
```

### 方式 2: 复制到 QA-Cowork

```bash
# 复制到 QA-Cowork
cp -r ~/ai/skills-inventory ~/.qa-cowork/skills/

# 或创建符号链接
ln -s ~/ai/skills-inventory ~/.qa-cowork/skills/skills-inventory
```

### 方式 3: 复制到 OpenClaw

```bash
# 复制到 OpenClaw
cp -r ~/ai/skills-inventory ~/.openclaw/skills/

# 或创建符号链接
ln -s ~/ai/skills-inventory ~/.openclaw/skills/skills-inventory
```

### 方式 4: 复制到 Cursor

```bash
# 复制到 Cursor
cp -r ~/ai/skills-inventory ~/.cursor/skills/

# 或创建符号链接
ln -s ~/ai/skills-inventory ~/.cursor/skills/skills-inventory
```

## ✅ 验证安装

### 1. 检查文件结构

```bash
ls -la ~/ai/skills-inventory/
```

应该看到以下文件：
```
SKILL.md              - 技能定义文件（必需）
README.md             - 说明文档
EXAMPLES.md           - 使用示例
INSTALL.md            - 本安装指南
VERSION               - 版本信息
config.json           - 配置文件
skills-manager.sh     - 管理脚本（可执行）
```

### 2. 测试脚本

```bash
# 测试列出功能
~/ai/skills-inventory/skills-manager.sh list

# 测试搜索功能
~/ai/skills-inventory/skills-manager.sh search browser

# 测试查找功能
~/ai/skills-inventory/skills-manager.sh find docx
```

### 3. 在 Claude Code 中测试

启动 Claude Code 并发送：

```
列出所有技能
```

如果 Claude 正确响应并显示所有技能列表，说明安装成功！

## 🔧 配置

### 修改支持的客户端

如果需要添加或修改支持的客户端，编辑 `skills-manager.sh`：

```bash
vim ~/ai/skills-inventory/skills-manager.sh
```

找到 `SKILL_DIRS_KEYS` 和 `SKILL_DIRS_VALUES` 数组，添加新的条目：

```bash
SKILL_DIRS_KEYS=(
    "claude-code"
    "your-new-client"  # 添加新客户端
    ...
)

SKILL_DIRS_VALUES=(
    "$HOME/.claude/skills"
    "$HOME/.your-client/skills"  # 添加新路径
    ...
)
```

### 修改备份目录

默认备份目录是 `~/.trash/skills`，如需修改：

```bash
# 编辑脚本
vim ~/ai/skills-inventory/skills-manager.sh

# 找到并修改这一行
BACKUP_DIR="$HOME/.trash/skills"
# 改为
BACKUP_DIR="$HOME/your-backup-dir"
```

## 🔄 更新

### 更新脚本

如果需要更新管理脚本：

```bash
# 备份当前版本
cp ~/ai/skills-inventory/skills-manager.sh \
   ~/ai/skills-inventory/skills-manager.sh.backup

# 下载或编辑新版本
vim ~/ai/skills-inventory/skills-manager.sh

# 添加执行权限
chmod +x ~/ai/skills-inventory/skills-manager.sh
```

### 更新技能定义

编辑 SKILL.md 文件：

```bash
vim ~/ai/skills-inventory/SKILL.md
```

修改后，如果使用了符号链接，所有客户端都会自动使用新版本。

## 🗑️ 卸载

### 完全卸载

```bash
# 删除主目录
rm -rf ~/ai/skills-inventory

# 删除各客户端的链接或副本
rm -rf ~/.claude/skills/skills-inventory
rm -rf ~/.qa-cowork/skills/skills-inventory
rm -rf ~/.openclaw/skills/skills-inventory
rm -rf ~/.cursor/skills/skills-inventory

# 删除备份目录（可选）
rm -rf ~/.trash/skills
```

### 仅禁用

如果只是临时禁用，可以重命名 SKILL.md：

```bash
mv ~/ai/skills-inventory/SKILL.md \
   ~/ai/skills-inventory/SKILL.md.disabled
```

重新启用：

```bash
mv ~/ai/skills-inventory/SKILL.md.disabled \
   ~/ai/skills-inventory/SKILL.md
```

## 🚨 故障排除

### 问题 1: 脚本没有执行权限

```bash
chmod +x ~/ai/skills-inventory/skills-manager.sh
```

### 问题 2: Claude 无法识别技能

检查：
1. SKILL.md 文件是否存在
2. SKILL.md 前置元数据格式是否正确
3. 技能是否在正确的 skills 目录中

```bash
# 检查 Claude Code skills 目录
ls -la ~/.claude/skills/skills-inventory/

# 检查 SKILL.md
cat ~/.claude/skills/skills-inventory/SKILL.md | head -10
```

### 问题 3: 搜索功能返回空结果

确认技能目录存在且可访问：

```bash
# 检查目录
ls -la ~/.claude/skills/
ls -la ~/.qa-cowork/skills/
ls -la ~/.openclaw/skills/
```

### 问题 4: macOS bash 版本过低

脚本已经使用兼容的语法，如果仍有问题：

```bash
# 使用 bash 明确指定
bash ~/ai/skills-inventory/skills-manager.sh list
```

或安装新版本的 bash：

```bash
brew install bash
```

## 📞 获取帮助

如有问题：

1. 查看 `README.md` 了解基本用法
2. 查看 `EXAMPLES.md` 了解详细示例
3. 检查 `VERSION` 文件确认版本
4. 在 Claude Code 中询问："skills-inventory 技能如何使用？"

## 🎉 完成！

安装完成后，你就可以使用以下命令了：

- "列出所有技能"
- "搜索 XXX 技能"
- "打开 XXX 技能"
- "删除 XXX 技能"

享受你的技能管理之旅！🚀
