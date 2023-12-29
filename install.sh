#!/bin/bash
set -euo pipefail

echo >&2 "Installing bash config"
bashrcIncludeString="source $HOME/dotfiles/shell/.bashrc"
grep -qxF "$bashrcIncludeString" $HOME/.bashrc || echo "$bashrcIncludeString" >>$HOME/.bashrc
ln -sf $HOME/dotfiles/shell/.inputrc $HOME/.inputrc

echo >&2 "Installing zsh config"
if [ ! -d "$HOME/.oh-my-zsh" ]
then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
fi
zshrcIncludeString="source $HOME/dotfiles/shell/.zshrc"
grep -qxF "$zshrcIncludeString" $HOME/.zshrc || echo "$zshrcIncludeString" >>$HOME/.zshrc


echo >&2 "Installing git config"
ln -sf $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/git/.gitignore_global $HOME/.gitignore_global
ln -sf $HOME/dotfiles/git/.gitattributes_global $HOME/.gitattributes_global

echo >&2 "Installing SSH config"
ln -sf $HOME/dotfiles/ssh/config $HOME/.ssh/config

echo >&2 "Installing RubyGems config"
ln -sf $HOME/dotfiles/.gemrc $HOME/.gemrc

echo >&2 "Installing NeoVim config"
mkdir -p $HOME/.config
ln -sf $HOME/dotfiles/nvim $HOME/.config

echo >&2 "Installing vim config"
mkdir -p "$HOME/.vim/bundle"
ln -sf $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim || echo "Vundle probably already exists"
vim +PluginInstall +qall
