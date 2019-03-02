"==========================================================================================
"
" Authot: 	kevin.wang
" Date:   	2019.03.02
" Description:  插件管理相关 
"
"==========================================================================================

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.vim/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/a.vim'
Plug 'drmikehenry/vim-headerguard'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/Tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-easymotion'
Plug 'idanarye/vim-merginal'
Plug 'vim-scripts/c.vim'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/vim-preview' | Plug 'skywind3000/gutentags_plus'
Plug 'tpope/vim-fugitive'
Plug 'davidhalter/jedi-vim'
Plug 'hdima/python-syntax'
Plug 'mhinz/vim-signify'
Plug 'Yggdroot/LeaderF'
Plug 'vim-scripts/bash-support.vim'
Plug 'will133/vim-dirdiff'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PAntoine/vimgitlog'
Plug 'Timoses/vim-venu'
Plug 'gregsexton/gitv'
Plug 'Shougo/deol.nvim'
Plug 'cohama/agit.vim'
Plug 'luochen1990/rainbow'
Plug 'mhinz/vim-startify'
Plug 'godlygeek/csapprox'
Plug 'chusiang/vim-sdcv'
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'xolox/vim-notes' | Plug 'xolox/vim-misc'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang', 'for': [ 'c','cpp' ] }

call plug#end()

" 由于YCM插件下载时间要比较长，
" 这里按照１００００秒，可以保证正常下载
let g:plug_timeout=10000
