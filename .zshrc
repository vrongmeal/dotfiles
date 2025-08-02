# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# Powerlevel 10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
#
# ==============================================================================

# ==============================================================================
# ZSH configurations
#
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Shell theme
# ZSH_THEME="robbyrussell"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
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
export PATH="/Users/vrongmeal/.local/bin:$PATH"

# Golang
# export GOPATH="${HOME}/go"
# export GOROOT="$(brew --prefix go)/libexec"
# export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
# export GO111MODULE=auto
# test -d "${GOPATH}" || mkdir "${GOPATH}"
# test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Rust (Cargo)
# source "$HOME/.cargo/env"

# Editor
export EDITOR="hx"
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
