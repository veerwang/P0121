#!/bin/bash - 
#===============================================================================
#
#          FILE: git-meld.sh
# 
#         USAGE: ./git-meld.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2014年11月11日 11:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

meld $2 $5
