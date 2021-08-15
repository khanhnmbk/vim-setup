#/usr/bin/env bash

brew install clang-format

echo "
map <C-K> :py3f /usr/local/Cellar/clang-format/11.1.0/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/local/Cellar/clang-format/11.1.0/share/clang/clang-format.py<cr>
" >> ~/.vimrc
