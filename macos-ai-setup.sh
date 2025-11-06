#!/bin/bash

# ============================================================================
# macOS Intel Terminal Tools Setup for AI Development
# Supports: OpenAI, Claude (Anthropic), Gemini (Google), Grok (xAI)
# ============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  macOS AI Development Environment Setup                  ║${NC}"
    echo -e "${BLUE}║  OpenAI • Claude • Gemini • Grok                          ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only"
        exit 1
    fi
    
    # Check for Intel vs Apple Silicon
    ARCH=$(uname -m)
    if [[ "$ARCH" == "x86_64" ]]; then
        print_info "Detected Intel Mac (x86_64)"
        HOMEBREW_PREFIX="/usr/local"
    elif [[ "$ARCH" == "arm64" ]]; then
        print_warning "Detected Apple Silicon Mac - using Rosetta 2 for Intel tools"
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        print_error "Unknown architecture: $ARCH"
        exit 1
    fi
    print_success "macOS detected and verified"
}

# Install Homebrew if not present
install_homebrew() {
    print_info "Checking for Homebrew..."
    
    if command -v brew &> /dev/null; then
        print_success "Homebrew already installed: $(brew --version | head -n1)"
        brew update
    else
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon
        if [[ "$ARCH" == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        print_success "Homebrew installed successfully"
    fi
}

# Install essential command-line tools
install_cli_tools() {
    print_info "Installing essential CLI tools..."
    
    # Essential tools for development
    TOOLS=(
        "git"           # Version control
        "curl"          # HTTP client
        "wget"          # File downloader
        "jq"            # JSON processor
        "tree"          # Directory tree viewer
        "htop"          # Process viewer
        "neovim"        # Text editor
        "ripgrep"       # Fast search
        "fzf"           # Fuzzy finder
        "bat"           # Better cat
        "exa"           # Better ls
        "fd"            # Better find
        "gh"            # GitHub CLI
        "ffmpeg"        # Media processing
        "imagemagick"   # Image processing
    )
    
    for tool in "${TOOLS[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_info "Installing $tool..."
            brew install "$tool"
            print_success "$tool installed"
        fi
    done
}

# Install Python using pyenv for better version management
install_python() {
    print_info "Setting up Python environment..."
    
    # Install pyenv
    if command -v pyenv &> /dev/null; then
        print_success "pyenv already installed"
    else
        print_info "Installing pyenv..."
        brew install pyenv pyenv-virtualenv
        
        # Add to shell configuration
        SHELL_CONFIG="$HOME/.zshrc"
        if [[ ! -f "$SHELL_CONFIG" ]]; then
            SHELL_CONFIG="$HOME/.bash_profile"
        fi
        
        cat >> "$SHELL_CONFIG" << 'EOF'

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
        
        # Load pyenv for current session
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        
        print_success "pyenv installed and configured"
    fi
    
    # Install Python 3.11 (recommended for AI development)
    PYTHON_VERSION="3.11.7"
    if pyenv versions | grep -q "$PYTHON_VERSION"; then
        print_success "Python $PYTHON_VERSION already installed"
    else
        print_info "Installing Python $PYTHON_VERSION..."
        pyenv install "$PYTHON_VERSION"
        print_success "Python $PYTHON_VERSION installed"
    fi
    
    # Set as global default
    pyenv global "$PYTHON_VERSION"
    print_success "Python $(python --version) set as default"
}

# Create environment directory structure
setup_environment_dirs() {
    print_info "Setting up environment directories..."
    
    ENV_DIR="$HOME/.env.d"
    mkdir -p "$ENV_DIR"
    
    # Create .gitignore for the env directory
    cat > "$ENV_DIR/.gitignore" << 'EOF'
# Ignore all .env files (they contain secrets)
*.env

# Allow .env.template files
!*.env.template
EOF
    
    print_success "Environment directory created at $ENV_DIR"
}

# Create AI services environment template
create_env_template() {
    print_info "Creating environment template..."
    
    ENV_TEMPLATE="$HOME/.env.d/ai-services.env.template"
    
    cat > "$ENV_TEMPLATE" << 'EOF'
# ============================================================================
# AI Services API Keys Configuration
# Copy this file to ai-services.env and fill in your actual API keys
# ============================================================================

# OpenAI Configuration
# Get your API key from: https://platform.openai.com/api-keys
OPENAI_API_KEY=sk-proj-...your-key-here...
OPENAI_ORG_ID=org-...your-org-id...  # Optional
OPENAI_MODEL=gpt-4-turbo-preview  # Default model

# Anthropic (Claude) Configuration
# Get your API key from: https://console.anthropic.com/
ANTHROPIC_API_KEY=sk-ant-...your-key-here...
CLAUDE_MODEL=claude-3-opus-20240229  # Default model

# Google (Gemini) Configuration
# Get your API key from: https://makersuite.google.com/app/apikey
GOOGLE_API_KEY=AIza...your-key-here...
GEMINI_MODEL=gemini-pro  # Default model

# xAI (Grok) Configuration
# Get your API key from: https://x.ai/api
XAI_API_KEY=xai-...your-key-here...
GROK_MODEL=grok-beta  # Default model

# ============================================================================
# Additional AI Services (Optional)
# ============================================================================

# Groq (Fast LLM Inference)
# Get your API key from: https://console.groq.com/
GROQ_API_KEY=gsk_...your-key-here...

# Replicate (AI Models API)
# Get your API key from: https://replicate.com/account
REPLICATE_API_TOKEN=r8_...your-key-here...

# Hugging Face
# Get your API key from: https://huggingface.co/settings/tokens
HUGGINGFACE_TOKEN=hf_...your-key-here...

# Stability AI (Stable Diffusion)
# Get your API key from: https://platform.stability.ai/
STABILITY_API_KEY=sk-...your-key-here...

# ElevenLabs (Voice AI)
# Get your API key from: https://elevenlabs.io/
ELEVENLABS_API_KEY=...your-key-here...

# ============================================================================
# Development Configuration
# ============================================================================

# Python Environment
PYTHONUNBUFFERED=1
PYTHONDONTWRITEBYTECODE=1

# Logging
LOG_LEVEL=INFO

# Default Temperature for AI Models
AI_TEMPERATURE=0.7
AI_MAX_TOKENS=2048

# ============================================================================
# Usage Instructions
# ============================================================================
# 1. Copy this file: cp ai-services.env.template ai-services.env
# 2. Fill in your actual API keys
# 3. Never commit the .env file to version control
# 4. Source the file: source ~/.env.d/ai-services.env
EOF
    
    print_success "Environment template created at $ENV_TEMPLATE"
    print_warning "Copy the template and add your API keys:"
    print_info "cp $ENV_TEMPLATE $HOME/.env.d/ai-services.env"
}

# Install Python packages for AI development
install_python_packages() {
    print_info "Installing Python packages for AI development..."
    
    # Upgrade pip
    pip install --upgrade pip setuptools wheel
    
    # Install packages from requirements file if it exists
    if [[ -f "requirements-ai-macos.txt" ]]; then
        print_info "Installing from requirements-ai-macos.txt..."
        pip install -r requirements-ai-macos.txt
    else
        print_info "Installing essential AI packages..."
        
        # Core AI SDKs
        pip install openai>=1.0.0
        pip install anthropic>=0.8.0
        pip install google-generativeai>=0.3.0
        pip install groq>=0.4.0
        
        # Environment management
        pip install python-dotenv>=1.0.0
        
        # HTTP clients
        pip install requests>=2.31.0
        pip install httpx>=0.25.0
        pip install aiohttp>=3.9.0
        
        # Data processing
        pip install pandas>=2.1.0
        pip install numpy>=1.24.0
        
        # CLI tools
        pip install rich>=13.0.0
        pip install click>=8.1.0
        pip install tqdm>=4.66.0
        
        # Audio processing
        pip install pydub>=0.25.0
        pip install openai-whisper>=20231117
        
        # Image processing
        pip install pillow>=10.0.0
        pip install opencv-python>=4.8.0
        
        # Development tools
        pip install ipython>=8.18.0
        pip install jupyter>=1.0.0
        pip install black>=23.0.0
        pip install ruff>=0.1.0
    fi
    
    print_success "Python packages installed successfully"
}

# Create shell helper functions
create_shell_helpers() {
    print_info "Creating shell helper functions..."
    
    HELPER_FILE="$HOME/.ai-helpers.sh"
    
    cat > "$HELPER_FILE" << 'EOF'
#!/bin/bash

# ============================================================================
# AI Development Helper Functions
# Source this file in your shell: source ~/.ai-helpers.sh
# ============================================================================

# Load all AI environment variables
ai-load-env() {
    ENV_DIR="$HOME/.env.d"
    if [[ -f "$ENV_DIR/ai-services.env" ]]; then
        source "$ENV_DIR/ai-services.env"
        echo "✅ AI environment loaded from $ENV_DIR/ai-services.env"
    else
        echo "⚠️  Environment file not found. Create it from template:"
        echo "   cp $ENV_DIR/ai-services.env.template $ENV_DIR/ai-services.env"
        return 1
    fi
}

# Quick test OpenAI connection
ai-test-openai() {
    ai-load-env
    python3 -c "
from openai import OpenAI
client = OpenAI()
response = client.chat.completions.create(
    model='gpt-3.5-turbo',
    messages=[{'role': 'user', 'content': 'Say hello!'}],
    max_tokens=50
)
print('✅ OpenAI API working!')
print(f'Response: {response.choices[0].message.content}')
"
}

# Quick test Claude connection
ai-test-claude() {
    ai-load-env
    python3 -c "
from anthropic import Anthropic
client = Anthropic()
message = client.messages.create(
    model='claude-3-haiku-20240307',
    max_tokens=50,
    messages=[{'role': 'user', 'content': 'Say hello!'}]
)
print('✅ Claude API working!')
print(f'Response: {message.content[0].text}')
"
}

# Quick test Gemini connection
ai-test-gemini() {
    ai-load-env
    python3 -c "
import google.generativeai as genai
import os
genai.configure(api_key=os.environ['GOOGLE_API_KEY'])
model = genai.GenerativeModel('gemini-pro')
response = model.generate_content('Say hello!')
print('✅ Gemini API working!')
print(f'Response: {response.text}')
"
}

# List all available AI models
ai-list-models() {
    echo "📋 Available AI Models:"
    echo ""
    echo "OpenAI:"
    echo "  - gpt-4-turbo-preview"
    echo "  - gpt-4"
    echo "  - gpt-3.5-turbo"
    echo ""
    echo "Anthropic (Claude):"
    echo "  - claude-3-opus-20240229"
    echo "  - claude-3-sonnet-20240229"
    echo "  - claude-3-haiku-20240307"
    echo ""
    echo "Google (Gemini):"
    echo "  - gemini-pro"
    echo "  - gemini-pro-vision"
    echo ""
    echo "xAI (Grok):"
    echo "  - grok-beta"
}

# Show API key status
ai-check-keys() {
    ai-load-env
    echo "🔑 API Key Status:"
    echo ""
    [[ -n "$OPENAI_API_KEY" ]] && echo "✅ OpenAI: Configured" || echo "❌ OpenAI: Missing"
    [[ -n "$ANTHROPIC_API_KEY" ]] && echo "✅ Claude: Configured" || echo "❌ Claude: Missing"
    [[ -n "$GOOGLE_API_KEY" ]] && echo "✅ Gemini: Configured" || echo "❌ Gemini: Missing"
    [[ -n "$XAI_API_KEY" ]] && echo "✅ Grok: Configured" || echo "❌ Grok: Missing"
    [[ -n "$GROQ_API_KEY" ]] && echo "✅ Groq: Configured" || echo "❌ Groq: Missing"
}

# Auto-load AI environment on shell startup (optional)
# Uncomment the next line to auto-load on every shell session
# ai-load-env
EOF
    
    chmod +x "$HELPER_FILE"
    
    # Add to shell config
    SHELL_CONFIG="$HOME/.zshrc"
    if [[ ! -f "$SHELL_CONFIG" ]]; then
        SHELL_CONFIG="$HOME/.bash_profile"
    fi
    
    if ! grep -q "ai-helpers.sh" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# AI Development Helpers" >> "$SHELL_CONFIG"
        echo "source $HOME/.ai-helpers.sh" >> "$SHELL_CONFIG"
    fi
    
    print_success "Shell helpers created at $HELPER_FILE"
}

# Create Python verification script
create_verification_script() {
    print_info "Creating verification script..."
    
    cat > "verify-ai-setup.py" << 'EOF'
#!/usr/bin/env python3
"""
AI Development Environment Verification Script
Tests all AI services and tools
"""

import os
import sys
from pathlib import Path

# Load environment variables
from pathlib import Path as PathLib
from dotenv import load_dotenv

env_dir = PathLib.home() / ".env.d"
if env_dir.exists():
    for env_file in env_dir.glob("*.env"):
        if env_file.name != ".gitignore" and not env_file.name.endswith(".template"):
            load_dotenv(env_file)

def print_header(text):
    print(f"\n{'='*60}")
    print(f"  {text}")
    print(f"{'='*60}\n")

def test_openai():
    """Test OpenAI API"""
    try:
        from openai import OpenAI
        api_key = os.getenv("OPENAI_API_KEY")
        
        if not api_key or api_key.startswith("sk-proj-..."):
            print("⚠️  OpenAI: API key not configured")
            return False
        
        client = OpenAI(api_key=api_key)
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": "Say 'OK'"}],
            max_tokens=10
        )
        
        print(f"✅ OpenAI API: Working - {response.choices[0].message.content}")
        return True
    except Exception as e:
        print(f"❌ OpenAI API: Failed - {str(e)}")
        return False

def test_anthropic():
    """Test Anthropic (Claude) API"""
    try:
        from anthropic import Anthropic
        api_key = os.getenv("ANTHROPIC_API_KEY")
        
        if not api_key or api_key.startswith("sk-ant-..."):
            print("⚠️  Claude: API key not configured")
            return False
        
        client = Anthropic(api_key=api_key)
        message = client.messages.create(
            model="claude-3-haiku-20240307",
            max_tokens=10,
            messages=[{"role": "user", "content": "Say 'OK'"}]
        )
        
        print(f"✅ Claude API: Working - {message.content[0].text}")
        return True
    except Exception as e:
        print(f"❌ Claude API: Failed - {str(e)}")
        return False

def test_google():
    """Test Google (Gemini) API"""
    try:
        import google.generativeai as genai
        api_key = os.getenv("GOOGLE_API_KEY")
        
        if not api_key or api_key.startswith("AIza..."):
            print("⚠️  Gemini: API key not configured")
            return False
        
        genai.configure(api_key=api_key)
        model = genai.GenerativeModel('gemini-pro')
        response = model.generate_content("Say 'OK'")
        
        print(f"✅ Gemini API: Working - {response.text.strip()}")
        return True
    except Exception as e:
        print(f"❌ Gemini API: Failed - {str(e)}")
        return False

def test_groq():
    """Test Groq API"""
    try:
        from groq import Groq
        api_key = os.getenv("GROQ_API_KEY")
        
        if not api_key or api_key.startswith("gsk_..."):
            print("⚠️  Groq: API key not configured")
            return False
        
        client = Groq(api_key=api_key)
        response = client.chat.completions.create(
            model="mixtral-8x7b-32768",
            messages=[{"role": "user", "content": "Say 'OK'"}],
            max_tokens=10
        )
        
        print(f"✅ Groq API: Working - {response.choices[0].message.content}")
        return True
    except Exception as e:
        print(f"❌ Groq API: Failed - {str(e)}")
        return False

def test_packages():
    """Test installed packages"""
    packages = [
        "openai", "anthropic", "google.generativeai", "groq",
        "dotenv", "requests", "httpx", "aiohttp",
        "pandas", "numpy", "PIL", "cv2",
        "rich", "click", "tqdm"
    ]
    
    missing = []
    for package in packages:
        try:
            if package == "dotenv":
                __import__("dotenv")
            elif package == "PIL":
                __import__("PIL")
            elif package == "cv2":
                __import__("cv2")
            else:
                __import__(package)
            print(f"✅ {package}")
        except ImportError:
            print(f"❌ {package}")
            missing.append(package)
    
    return len(missing) == 0

def main():
    print_header("AI Development Environment Verification")
    
    # Check Python version
    print(f"Python Version: {sys.version}")
    print(f"Python Path: {sys.executable}\n")
    
    # Test packages
    print_header("Testing Python Packages")
    packages_ok = test_packages()
    
    # Test AI APIs
    print_header("Testing AI Service APIs")
    
    results = []
    results.append(("OpenAI", test_openai()))
    results.append(("Claude", test_anthropic()))
    results.append(("Gemini", test_google()))
    results.append(("Groq", test_groq()))
    
    # Summary
    print_header("Summary")
    
    total_tests = len(results)
    passed = sum(1 for _, result in results if result)
    
    print(f"Packages: {'✅ All installed' if packages_ok else '❌ Some missing'}")
    print(f"API Tests: {passed}/{total_tests} passed\n")
    
    if packages_ok and passed == total_tests:
        print("🎉 All systems operational! Ready for AI development.")
    else:
        print("⚠️  Some tests failed. Check API keys in ~/.env.d/ai-services.env")
        print("\nGet API keys from:")
        print("  - OpenAI: https://platform.openai.com/api-keys")
        print("  - Claude: https://console.anthropic.com/")
        print("  - Gemini: https://makersuite.google.com/app/apikey")
        print("  - Grok: https://x.ai/api")
        print("  - Groq: https://console.groq.com/")

if __name__ == "__main__":
    main()
EOF
    
    chmod +x verify-ai-setup.py
    print_success "Verification script created: verify-ai-setup.py"
}

# Main setup function
main() {
    print_header
    
    echo "This script will install and configure:"
    echo "  • Homebrew package manager"
    echo "  • Essential CLI tools (git, curl, jq, ffmpeg, etc.)"
    echo "  • Python 3.11 via pyenv"
    echo "  • AI SDK packages (OpenAI, Claude, Gemini, Grok)"
    echo "  • Environment configuration system"
    echo "  • Helper scripts and verification tools"
    echo ""
    read -p "Continue? (y/n) " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Setup cancelled"
        exit 0
    fi
    
    # Run setup steps
    check_macos
    install_homebrew
    install_cli_tools
    install_python
    setup_environment_dirs
    create_env_template
    install_python_packages
    create_shell_helpers
    create_verification_script
    
    # Final instructions
    print_header
    print_success "🎉 Setup completed successfully!"
    echo ""
    echo "📋 Next Steps:"
    echo ""
    echo "1. Configure your API keys:"
    echo "   cp ~/.env.d/ai-services.env.template ~/.env.d/ai-services.env"
    echo "   nano ~/.env.d/ai-services.env"
    echo ""
    echo "2. Restart your terminal or run:"
    echo "   source ~/.zshrc  # or source ~/.bash_profile"
    echo ""
    echo "3. Load AI environment:"
    echo "   ai-load-env"
    echo ""
    echo "4. Verify installation:"
    echo "   python verify-ai-setup.py"
    echo ""
    echo "5. Test individual services:"
    echo "   ai-test-openai"
    echo "   ai-test-claude"
    echo "   ai-test-gemini"
    echo ""
    echo "6. Check API key status:"
    echo "   ai-check-keys"
    echo ""
    print_info "Helper functions available: ai-load-env, ai-test-*, ai-check-keys, ai-list-models"
    echo ""
}

# Run main function
main
