#!/bin/bash
set -euo pipefail

echo >&2 "Installing bash config"
bashrcIncludeString="source $HOME/dotfiles/bash/.bashrc"
grep -qxF "$bashrcIncludeString" $HOME/.bashrc || echo "$bashrcIncludeString" >>$HOME/.bashrc
ln -sf $HOME/dotfiles/bash/.inputrc $HOME/.inputrc


echo >&2 "Installing git config"
ln -sf $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/git/.gitignore_global $HOME/.gitignore_global

echo >&2 "Installing SSH config"
ln -sf $HOME/dotfiles/ssh/config $HOME/.ssh/config

echo >&2 "Installing RubyGems config"
ln -sf $HOME/dotfiles/.gemrc $HOME/.gemrc

echo >&2 "Installing vim config"
ln -sf $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -sf $HOME/dotfiles/vim/.vim $HOME/.vim
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim || echo "Vundle probably already exists"
vim +PluginInstall +qall
