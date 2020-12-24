#!/bin/bash - 
#===============================================================================
#
#          FILE: screen_disp.sh
# 
#         USAGE: ./screen_disp.sh 
# 
#   DESCRIPTION: 保存屏幕显示功能的函数 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月24日 15:09
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

clean_screen() {
	echo -e "\E[2J"
}

#
# 显示屏幕位置的函数
# $1: x
# $2: y
# $3: string
# $4: color
print() {
	echo -ne "$4\E[$2;$1H$3\E[0m"
}

#
# 真彩字符串显示 
# $1: x
# $2: y
# $3: string
#
# $4 fg-red
# $5 fg-green
# $6 fg-blue
#
# $7 bg-red
# $8 bg-green
# $9 bg-blue
true_text() {
	printf "\x1b[38;2;$4;$5;$6m\x1b[48;2;$7;$8;$9m\E[$2;$1H$3\n\x1b[0m"
}

clean_screen

print 10 2 "测试字符串\n" '\E[1;31m'
print 12 3 "测试字符串\n" '\E[1;31m'
true_text 7 4 "真彩字符串显示" 255 0 0 255 255 0
