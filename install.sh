#!bash
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/gvimrc ~/.gvimrc

ln -sf ~/dotfiles/bash/bashrc ~/.bashrc
echo ". ~/.bashrc # this file will be overwritten on next install" > ~/.bash_profile
