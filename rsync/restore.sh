#!/bin/bash - 
#===============================================================================
#
#          FILE: rsync-backup.sh
# 
#         USAGE: ./rsync-backup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2014年11月10日 14:11
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

rsync -avz --delete --progress save/resource/ ./resource/
