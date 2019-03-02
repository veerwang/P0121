"==========================================================================================
"
" Authot: 	kevin.wang
" Date:   	2019.03.02
" Description:  通用设置
"
"==========================================================================================
filetype plugin indent on
" 1) set the line number 
"let g:solarized_termcolors=256
set nu
set relativenumber

" 2) set the syntax on
syntax on

" 6) set file code-write sets
set encoding=utf-8
set fileencoding=utf-8
set fencs=utf-8,gb18030,gbk,gb2312,cp936

" 7) Set the lines of history
set history=400 

" 8)
set clipboard+=unnamed

"9) just show content in single line
set wrap

"10) make the information no full screen
set nomore

"11) when exit vim save content on screen
set t_ti= t_te=

"12) auto style in C program
set cin

"13) do not backup file when over-written file
set nobackup
set nowritebackup

"14)set short message cut 
set shortmess=atl

"15)set the tags file name
set tags=./.tags;,.tags;,./tags

"16) turn the wild menu
set wildmenu

"17) turn off the error bell
set noerrorbells

"18)
set ignorecase

"19)
set autochdir

"20)set search result high light 
set hlsearch

"21)set ruler
set ruler

"22)set ruler
set so=7

"23)set no compatible mode of VIM
set nocompatible

"24)Set to auto read when a file is changed from the outside
set autoread

"25)Have the mouse enabled all the time:
set mouse=a

"26)
set nocp

"27) match {} setting
set showmatch
set matchtime=5

"31) set path of system head file
set path+=/usr/local/include

"32)
set t_Co=256
set background=light

"33) terminal 
"set termwinsize=8x200
set termwinsize=
