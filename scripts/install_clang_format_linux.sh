#/usr/bin/env bash

sudo apt-get install clang-format

echo " \
map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr> \n \
imap <C-K> <c-o>:py3f /usr/share/vim/addons/syntax/clang-format.py<cr> \n \
" >> ~/.vimrc
