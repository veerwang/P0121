#!/bin/bash - 
#===============================================================================
#
#          FILE: dotransfer.sh
# 
#         USAGE: ./dotransfer.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年12月29日 16:34
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

default_ip=172.27.16.28

read -t 10 -p "请输入远方IP地址 [$default_ip]: " IP 
IP=${IP:-"$default_ip"}

if [ $# -ne 2 ]; then
	echo " Usage:    $0 type director"
	echo " type:     tr or re. which directory need to be transfered"
	echo " director: the director need to be transfered"
	exit
fi

if [ $1 = "tr" ]; then
	echo "start transfer data ..."
	rsync --archive --verbose --delete $2 wwei@$IP:/home/wwei/
elif [ $1 = "re" ]; then
	echo "start restore data ..."
	rsync --archive --verbose --delete wwei@$IP:/home/wwei/$2 ./ 
else
	echo " type:     tr or re"
fi
