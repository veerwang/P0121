#!/usr/bin/expect
#===============================================================================
#
#          FILE: uploadgithub.sh
# 
#         USAGE: ./uploadgithub.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月08日 17:17
#      REVISION:  ---
#===============================================================================

set timeout 30 
spawn git push
expect "Username for *" 
send "kevin.wang2004@hotmail.com\r"
expect "Password for *" 
send "v200431060\r"
interact
