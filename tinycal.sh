#!/bin/bash - 
#===============================================================================
#
#          FILE: tinycal.sh
# 
#         USAGE: ./tinycal.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年08月10日 14:47
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
echo "===result===>"
echo "obase=16;ibase=16;" $1 | bc
