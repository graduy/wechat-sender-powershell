---
name: wechat-sender-powershell
slug: wechat-sender-powershell
version: 1.2.0
homepage: https://github.com/graduy/wechat-sender-powershell
description: 微信消息自动发送（PowerShell 版）。使用 Windows SendKeys 模拟键盘操作，无需额外依赖。支持发送文本、图片、文件。触发条件：用户提到"发微信"、"给 xxx 发消息"、"微信自动发送"等。
changelog: "Fixed chat window focus issue - proper contact selection and message input flow"
metadata:
  openclaw:
    emoji: "💬"
    category: automation
    requires:
      bins: ["powershell"]
    os: ["win32"]
---

# WeChat Sender (PowerShell)

**微信消息自动发送技能** - 使用 PowerShell SendKeys 模拟键盘操作

## 🎯 使用场景

- 给好友/群聊发送消息
- 自动发送通知
- 批量消息发送
- 定时消息（配合 cron）

## 💬 快速开始

### 直接对我说

```
给 张三 发微信：晚上好！
```

### 命令行使用

```powershell
# 基础用法
.\scripts\send-wechat.ps1 -contact "张三" -message "你好！"

# 发送到群聊
.\scripts\send-wechat.ps1 -contact "工作群" -message "明天开会"

# 使用默认联系人（如果配置了）
.\scripts\send-wechat.ps1 -message "测试消息"
```

## 🔧 配置

### 可选：配置默认联系人

创建 `config.yml`：
```yaml
default_contact: "文件传输助手"
```

### 依赖检查

```powershell
# 检查微信是否运行
Get-Process WeChatAppEx -ErrorAction SilentlyContinue

# 检查 PowerShell 版本
$PSVersionTable.PSVersion
```

## 📋 使用示例

### 示例 1：发送简单消息
```powershell
.\scripts\send-wechat.ps1 -contact "李四" -message "晚上吃饭吗？"
```

### 示例 2：发送长消息
```powershell
$message = @"
明天会议安排：
1. 时间：上午 9 点
2. 地点：302 会议室
3. 内容：项目进度汇报

请准时参加！
"@

.\scripts\send-wechat.ps1 -contact "工作群" -message $message
```

### 示例 3：批量发送
```powershell
$contacts = @("张三", "李四", "王五")
foreach ($contact in $contacts) {
    .\scripts\send-wechat.ps1 -contact $contact -message "新年快乐！"
    Start-Sleep -Seconds 2
}
```

## ⚠️ 注意事项

### 1. 微信 PC 版必须登录
- 确保微信 PC 版已登录且在运行
- 不要退出登录
- 保持窗口在前台或后台运行

### 2. 输入法问题
- 搜索时自动切换到英文输入法
- 中文联系人名字支持良好
- 如果失败，手动切换到英文输入法重试

### 3. 防自动化检测
- 某些微信版本可能有检测
- 建议操作间隔 > 500ms
- 不要频繁发送（可能被封号）

### 4. 权限要求
- 需要管理员权限（模拟按键）
- 以管理员身份运行 PowerShell

## 🐛 故障排查

### Q1: 找不到微信窗口
```powershell
# 检查微信进程
Get-Process WeChatAppEx

# 如果没有，启动微信
Start-Process WeChat
```

### Q2: 消息发送失败
- 确认联系人名字正确
- 检查是否成功选中联系人
- 手动测试键盘输入是否正常

### Q3: 搜索失败
- 确保是英文输入法
- 尝试只输入姓氏前缀
- 重启微信重试

## 📚 高级用法

### 与 OpenClaw 集成

在 OpenClaw 对话中直接使用：
```
给 文件传输助手 发微信：测试消息
```

### 定时发送

配合 OpenClaw cron：
```bash
# 每天早上 9 点发送提醒
openclaw cron add --schedule "0 9 * * *" --payload "给 工作群 发微信：早上好！"
```

### 与其他技能组合

```bash
# 搜索新闻 → 总结 → 发送到微信
搜索最新 AI 新闻 → 总结 → 给 张三 发微信：[总结内容]
```

## 🔮 未来优化

- [ ] 支持发送图片
- [ ] 支持发送文件
- [ ] 支持语音消息
- [ ] 自动验证发送成功
- [ ] 支持撤回消息
- [ ] 群发消息优化

## 📖 参考资源

- **PowerShell SendKeys:** https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys
- **微信快捷键:**
  - `Ctrl+F` - 搜索
  - `Enter` - 发送消息
  - `Shift+Enter` - 换行
  - `Ctrl+A` - 发送文件

## 📝 更新日志

### v1.2.0 (2026-03-09)
- ✅ 修复聊天窗口焦点问题
- ✅ 优化联系人选中流程（搜索 → Enter → 直接输入）
- ✅ 使用 `~` 代替 `{ENTER}` 提高可靠性
- ✅ 增加操作间隔等待时间
- ✅ 简化脚本逻辑，提高稳定性

### v1.1.0 (2026-03-08)
- ✅ 添加图片/文件发送支持
- ✅ 可选配置文件（config.yml）
- ✅ 错误处理和日志输出优化

### v1.0.0 (2026-03-08)
- ✅ 初始版本发布
- ✅ 支持搜索联系人
- ✅ 支持发送文本消息
- ✅ 支持群聊
- ✅ 错误处理和日志输出

---

**开发团队：** Grady & 小研  
**许可证：** MIT  
**问题反馈：** https://github.com/Grady/opencv-workspace/issues
