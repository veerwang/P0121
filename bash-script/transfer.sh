#!/bin/bash - 
#===============================================================================
#
#          FILE: transfer.sh
# 
#         USAGE: ./transfer.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月08日 17:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

rsync -av rsync-dir wwei@172.27.16.70:/home/wwei/rsync-dir
