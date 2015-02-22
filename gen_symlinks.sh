#!/bin/zsh

TGT_DIR = $1

ln -s `pwd`/fasdrc $TGT_DIR/.fasdrc
ln -s `pwd`/gitconfig $TGT_DIR/.gitconfig
ln -s `pwd`/gitignore $TGT_DIR/.gitignore
ln -s `pwd`/tmux.conf $TGT_DIR/.tmux.conf
ln -s `pwd`/tmux-powerline $TGT_DIR/.tmux-powerline
ln -s `pwd`/vim $TGT_DIR/.vim
ln -s `pwd`/vimrc $TGT_DIR/.vimrc
ln -s `pwd`/zshenv $TGT_DIR/.zshenv
ln -s `pwd`/zshrc $TGT_DIR/.zshrc
ln -s `pwd`/zpreztorc $TGT_DIR/.zpreztorc

