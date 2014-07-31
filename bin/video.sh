#!/bin/bash - 
#===============================================================================
#
#          FILE: video.sh
# 
#         USAGE: ./video.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2014年07月30日 23:07
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

mplayer -vo x11 -geometry 1040:10 -zoom -x 400 -y 300 $1 
