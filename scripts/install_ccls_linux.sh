#!/usr/bin/env bash

OUTPUT_DIR=../output

if ! type snap &> /dev/null
then
	echo "snap not found, installing snap"
	sudo apt install snapd
fi

# install ccls
sudo snap install ccls --classic

# install llvm
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

mkdir -p ${OUTPUT_DIR}

cat >> ${OUTPUT_DIR}/ccls << EOF
clang
-ccc-install-dir
/usr/bin
%cpp -std=c++11
%cpp -stdlib=libc++
EOF
