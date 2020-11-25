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

RED='\E[1;31m'      # 红
GREEN='\E[1;32m'    # 绿
YELOW='\E[1;33m'    # 黄
BLUE='\E[1;34m'     # 蓝
PINK='\E[1;35m'     # 粉红
SHAN='\E[33;5m'     #黄色闪烁警示
RES='\E[0m'         # 清除颜色

callback="again"
main_loop() {
clear
echo -e "${BLUE} ==== 多功能程序界面 ==== ${RES}"
echo
echo " ¤╭⌒╮ ╭⌒╮"
echo "╱◥████████◣ ╭╭⌒╮╮"
echo "︱田︱田 田|╰------"
echo "╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬"
echo
echo "                      V1.0.0"
echo
cal
echo
echo " 选择需要的功能:"
echo " [1] 登陆70服务器"
echo " [2] 登陆80服务器"
echo " [3] 登陆28服务器"
echo " [0] 退出"
echo
# 默认输入30秒
read -t 30 -p "您的选择是[0]: " a 

# 默认数值
choice=${a:-"0"}

# 进行功能选择
case $choice in
	0)	
	callback="exit";;
	1)	
	login-70.sh
	;;
	2)	
	login-80.sh
	;;
	3)	
	login-28.sh
	;;
esac
}
starttime=$(date +%Y-%m-%d\ %H:%M:%S)
while [ $callback == "again" ]; do
main_loop
done
endtime=$(date +%Y-%m-%d\ %H:%M:%S)
#distime=$((endtime - starttime) +%Y-%m-%d\ %H:%M:%S)
echo "登陆时间："$starttime
echo "退出时间："$endtime
echo -e "${BLUE} 每天好心情 ${RES}"
