# ==============================================================================
#
#  ___      ___ ________  ________  ________   ________  _____ ______   _______   ________  ___
# |\  \    /  /|\   __  \|\   __  \|\   ___  \|\   ____\|\   _ \  _   \|\  ___ \ |\   __  \|\  \
# \ \  \  /  / | \  \|\  \ \  \|\  \ \  \\ \  \ \  \___|\ \  \\\__\ \  \ \   __/|\ \  \|\  \ \  \
#  \ \  \/  / / \ \   _  _\ \  \\\  \ \  \\ \  \ \  \  __\ \  \\|__| \  \ \  \_|/_\ \   __  \ \  \
#   \ \    / /   \ \  \\  \\ \  \\\  \ \  \\ \  \ \  \|\  \ \  \    \ \  \ \  \_|\ \ \  \ \  \ \  \____
#    \ \__/ /     \ \__\\ _\\ \_______\ \__\\ \__\ \_______\ \__\    \ \__\ \_______\ \__\ \__\ \_______\
#     \|__|/       \|__|\|__|\|_______|\|__| \|__|\|_______|\|__|     \|__|\|_______|\|__|\|__|\|_______|
#
#
# Hello, World! This is my `~/.zshrc`.
#
# ==============================================================================

# ==============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#
# ==============================================================================

# ==============================================================================
# ZSH configurations
#
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Shell theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Completion for some-command and some_command is same
HYPHEN_INSENSITIVE="true"

# Display red-dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git)

# Activate Oh My Zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable syntax highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable zsh-vi-mode
source /usr/local/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
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

# User bin
test -d "${HOME}/bin" || mkdir "${HOME}/bin"
export PATH="$PATH:${HOME}/bin"

# Golang
export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix go)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export GO111MODULE=auto
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Rust (Cargo)
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby and rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"

# CLion CMake
export PATH="/Applications/CLion.app/Contents/bin/cmake/mac/bin:$PATH"
#
# ==============================================================================

# ==============================================================================
# Program specific settings
#
# YDiff options
export YDIFF_OPTIONS='-s -w 0 -t 2 --wrap'

# Change directory from arguments when opening nvim
# Also alias nvim as vim
vim() {
	if [ "$#" -eq 1 ]
	then
		if test -d $1
		then
			nvim $1 +':cd %'
		else
			nvim $1 +':cd %:h'
		fi
	else
		nvim
	fi
}
alias vi=vim
#
# ==============================================================================

# ==============================================================================
# Print welcome message
#
echo
echo "${USER}@$(uname -n)"
echo
#
# ==============================================================================
