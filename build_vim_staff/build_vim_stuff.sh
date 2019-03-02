#! /bin/sh
echo "1.Start <--- Download vim-Plug scripts"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "2.Start <--- Copy vimrc file into ~/.vim/"
    cp -f ./vimrc ~/.vimrc
echo "3.Start <--- make env"
    mkdir -p ~/.vim/undodir
    cp ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
    cp -R config ~/.vim/config
    mkdir -p ~/.vim/notes
