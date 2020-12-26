#!/usr/bin/env bash

# Make sure GOPATH is set
if [[ -z $GOPATH ]]
then
	echo "Empty GOPATH"
	exit 1
fi

# Make sure GOBIN is set
if [[ -z $GOBIN ]]
then
	echo "Empty GOBIN"
	exit 1
fi

# Check if PATH includes GOBIN
echo $PATH | grep -q $GOBIN
if [[ $? -ne 0 ]]
then
	export PATH=$PATH:$GOBIN
fi

# Check sample vimrc file
if [[ $# -ne 1 ]]
then
    echo "Please specify sample vimrc path"
    exit 1
fi

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy vimrc
cp $1 ~/.vimrc

# Install plugin
vim +PluginInstall +qall
vim +GoInstallBinaries +qall
