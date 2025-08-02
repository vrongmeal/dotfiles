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

my-clear() {
  for i in {3..`tput lines`}; do printf '\n'; done
  zle clear-screen
}
zle -N my-clear
# bindkey '^L' my-clear
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
source "$HOME/.cargo/env"

# Editor
export EDITOR="hx"

# SnowSQL
alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql
#
# ==============================================================================

# ==============================================================================
# Program specific settings
#
# YDiff options
# export YDIFF_OPTIONS='-s -w 0 -t 2 --wrap'

# Change directory from arguments when opening nvim
# Also alias nvim as vim
# vim() {
# 	if [ "$#" -eq 1 ]
# 	then
# 		if test -d $1
# 		then
# 			nvim $1 +':cd %'
# 		else
# 			nvim $1 +':cd %:h'
# 		fi
# 	else
# 		nvim
# 	fi
# }
alias vi=vim

alias grep=rg
alias find=fd
alias ls=eza
#
# ==============================================================================

# Work related stuff

# Sign into one password
# eval $(op signin)

export S2_CELL_ID="vaibhav-0"
export S2_CLOUD="aws"
export S2_ENV="sandbox"
export S2_CHANNEL_ID="h4z1zbw7caydv2mg"
export S2_NODE_ENDPOINT="localhost:4242"
export S2_STORAGE_CLASS="express"
export AWS_PROFILE=sandbox-${S2_CELL_ID}-AWSAdministratorAccess
export RUST_LOG=info

source /Users/vrongmeal/Code/github.com/s2-streamstore/s2/dev/s2.zsh

# ==============================================================================
# Print welcome message
#
echo
echo "Hello, World!"
echo
#
# ==============================================================================

# add S2 to the PATH
export PATH=$PATH:/Users/vrongmeal/.s2/bin

# add protobuf to PATH
export PATH="$PATH:$HOME/protobuf/bin"

# pnpm
export PNPM_HOME="/Users/vrongmeal/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export PATH="/Users/vrongmeal/.local/bin:$PATH"
