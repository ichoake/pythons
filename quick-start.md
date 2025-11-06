# 🚀 Quick Start - macOS AI Tools Setup

**Get up and running with OpenAI, Claude, Gemini, and Grok in 10 minutes!**

---

## ⚡ Super Quick Setup (3 Commands)

```bash
# 1. Run the setup script
chmod +x macos-ai-setup.sh && ./macos-ai-setup.sh

# 2. Configure your API keys
cp ~/.env.d/ai-services.env.template ~/.env.d/ai-services.env
nano ~/.env.d/ai-services.env  # Add your API keys

# 3. Verify everything works
ai-load-env && python verify-ai-setup.py
```

That's it! You're ready to build with AI. 🎉

---

## 📋 What Gets Installed

| Component | Description |
|-----------|-------------|
| **Homebrew** | macOS package manager |
| **Python 3.11** | Via pyenv for version management |
| **AI SDKs** | OpenAI, Claude, Gemini, Groq, and more |
| **CLI Tools** | git, ffmpeg, jq, and 10+ dev tools |
| **Helper Scripts** | Quick testing and verification commands |

---

## 🔑 Get Your API Keys

Before testing, grab your API keys:

1. **OpenAI**: https://platform.openai.com/api-keys
2. **Claude**: https://console.anthropic.com/
3. **Gemini**: https://makersuite.google.com/app/apikey
4. **Grok**: https://x.ai/api (when available)
5. **Groq**: https://console.groq.com/

Add them to `~/.env.d/ai-services.env`

---

## ✅ Quick Test

```bash
# Load environment
ai-load-env

# Test OpenAI
ai-test-openai

# Test Claude  
ai-test-claude

# Test Gemini
ai-test-gemini

# Check all keys
ai-check-keys
```

---

## 💡 First AI Script

Create `hello-ai.py`:

```python
from openai import OpenAI

client = OpenAI()

response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": "Say hello!"}]
)

print(response.choices[0].message.content)
```

Run it:
```bash
python hello-ai.py
```

---

## 📖 Next Steps

- **Full Guide**: Read `MACOS_AI_SETUP_GUIDE.md` for detailed documentation
- **Requirements**: Check `requirements-ai-macos.txt` for all packages
- **Examples**: See usage examples in the main guide

---

## 🆘 Having Issues?

1. **Run verification**: `python verify-ai-setup.py`
2. **Check API keys**: `ai-check-keys`
3. **View logs**: Most errors show helpful messages
4. **Restart terminal**: After setup, restart your terminal

---

## 🎯 Common Use Cases

### Chat with GPT-4
```bash
python -c "from openai import OpenAI; print(OpenAI().chat.completions.create(model='gpt-4', messages=[{'role':'user','content':'Hello!'}]).choices[0].message.content)"
```

### Generate with Claude
```bash
python -c "from anthropic import Anthropic; print(Anthropic().messages.create(model='claude-3-haiku-20240307', max_tokens=100, messages=[{'role':'user','content':'Hello!'}]).content[0].text)"
```

### Use Gemini
```bash
python -c "import google.generativeai as genai, os; genai.configure(api_key=os.environ['GOOGLE_API_KEY']); print(genai.GenerativeModel('gemini-pro').generate_content('Hello!').text)"
```

---

**Happy coding with AI!** 🤖✨
