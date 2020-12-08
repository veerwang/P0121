#!/usr/bin/expect
#===============================================================================
#
#          FILE: do-transfer.sh
# 
#         USAGE: ./do-transfer.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月08日 17:10
#      REVISION:  ---
#===============================================================================
set timeout 30
spawn ./transfer.sh
expect "password"
send "v200431004\r"
interact
