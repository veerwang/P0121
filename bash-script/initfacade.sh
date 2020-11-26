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
LIGHTBLUE='\E[1;36m'     # 青 
WHITE='\E[1;37m'     # 白 
SHAN='\E[33;5m'     #黄色闪烁警示
RES='\E[0m'         # 清除颜色

title() {
clear
echo -e "${BLUE} ==== 多功能程序界面 ==== ${RES}"
echo
echo -e "${BLUE} ¤╭⌒╮ ╭⌒╮ ${RES}"
echo -e "${BLUE}╱◥████████◣ ╭╭⌒╮╮${RES}"
echo -e "${BLUE}︱田︱田 田|╰------${RES}"
echo -e "${BLUE}╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬${RES}"
echo
echo -e "${BLUE}                      V1.0.0${RES}"
echo
echo "登陆时间："$starttime
#cal
echo
echo " 选择需要的功能: "
echo " [1] 登陆70服务器"
echo " [2] 登陆80服务器"
echo " [3] 登陆28服务器"
echo " [t] 创建tmux服务器"
echo " [0] 退出"
echo
}

#
# 该函数使用的前提是tmux进行安装
#
start_tmux_session() {
	read -p "输入session名称：" sessionname
	# 判断tmux是否存在
	tmux has-session -t $sessionname 2>/dev/null
	if [ $? -eq 0 ]; then
		# 存在session
		tmux -2 attach -t $sessionname
	else
		# 不存在session
		tmux -2 new-session -s $sessionname
	fi
}

callback="again"
main_loop() {
# 显示抬头信息
title

# 默认倒计时10秒
MAXTIMES=10
times=$MAXTIMES
while [ $times -ne 0 ]; do
	times=$(($times-1))
	# 覆盖当前行
	echo -en "\r您的选择是[0]: 倒计时 $times 秒: "
	read -t 1 a

	if [ -n $a ]; then
		# 默认数值
		#choice=${a:-"0"}
		choice=${a}

		# 进行功能选择
		case $choice in
			0)	
				callback="exit"
				times=0
				;;
			1)	
				login-70.sh
				times=MAXTIMES
				title
				;;
			2)	
				login-80.sh
				times=MAXTIMES
				title
				;;
			3)	
				login-28.sh
				times=MAXTIMES
				title
				;;
			t)
				start_tmux_session
				times=MAXTIMES
				title
				;;
			*)
				if [ $times -eq 0 ]; then
					callback="exit"
				fi
				;;
		esac
	fi
done
}

starttime=$(date +%Y-%m-%d\ %H:%M:%S)
while [ $callback == "again" ]; do
	main_loop
done
endtime=$(date +%Y-%m-%d\ %H:%M:%S)
echo
echo "退出时间："$endtime
