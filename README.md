# 💬 WeChat Sender (PowerShell)

Automatically send WeChat messages using PowerShell and Windows SendKeys. No extra dependencies required.

## 🚀 Quick Start

### Prerequisites

- Windows 10/11
- PowerShell 5.1+
- WeChat PC version (logged in)

### Installation

```bash
# Clone to your OpenClaw skills directory
cd <your-openclaw-skills-directory>
git clone https://github.com/graduy/wechat-sender-powershell.git
```

### Basic Usage

```powershell
# Send a text message
.\scripts\send-wechat.ps1 -contact "Contact Name" -message "Hello!"

# Send to a group chat
.\scripts\send-wechat.ps1 -contact "Work Group" -message "Meeting at 3pm"

# Send with image
.\scripts\send-wechat.ps1 -contact "Friend" -message "Check this out!" -image "C:\path\to\image.jpg"

# Send with file
.\scripts\send-wechat.ps1 -contact "Team" -message "Report attached" -file "C:\path\to\report.pdf"
```

### Using with OpenClaw

Simply say in chat:
```
Send WeChat message to John: Hey, are you free tonight?
```

## ⚙️ Configuration (Optional)

Copy the example config file:
```powershell
cp config.example.yml config.yml
```

Edit `config.yml` to set defaults:
```yaml
default_contact: "File Transfer Assistant"
key_delay_ms: 500
verbose: false
```

## ⚠️ Important Notes

1. **WeChat PC must be logged in** - The script requires WeChat to be running
2. **Administrator privileges** - May be required for keyboard simulation
3. **Don't spam** - Sending too many messages quickly may get your account flagged
4. **Input method** - Switch to English input method for better reliability

## 🎯 Features

- ✅ Search contacts by name
- ✅ Send text messages
- ✅ Send images (via clipboard)
- ✅ Send files (via attach dialog)
- ✅ Support for group chats
- ✅ Colored output and logging
- ✅ Error handling
- ✅ Optional configuration file

## 🐛 Troubleshooting

### WeChat window not found
Make sure WeChat PC version is running and logged in.

### Message not sent
- Check if the contact name is correct
- Ensure the chat window is selected
- Try switching to English input method

### Keys not working
Run PowerShell as Administrator.

## 📖 Documentation

See [SKILL.md](SKILL.md) for detailed documentation.

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📝 Changelog

### v1.1.0 (2026-03-08)
- ✅ Added image sending support
- ✅ Added file sending support
- ✅ Added optional configuration file
- ✅ Improved error handling

### v1.0.0 (2026-03-08)
- ✅ Initial release
- ✅ Contact search
- ✅ Text message sending

## 📄 License

MIT License
