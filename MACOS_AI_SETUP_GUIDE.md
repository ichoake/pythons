# 🚀 macOS AI Development Environment Setup Guide

**Complete setup for Intel and Apple Silicon Macs**  
Supports: **OpenAI** • **Claude (Anthropic)** • **Gemini (Google)** • **Grok (xAI)**

---

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Installation](#detailed-installation)
- [Configuration](#configuration)
- [API Keys Setup](#api-keys-setup)
- [Verification](#verification)
- [Usage Examples](#usage-examples)
- [Helper Commands](#helper-commands)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)

---

## 🎯 Overview

This setup provides a complete AI development environment on macOS with:

- ✅ **All major AI services** - OpenAI, Claude, Gemini, Grok, Groq, and more
- ✅ **Python 3.11+** - Managed via pyenv for version control
- ✅ **Essential CLI tools** - ffmpeg, jq, git, and development utilities
- ✅ **Secure API key management** - Organized environment configuration
- ✅ **Helper scripts** - Quick testing and verification tools
- ✅ **Full SDK support** - Official Python libraries for all services

---

## 💻 Prerequisites

### System Requirements

- **macOS 11.0+** (Big Sur or later)
- **Intel or Apple Silicon Mac** (both supported)
- **10 GB free disk space** (for tools and Python packages)
- **Internet connection** (for downloading packages)
- **Terminal access** (Terminal.app, iTerm2, or similar)

### Before You Start

1. **Update macOS**: Ensure you're running the latest macOS version
   ```bash
   softwareupdate -l
   ```

2. **Install Xcode Command Line Tools** (if not already installed):
   ```bash
   xcode-select --install
   ```

3. **For Apple Silicon Macs**: Install Rosetta 2 (for Intel compatibility):
   ```bash
   softwareupdate --install-rosetta
   ```

---

## ⚡ Quick Start

### One-Command Setup

Run the automated setup script:

```bash
chmod +x macos-ai-setup.sh
./macos-ai-setup.sh
```

This will:
1. Install Homebrew (if needed)
2. Install essential CLI tools
3. Set up Python 3.11 via pyenv
4. Install all AI SDK packages
5. Create environment templates
6. Generate helper scripts

**Total setup time**: 15-30 minutes (depending on internet speed)

---

## 🔧 Detailed Installation

### Step 1: Run the Setup Script

```bash
# Download and make executable
chmod +x macos-ai-setup.sh

# Run the setup
./macos-ai-setup.sh
```

The script will install:

#### 🍺 Homebrew & CLI Tools
- `git` - Version control
- `curl`, `wget` - HTTP clients
- `jq` - JSON processor
- `ffmpeg` - Media processing
- `imagemagick` - Image manipulation
- `neovim` - Text editor
- `ripgrep`, `fzf`, `bat` - Enhanced search/display
- `gh` - GitHub CLI

#### 🐍 Python Environment
- `pyenv` - Python version manager
- `Python 3.11.7` - Recommended for AI development
- All packages from `requirements-ai-macos.txt`

#### 📦 AI Service SDKs
- OpenAI Python SDK
- Anthropic Python SDK
- Google Generative AI SDK
- Groq SDK
- Additional services (Replicate, Hugging Face, etc.)

---

### Step 2: Configure API Keys

After installation, set up your API keys:

```bash
# Copy the template
cp ~/.env.d/ai-services.env.template ~/.env.d/ai-services.env

# Edit with your API keys
nano ~/.env.d/ai-services.env
```

Or use your preferred editor:
```bash
# VS Code
code ~/.env.d/ai-services.env

# Vim/Neovim
nvim ~/.env.d/ai-services.env
```

---

### Step 3: Restart Terminal

Close and reopen your terminal, or source your shell config:

```bash
# For zsh (default on modern macOS)
source ~/.zshrc

# For bash
source ~/.bash_profile
```

---

### Step 4: Verify Installation

Load the AI environment and run verification:

```bash
# Load environment variables
ai-load-env

# Run verification script
python verify-ai-setup.py
```

---

## 🔑 API Keys Setup

### Where to Get API Keys

| Service | API Key URL | Environment Variable |
|---------|-------------|---------------------|
| **OpenAI** | https://platform.openai.com/api-keys | `OPENAI_API_KEY` |
| **Claude (Anthropic)** | https://console.anthropic.com/ | `ANTHROPIC_API_KEY` |
| **Gemini (Google)** | https://makersuite.google.com/app/apikey | `GOOGLE_API_KEY` |
| **Grok (xAI)** | https://x.ai/api | `XAI_API_KEY` |
| **Groq** | https://console.groq.com/ | `GROQ_API_KEY` |
| **Replicate** | https://replicate.com/account | `REPLICATE_API_TOKEN` |
| **Hugging Face** | https://huggingface.co/settings/tokens | `HUGGINGFACE_TOKEN` |

### Environment File Structure

Your `~/.env.d/ai-services.env` file should look like:

```bash
# OpenAI
OPENAI_API_KEY=sk-proj-abc123...
OPENAI_MODEL=gpt-4-turbo-preview

# Anthropic (Claude)
ANTHROPIC_API_KEY=sk-ant-xyz789...
CLAUDE_MODEL=claude-3-opus-20240229

# Google (Gemini)
GOOGLE_API_KEY=AIzaSy...
GEMINI_MODEL=gemini-pro

# xAI (Grok)
XAI_API_KEY=xai-...
GROK_MODEL=grok-beta

# Groq
GROQ_API_KEY=gsk_...
```

### Security Best Practices

- ✅ **Never commit** `.env` files to version control
- ✅ **Use different keys** for development and production
- ✅ **Rotate keys regularly** (every 90 days recommended)
- ✅ **Set usage limits** on API dashboards
- ✅ **Monitor usage** to detect unauthorized access

---

## ✅ Verification

### Automated Verification

```bash
python verify-ai-setup.py
```

Expected output:
```
============================================================
  AI Development Environment Verification
============================================================

Python Version: 3.11.7 ...
Python Path: /Users/you/.pyenv/versions/3.11.7/bin/python

============================================================
  Testing Python Packages
============================================================

✅ openai
✅ anthropic
✅ google.generativeai
✅ groq
...

============================================================
  Testing AI Service APIs
============================================================

✅ OpenAI API: Working - OK
✅ Claude API: Working - OK
✅ Gemini API: Working - OK
✅ Groq API: Working - OK

============================================================
  Summary
============================================================

Packages: ✅ All installed
API Tests: 4/4 passed

🎉 All systems operational! Ready for AI development.
```

### Manual Testing

Test each service individually:

```bash
# Test OpenAI
ai-test-openai

# Test Claude
ai-test-claude

# Test Gemini
ai-test-gemini

# Check all API keys
ai-check-keys
```

---

## 🎨 Usage Examples

### OpenAI (GPT-4)

```python
from openai import OpenAI

client = OpenAI()

response = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Explain quantum computing in simple terms."}
    ]
)

print(response.choices[0].message.content)
```

### Claude (Anthropic)

```python
from anthropic import Anthropic

client = Anthropic()

message = client.messages.create(
    model="claude-3-opus-20240229",
    max_tokens=1024,
    messages=[
        {"role": "user", "content": "Explain quantum computing in simple terms."}
    ]
)

print(message.content[0].text)
```

### Gemini (Google)

```python
import google.generativeai as genai
import os

genai.configure(api_key=os.environ['GOOGLE_API_KEY'])

model = genai.GenerativeModel('gemini-pro')
response = model.generate_content("Explain quantum computing in simple terms.")

print(response.text)
```

### Groq (Fast Inference)

```python
from groq import Groq

client = Groq()

response = client.chat.completions.create(
    model="mixtral-8x7b-32768",
    messages=[
        {"role": "user", "content": "Explain quantum computing in simple terms."}
    ]
)

print(response.choices[0].message.content)
```

### Multi-Model Comparison

```python
import os
from openai import OpenAI
from anthropic import Anthropic
import google.generativeai as genai

prompt = "What is the meaning of life?"

# OpenAI
openai_client = OpenAI()
openai_response = openai_client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=[{"role": "user", "content": prompt}]
)
print("GPT-4:", openai_response.choices[0].message.content)

# Claude
claude_client = Anthropic()
claude_response = claude_client.messages.create(
    model="claude-3-opus-20240229",
    max_tokens=1024,
    messages=[{"role": "user", "content": prompt}]
)
print("Claude:", claude_response.content[0].text)

# Gemini
genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
gemini_model = genai.GenerativeModel('gemini-pro')
gemini_response = gemini_model.generate_content(prompt)
print("Gemini:", gemini_response.text)
```

---

## 🛠️ Helper Commands

### Environment Management

```bash
# Load AI environment variables
ai-load-env

# Check API key status
ai-check-keys

# List available models
ai-list-models
```

### Testing Commands

```bash
# Test OpenAI
ai-test-openai

# Test Claude
ai-test-claude

# Test Gemini
ai-test-gemini

# Full verification
python verify-ai-setup.py
```

### Python Environment

```bash
# Show Python version
python --version

# Show installed packages
pip list

# Update all packages
pip list --outdated
pip install --upgrade <package>

# Create virtual environment for a project
python -m venv venv
source venv/bin/activate
```

### Development Tools

```bash
# Interactive Python shell
ipython

# Jupyter notebook
jupyter notebook

# Jupyter lab
jupyter lab

# Format Python code
black your_script.py

# Lint Python code
ruff your_script.py
```

---

## 🔍 Troubleshooting

### Common Issues

#### 1. **Homebrew Installation Fails**

```bash
# Check Xcode Command Line Tools
xcode-select -p

# Reinstall if needed
xcode-select --install
```

#### 2. **Python Version Issues**

```bash
# Verify pyenv installation
pyenv --version

# List installed Python versions
pyenv versions

# Set global Python version
pyenv global 3.11.7

# Verify
python --version
```

#### 3. **API Key Not Found**

```bash
# Check if environment file exists
ls -la ~/.env.d/

# Verify environment is loaded
ai-load-env

# Print specific variable (for debugging)
echo $OPENAI_API_KEY
```

#### 4. **Package Import Errors**

```bash
# Verify package installation
pip list | grep openai

# Reinstall package
pip install --upgrade --force-reinstall openai

# Check Python path
which python
python -c "import sys; print(sys.path)"
```

#### 5. **ffmpeg Not Found**

```bash
# Install ffmpeg
brew install ffmpeg

# Verify installation
ffmpeg -version
```

#### 6. **Permission Errors**

```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) /usr/local/*

# For Apple Silicon
sudo chown -R $(whoami) /opt/homebrew/*
```

### Getting Help

1. **Check logs**: Most errors will show detailed error messages
2. **Run verification**: `python verify-ai-setup.py` to diagnose issues
3. **Check API status**: Visit service status pages
   - OpenAI: https://status.openai.com/
   - Anthropic: https://status.anthropic.com/
4. **Review documentation**: Each service has detailed API docs
5. **Check rate limits**: API calls may be throttled

---

## 🚀 Advanced Configuration

### Using Multiple Python Versions

```bash
# Install another Python version
pyenv install 3.10.13

# Create project-specific version
cd your-project
pyenv local 3.10.13

# Verify
python --version
```

### Virtual Environments

```bash
# Create virtual environment
python -m venv ai-env

# Activate
source ai-env/bin/activate

# Install packages
pip install -r requirements-ai-macos.txt

# Deactivate
deactivate
```

### Custom Environment Files

Create separate environment files for different projects:

```bash
~/.env.d/
├── ai-services.env          # Main AI keys
├── project-a.env            # Project A specific
├── project-b.env            # Project B specific
└── production.env           # Production keys
```

Load specific environment:
```bash
source ~/.env.d/project-a.env
```

### Performance Optimization

#### For Apple Silicon Macs

```bash
# Install conda/miniforge for optimized ML packages
brew install --cask miniforge

# Initialize
conda init zsh

# Create environment
conda create -n ai python=3.11
conda activate ai

# Install with conda (uses optimized ARM64 builds)
conda install pytorch torchvision -c pytorch
```

#### For Intel Macs

```bash
# Use standard pip installation
pip install torch torchvision
```

### Environment Auto-Loading

Add to `~/.zshrc` or `~/.bash_profile`:

```bash
# Auto-load AI environment on terminal start
if [ -f "$HOME/.env.d/ai-services.env" ]; then
    source "$HOME/.env.d/ai-services.env"
fi

# Or use the helper
ai-load-env
```

### Custom Helper Functions

Add your own helpers to `~/.ai-helpers.sh`:

```bash
# Quick OpenAI chat
ai-chat() {
    python -c "
from openai import OpenAI
client = OpenAI()
response = client.chat.completions.create(
    model='gpt-4-turbo-preview',
    messages=[{'role': 'user', 'content': '$1'}]
)
print(response.choices[0].message.content)
"
}

# Usage
ai-chat "What is the weather like?"
```

### Monitoring API Usage

```python
import os
from openai import OpenAI

client = OpenAI()

# Track usage
response = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    messages=[{"role": "user", "content": "Hello"}]
)

print(f"Tokens used: {response.usage.total_tokens}")
print(f"Prompt tokens: {response.usage.prompt_tokens}")
print(f"Completion tokens: {response.usage.completion_tokens}")
```

---

## 📚 Additional Resources

### Official Documentation

- **OpenAI**: https://platform.openai.com/docs
- **Anthropic**: https://docs.anthropic.com/
- **Google AI**: https://ai.google.dev/docs
- **Groq**: https://console.groq.com/docs

### Python AI Frameworks

- **LangChain**: https://python.langchain.com/
- **LlamaIndex**: https://docs.llamaindex.ai/
- **Semantic Kernel**: https://learn.microsoft.com/semantic-kernel/

### Learning Resources

- **OpenAI Cookbook**: https://github.com/openai/openai-cookbook
- **Anthropic Examples**: https://github.com/anthropics/anthropic-cookbook
- **Google AI Tutorials**: https://ai.google.dev/tutorials

---

## 📝 License

This setup guide is provided as-is for educational and development purposes.

---

## 🤝 Contributing

Found an issue or have a suggestion? Contributions are welcome!

---

## ✨ Summary

You now have a complete AI development environment on macOS with:

- ✅ All major AI services configured
- ✅ Python 3.11+ with package management
- ✅ Essential development tools
- ✅ Secure API key management
- ✅ Helper scripts for quick testing
- ✅ Verification tools

**Start building with AI today!** 🚀

---

*Last updated: 2024-11-06*
