#!/bin/bash - 
#===============================================================================
#
#          FILE: get.sh
# 
#         USAGE: ./get.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月11日 10:15
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

localdir=`pwd`
# 默认倒计时10秒
MAXTIMES=900

disp_msg() {
	echo -en "下载目录："$1
}

title() {
clear
echo " 选择需要的服务器: "
echo " [1] 70服务器"
echo " [2] 80服务器"
echo " [3] 55服务器"
echo " [4] 28服务器"
echo " [0] 退出"
echo
disp_msg $localdir 
echo
echo
}

transfer_file() {
expect << EOF
	set timeout 30
	spawn scp wwei@$1:/home/wwei/rsyncdir/$2 $3
	expect "password*"
	send "v200431004\r"
	expect eof
EOF
}

title

times=$MAXTIMES
while [ $times -ne 0 ]; do
	times=$(($times-1))
	# 覆盖当前行
	echo -en "\r您的选择是[0]: 倒计时 $times 秒: "
	read -t 1 a

	if [ -n $a ]; then
		# 默认数值
		choice=${a}

		# 进行功能选择
		case $choice in
			0)	
				callback="exit"
				times=0
				;;

			1)	
				transfer_file $server $1 $localdir 
				times=$MAXTIMES
				title
				;;

			2)	
				server=172.27.16.80
				transfer_file $server $1 $localdir 
				times=$MAXTIMES
				title
				;;

			3)	
				server=172.27.16.55
				transfer_file $server $1 $localdir 
				times=$MAXTIMES
				title
				;;

			4)	
				server=172.27.16.28
				transfer_file $server $1 $localdir 
				times=$MAXTIMES
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
