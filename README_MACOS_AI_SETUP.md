# macOS Intel Terminal Tools Setup for AI Development

Complete development environment for OpenAI, Claude (Anthropic), Gemini (Google), and Grok (xAI) on macOS.

---

## 📦 What's Included

This setup provides everything you need for AI development on macOS:

### 🎯 Core Files

| File | Description |
|------|-------------|
| `macos-ai-setup.sh` | **Main setup script** - Automated installation of all tools |
| `requirements-ai-macos.txt` | **Python packages** - All AI SDKs and dependencies |
| `MACOS_AI_SETUP_GUIDE.md` | **Complete guide** - Detailed documentation |
| `quick-start.md` | **Quick start** - Get running in 10 minutes |
| `verify-ai-setup.py` | **Verification** - Test your installation |

### 🛠️ What Gets Installed

#### Essential Tools
- **Homebrew** - macOS package manager
- **pyenv** - Python version management
- **Python 3.11** - Latest stable Python
- **Git, curl, wget** - Version control and downloads
- **jq, tree, bat** - CLI utilities
- **ffmpeg, imagemagick** - Media processing
- **ripgrep, fzf, fd** - Fast searching
- **gh** - GitHub CLI

#### AI Service SDKs
- **OpenAI** - GPT-4, GPT-3.5, DALL-E, Whisper
- **Anthropic** - Claude 3 (Opus, Sonnet, Haiku)
- **Google AI** - Gemini Pro, Gemini Pro Vision
- **Groq** - Fast LLM inference
- **Replicate** - AI models marketplace
- **Hugging Face** - Transformers and models
- **LangChain** - AI application framework

#### Development Tools
- **IPython/Jupyter** - Interactive development
- **Black/Ruff** - Code formatting and linting
- **pytest** - Testing framework
- **Rich** - Beautiful terminal output

---

## 🚀 Installation

### Prerequisites

- macOS 11.0+ (Big Sur or later)
- Intel or Apple Silicon Mac
- 10 GB free disk space
- Administrator access

### Quick Install (Recommended)

```bash
# 1. Run the automated setup
chmod +x macos-ai-setup.sh
./macos-ai-setup.sh
```

This installs everything automatically in 15-30 minutes.

### Post-Installation

```bash
# 2. Configure API keys
cp ~/.env.d/ai-services.env.template ~/.env.d/ai-services.env
nano ~/.env.d/ai-services.env

# 3. Restart terminal or source config
source ~/.zshrc  # or ~/.bash_profile

# 4. Load environment and verify
ai-load-env
python verify-ai-setup.py
```

---

## 🔑 API Keys Required

Get your API keys from:

1. **OpenAI**: https://platform.openai.com/api-keys
2. **Anthropic (Claude)**: https://console.anthropic.com/
3. **Google (Gemini)**: https://makersuite.google.com/app/apikey  
4. **xAI (Grok)**: https://x.ai/api
5. **Groq**: https://console.groq.com/

Add them to `~/.env.d/ai-services.env`

---

## ✅ Verification

### Quick Test

```bash
# Load environment
ai-load-env

# Test all services
ai-test-openai
ai-test-claude  
ai-test-gemini

# Check API key status
ai-check-keys

# Full verification
python verify-ai-setup.py
```

### Expected Output

```
============================================================
  AI Development Environment Verification
============================================================

✅ OpenAI API: Working
✅ Claude API: Working
✅ Gemini API: Working
✅ Groq API: Working

🎉 All systems operational! Ready for AI development.
```

---

## 💡 Quick Examples

### OpenAI Chat

```python
from openai import OpenAI

client = OpenAI()
response = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=[{"role": "user", "content": "Hello!"}]
)
print(response.choices[0].message.content)
```

### Claude Chat

```python
from anthropic import Anthropic

client = Anthropic()
message = client.messages.create(
    model="claude-3-opus-20240229",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)
print(message.content[0].text)
```

### Gemini Chat

```python
import google.generativeai as genai
import os

genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
model = genai.GenerativeModel('gemini-pro')
response = model.generate_content("Hello!")
print(response.text)
```

---

## 🛠️ Helper Commands

The setup creates these convenient commands:

```bash
# Environment management
ai-load-env          # Load all AI environment variables
ai-check-keys        # Check API key configuration status
ai-list-models       # List all available AI models

# Quick testing
ai-test-openai       # Test OpenAI API connection
ai-test-claude       # Test Claude API connection
ai-test-gemini       # Test Gemini API connection
```

---

## 📚 Documentation

- **Quick Start**: See `quick-start.md` for 10-minute setup
- **Full Guide**: See `MACOS_AI_SETUP_GUIDE.md` for complete documentation
- **Requirements**: See `requirements-ai-macos.txt` for package list
- **Examples**: Full examples in the comprehensive guide

---

## 🔧 Troubleshooting

### Common Issues

**1. Homebrew not found**
```bash
# Install manually
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Python version wrong**
```bash
# Verify pyenv
pyenv versions
pyenv global 3.11.7
python --version
```

**3. API key not working**
```bash
# Check environment
ai-load-env
ai-check-keys
echo $OPENAI_API_KEY
```

**4. Package not found**
```bash
# Reinstall requirements
pip install -r requirements-ai-macos.txt
```

### Get Help

1. Run `python verify-ai-setup.py` to diagnose issues
2. Check service status pages:
   - OpenAI: https://status.openai.com/
   - Anthropic: https://status.anthropic.com/
3. Review the full guide in `MACOS_AI_SETUP_GUIDE.md`

---

## 🎯 Project Structure

After installation, your environment will look like:

```
~/.env.d/
├── ai-services.env              # Your API keys (DO NOT COMMIT)
├── ai-services.env.template     # Template file
└── .gitignore                   # Protects your secrets

~/.ai-helpers.sh                 # Helper bash functions

~/.pyenv/                        # Python version management
└── versions/
    └── 3.11.7/                  # Python 3.11

~/workspace/                     # Your projects
├── macos-ai-setup.sh           # This setup script
├── requirements-ai-macos.txt   # Python packages
├── verify-ai-setup.py          # Verification script
└── [your AI projects]
```

---

## 🚀 Next Steps

After successful installation:

1. **Learn the APIs**
   - OpenAI Docs: https://platform.openai.com/docs
   - Claude Docs: https://docs.anthropic.com/
   - Gemini Docs: https://ai.google.dev/docs

2. **Build Your First AI App**
   - Start with simple chat completions
   - Experiment with different models
   - Compare responses across services

3. **Explore Advanced Features**
   - Function calling
   - Vision capabilities (GPT-4V, Gemini Pro Vision)
   - Audio transcription (Whisper)
   - Image generation (DALL-E)

4. **Use AI Frameworks**
   - LangChain for complex workflows
   - LlamaIndex for document QA
   - Gradio/Streamlit for interfaces

---

## 📊 Supported AI Models

### OpenAI
- GPT-4 Turbo Preview
- GPT-4
- GPT-3.5 Turbo
- DALL-E 3
- Whisper

### Anthropic (Claude)
- Claude 3 Opus
- Claude 3 Sonnet  
- Claude 3 Haiku

### Google (Gemini)
- Gemini Pro
- Gemini Pro Vision

### Other Services
- Groq (Mixtral, LLaMA)
- Replicate (Thousands of models)
- Hugging Face (Open source models)

---

## 💻 System Requirements

- **OS**: macOS 11.0 (Big Sur) or later
- **Architecture**: Intel (x86_64) or Apple Silicon (ARM64)
- **RAM**: 8 GB minimum, 16 GB recommended
- **Disk**: 10 GB free space
- **Network**: Broadband internet connection

---

## 🔒 Security Best Practices

- ✅ Never commit `.env` files to version control
- ✅ Use different API keys for development and production
- ✅ Set usage limits on API dashboards
- ✅ Rotate API keys regularly (every 90 days)
- ✅ Monitor API usage for anomalies
- ✅ Use environment variables, never hardcode keys

---

## 📈 Performance Tips

### For Apple Silicon Macs
- Use native ARM64 Python packages when available
- Consider conda/miniforge for ML packages
- Enable Metal Performance Shaders for PyTorch

### For Intel Macs
- Standard pip installations work well
- Use virtual environments for isolation
- Monitor memory usage for large models

---

## 🤝 Contributing

Improvements and suggestions welcome! This setup is designed to be:

- **Simple**: One-command installation
- **Complete**: Everything needed for AI development
- **Secure**: Best practices for API key management
- **Flexible**: Easy to customize for specific needs

---

## 📄 License

This setup guide and scripts are provided as-is for educational and development purposes.

---

## 🎉 Summary

You now have:

- ✅ Complete AI development environment on macOS
- ✅ Access to OpenAI, Claude, Gemini, Grok, and more
- ✅ Python 3.11 with all necessary packages
- ✅ Essential development tools and utilities
- ✅ Helper scripts for quick testing
- ✅ Comprehensive documentation

**Start building amazing AI applications today!** 🚀

---

## 📞 Quick Reference

### File Overview
- `macos-ai-setup.sh` - Main installer
- `requirements-ai-macos.txt` - Python packages
- `MACOS_AI_SETUP_GUIDE.md` - Full documentation
- `quick-start.md` - 10-minute guide
- `verify-ai-setup.py` - Testing script

### Essential Commands
```bash
ai-load-env          # Load environment
ai-check-keys        # Check API keys
ai-test-openai       # Test OpenAI
python verify-ai-setup.py  # Full verification
```

### Getting API Keys
- OpenAI: https://platform.openai.com/api-keys
- Claude: https://console.anthropic.com/
- Gemini: https://makersuite.google.com/app/apikey
- Groq: https://console.groq.com/

---

*Setup complete! Happy coding with AI!* ✨🤖
