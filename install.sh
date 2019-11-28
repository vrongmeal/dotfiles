# --------------------------------------------------------------------
# This script installs all the required packages and softwares
# Also copies the `dotfiles` and configures zsh, git and nvim and tmux
# --------------------------------------------------------------------

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# ------------------------------------
# Install other packages with Homebrew
# ------------------------------------

# To install packages, add to this list
brew_install=(
	zsh
	git
	neovim
	tmux
	go
	node
	python3
	wget
	rbenv
	zsh-syntax-highlighting
	kubectl
	minikube
)
for package in ${brew_install[*]}
do
	brew install package
done

# ---

# ---
# ZSH
# ---

# Change default shell to zsh
chsh -s /bin/zsh

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Copy the dotfile
cp ./zsh/zshrc ~/.zshrc

# ---

# ------
# Neovim
# ------

# Pynvim for neovim python support
pip3 install --user pynvim

# Vim-Plug for dependency management
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the dotfile
cp ./nvim/init.vim ~/.config/nvim/init.vim

# [TODO] Run :PlugInstall when starting nvim

# ---

# --------------
# Other dotfiles
# --------------

# Git
cp ./git/gitconfig ~/.gitconfig

# Tmux
cp ./tmux/tmux.conf ~/.tmux.conf

# ---

# Extract SF Mono font for global use
cp /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf ~/Library/Fonts

# ---------------
# Other Downloads
# ---------------

# Because somethings cannot be installed directly :(

other_downloads=(
	https://www.google.com/chrome/
	https://hub.docker.com/editions/community/docker-ce-desktop-mac
	https://sourcegear.com/diffmerge/downloads.php
)
for download in ${other_downloads[*]}
do
	open download # Opens in Safari
done

# ---

# Powerlevel10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cp ./zsh/p10k.zsh ~/.p10k.zsh

# -----------------
# Language specific
# -----------------

# Python
pip3 install jedi

# Go
go get -u github.com/stamblerre/gocode
go get -u github.com/sqs/goreturns

# Javascript
npm install -g prettier
npm install -g eslint
