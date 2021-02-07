#!/usr/bin/env bash

SCRIPT_DIR=./scripts

cd ${SCRIPT_DIR}

# Install ccls
case "$OSTYPE" in
  solaris*) 
	  echo "SOLARIS" 
	  ;;
  darwin*)  
	  echo "OSX" 
	  ./install_ccls_darwin.sh
	  ;;
  linux*)   
	  echo "LINUX" 
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

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy vimrc
cp ${SCRIPT_DIR}/vimrc  ~/.vimrc

# Copy coc-config.json
cp ${SCRIPT_DIR}/coc-settings.json ~/.vim/

# Install plugin
vim +PluginInstall +qall
vim +GoInstallBinaries +qall
