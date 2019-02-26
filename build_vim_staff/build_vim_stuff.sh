#! /bin/sh
echo "1.Start <--- Download vim-Plug scripts"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "2.Start <--- Copy vimrc file into ~/.vim/"
    cp -f ./vimrc ~/.vimrc
