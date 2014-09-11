#!/bin/bash - 
#===============================================================================
#
#          FILE: delsvn.sh
# 
#         USAGE: ./delsvn.sh 
# 
#   DESCRIPTION: 删除当前目录下以及子目录下的全部.svn文件
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2014年07月26日 21:54
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

find . -name .svn -type d | xargs rm -rf
