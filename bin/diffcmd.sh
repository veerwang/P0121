#!/bin/bash - 
#===============================================================================
#
#          FILE: diffcmd.sh
# 
#         USAGE: ./diffcmd.sh 
# 
#   DESCRIPTION: 
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

diff -a -b -c -r -x .git -x "*.jpg" -x "*.o" -x "*.cmd" -x "*.ko"  $1 $2
