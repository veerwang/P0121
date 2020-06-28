#!/bin/bash - 
#===============================================================================
#
#          FILE: mkvim.sh
# 
#         USAGE: ./mkvim.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019年08月25日 11:48
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#! /bin/bash
./configure --with-compiledby=kevin.wang --enable-multibyte --with-ruby-command=ruby --enable-rubyinterp=yes --with-features=huge --enable-fontset --enable-cscope --enable-gnome-check=yes --enable-gui=yes --enable-xim --enable-pythoninterp=yes --enable-python3interp=yes --with-python3-command=python --with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu --enable-luainterp=yes
