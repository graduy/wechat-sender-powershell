# 💬 WeChat Sender (PowerShell)

微信消息自动发送技能 - 使用 PowerShell SendKeys 模拟键盘操作

## 🚀 快速开始

### 安装

```bash
# 克隆到 OpenClaw skills 目录
cd C:\Users\Grady\.openclaw\workspace\skills
git clone <your-repo-url> wechat-sender-powershell
```

### 使用

```powershell
# 基础用法
.\scripts\send-wechat.ps1 -contact "张三" -message "你好！"

# 发送到群聊
.\scripts\send-wechat.ps1 -contact "工作群" -message "明天开会"
```

### 在 OpenClaw 中使用

```
给 张三 发微信：晚上好！
```

## 📋 依赖

- ✅ Windows 10/11
- ✅ PowerShell 5.1+
- ✅ 微信 PC 版（已登录）
- ✅ System.Windows.Forms（内置）

## 🎯 功能特性

- ✅ 搜索联系人发送
- ✅ 支持群聊
- ✅ 长消息支持
- ✅ 错误处理和日志
- ✅ 彩色输出

## ⚠️ 注意事项

1. 微信 PC 版必须登录
2. 需要管理员权限运行
3. 不要频繁发送（可能被封号）
4. 中文输入法可能影响搜索

## 📖 完整文档

查看 [SKILL.md](SKILL.md) 获取详细文档

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📝 更新日志

### v1.0.0 (2026-03-08)
- ✅ 初始版本
- ✅ 支持搜索联系人
- ✅ 支持发送文本消息

## 📄 许可证

MIT License
