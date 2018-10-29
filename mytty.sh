#!/bin/bash - 
#===============================================================================
#
#          FILE: mytty.sh
# 
#         USAGE: ./mytty.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年10月29日 18:24
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo " Welcom to the connecting system "
echo " " 
echo " [1] connect 172.27.16.70"
echo " [2] connect 172.27.16.80"
echo " [3] connect 172.27.16.23"
echo " [4] connect 172.27.20.122"
echo " [5] connect 172.27.16.98"
echo " " 

read -t 3 -p "Input the host name: [1-5] default 1: " hostindex

if [ -z ${hostindex} ]; then
	echo " " 
	hostindex="1"
fi

if   [ $hostindex == "1" ]; then
	ssh wwei@172.27.16.70
elif [ $hostindex == "2" ]; then
	ssh wwei@172.27.16.80
elif [ $hostindex == "3" ]; then
	ssh wwei@172.27.16.23
elif [ $hostindex == "4" ]; then
	ssh lihanbo@172.27.20.122
elif [ $hostindex == "5" ]; then
	mosh wwei@172.27.16.98
fi
