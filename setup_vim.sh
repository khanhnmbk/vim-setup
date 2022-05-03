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
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh | bash
sudo apt install nodejs

# Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
       
# Copy vimrc
mkdir -p $HOME/.config/nvim/
cp ${SCRIPT_DIR}/vimrc   $HOME/.config/nvim/init.vim

# Install plugin
nvim +PlugInstall +qall
nvim +GoInstallBinaries +qall

# generate sample ccls
cd ${SCRIPT_DIR}

case "$OSTYPE" in
  solaris*) 
	  echo "SOLARIS" 
	  ;;
  darwin*)  
	  echo "OSX" 
	  ./install_clang_format_darwin.sh
	  ;;
  linux*)   
	  echo "LINUX" 
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
