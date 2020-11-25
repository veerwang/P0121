#!/bin/bash - 
#===============================================================================
#
#          FILE: initfacade.sh
# 
#         USAGE: ./initfacade.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年11月25日 13:25
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
callback="again"
main_loop() {
clear
echo " ==== 多功能程序界面 ==== "
echo
echo " ¤╭⌒╮ ╭⌒╮"
echo "╱◥████████◣ ╭╭⌒╮╮"
echo "︱田︱田 田|╰------"
echo "╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬"
echo
echo "                      V1.0.0"
echo
echo
echo " 选择需要的功能:"
echo " [1] 登陆70服务器"
echo " [2] 登陆80服务器"
echo " [0] 退出"
echo
read -p "您的选择是[1]: " a 

# 默认数值
choice=${a:-"1"}

if [ $choice == "0" ]; then
	callback="exit"
fi

if [ $choice == "1" ]; then
	login-70.sh
fi

if [ $choice == "2" ]; then
	login-80.sh
fi
}

while [ $callback == "again" ]; do
main_loop
done
echo
echo "辛苦了"