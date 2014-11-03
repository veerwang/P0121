#!/bin/bash - 
#===============================================================================
#
#          FILE: mkycm.sh
# 
#         USAGE: ./mkycm.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2014年11月03日 21:11
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/library_tools_game_repository/llvm . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp;make ycm_support_libs
