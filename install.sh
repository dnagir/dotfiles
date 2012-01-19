#!bash
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/gvimrc ~/.gvimrc
ln -sf ~/dotfiles/vim/dotvim ~/.vim

ln -sf ~/dotfiles/bash/bashrc ~/.bashrc
echo ". ~/.bashrc # this file will be overwritten on next install" > ~/.bash_profile
ln -sf ~/dotfiles/bash/intputrc ~/.inputrc

ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/gitignore_global ~/.gitignore_global

ln -sf ~/dotfiles/ssh/config ~/.ssh/config
