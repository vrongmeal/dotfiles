# ==============================================================================
# ZSH configurations
#
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Shell theme
ZSH_THEME="robbyrussell"

# Completion for some-command and some_command is same
HYPHEN_INSENSITIVE="true"

# Display red-dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
	git
	# vi-mode
	poetry
)

# Activate Oh My Zsh
source $ZSH/oh-my-zsh.sh
#
# ==============================================================================

# ==============================================================================
# Setup SSH
#
# SSH key path
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"

# Start ssh agent
eval "$(ssh-agent -s)" > /dev/null 2>&1
#
# ==============================================================================

# ==============================================================================
# Terminal settings
#
# Terminal colors
export TERM="xterm-256color"

# Locale
export LC_ALL=en_US.UTF-8
#
# ==============================================================================

# ==============================================================================
# Required paths
#
# Homebrew
export PATH="/usr/local/sbin:$PATH"

# .local/bin
export PATH="$HOME/.local/bin:$PATH"

# Golang
export PATH="$PATH:$(go env GOPATH)/bin"

# Rust (Cargo)
source "$HOME/.cargo/env"

# LMStudio
export PATH="$PATH:$HOME/.lmstudio/bin"

# Editor
export EDITOR="hx"

# bun completions
[ -s "/Users/vrongmeal/.bun/_bun" ] && source "/Users/vrongmeal/.bun/_bun"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
#
# ==============================================================================

# ==============================================================================
# Print welcome message
#
echo
echo "Hello, World!"
echo
#
# ==============================================================================
