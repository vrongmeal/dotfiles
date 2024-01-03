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
bindkey '^L' my-clear
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
export TERM="tmux-256color"

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

# Ruby and rbenv
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# eval "$(rbenv init -)"

# CLion CMake
export PATH="/Applications/CLion.app/Contents/bin/cmake/mac/bin:$PATH"

# GHC
[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vrongmeal/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/vrongmeal/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vrongmeal/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/vrongmeal/google-cloud-sdk/completion.zsh.inc'; fi

# Enable node@18
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# LLVM downloaded from brew
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# MySQL (client only)
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# bun completions
[ -s "/Users/vrongmeal/.bun/_bun" ] && source "/Users/vrongmeal/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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
export YDIFF_OPTIONS='-s -w 0 -t 2 --wrap'

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

t() {
	tmux new-session -As default
}

alias grep=rg
alias find=fd
alias ls=eza

export GLARE_DEV_HOST=localhost
#
# ==============================================================================

# ==============================================================================
# Print welcome message
#
echo
gradient-figlet "# ! / ${USER}" -lmt summer
echo
#
# ==============================================================================
