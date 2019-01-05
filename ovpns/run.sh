#!/bin/bash - 
#===============================================================================
#
#          FILE: run.sh
# 
#         USAGE: ./run.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019年01月05日 20:59
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sudo openvpn --config ./archlinux.ovpn
