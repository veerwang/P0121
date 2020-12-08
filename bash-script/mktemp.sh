#!/bin/bash - 
#===============================================================================
#
#          FILE: mktemp.sh
# 
#         USAGE: ./mktemp.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月08日 16:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

FILEPREFIX="mytempfile"

TEMP_FILE=`mktemp $FILEPREFIX.XXXXXX`

echo $TEMP_FILE

