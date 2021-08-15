#!/usr/bin/env bash

SCRIPT_DIR=./scripts
OUTPUT_DIR=./output

# Make sure GOPATH is set
if [[ -z $GOPATH ]]
then
	echo "Empty GOPATH"
#	exit 1
fi

# Make sure GOBIN is set
if [[ -z $GOBIN ]]
then
	echo "Empty GOBIN"
#	exit 1
fi

# Check if PATH includes GOBIN
echo $PATH | grep -q $GOBIN
if [[ $? -ne 0 ]]
then
	export PATH=$PATH:$GOBIN
fi

# Install Node for ncoc vim
curl -sL install-node.now.sh/lts | bash

# Install Vundle
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy vimrc
cp ${SCRIPT_DIR}/vimrc  ~/.vimrc

# Copy coc-settings.json
cp ${SCRIPT_DIR}/coc-settings.json ~/.vim

# Install plugin
vim +PlugInstall +qall
vim +GoInstallBinaries +qall

# Install rust coc analyzer
vim -c 'CocInstall coc-rust-analyzer|q'

# generate sample ccls
cd ${SCRIPT_DIR}

case "$OSTYPE" in
  solaris*) 
	  echo "SOLARIS" 
	  ;;
  darwin*)  
	  echo "OSX" 
	  ./install_ccls_darwin.sh
	  ./install_clang_format_darwin.sh
	  ;;
  linux*)   
	  echo "LINUX" 
	  ./install_ccls_linux.sh
	  ./install_clang_format_linux.sh
	  ;;
  bsd*)     
	  echo "BSD" 
	  ;;
  msys*)    
	  echo "WINDOWS" 
	  ;;
  *)        
	  echo "unknown: $OSTYPE" 
	  ;;
esac

cd ..
