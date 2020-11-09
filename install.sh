#!/bin/bash
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/gvimrc ~/.gvimrc
ln -sf ~/dotfiles/vim/dotvim ~/.vim


bashrcIncludeString="source ~/dotfiles/bash/bashrc"
grep -qxF "$bashrcIncludeString" ~/.bashrc || echo "$bashrcIncludeString" >> ~/.bashrc

ln -sf ~/dotfiles/bash/inputrc ~/.inputrc

ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/gitignore_global ~/.gitignore_global

ln -sf ~/dotfiles/ssh/config ~/.ssh/config

ln -sf ~/dotfiles/gemrc ~/.gemrc
