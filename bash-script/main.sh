#!/bin/bash - 
#===============================================================================
#
#          FILE: main.sh
# 
#         USAGE: ./main.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019年04月25日 13:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# 函数，参数是创建的目录
func_name() {
	mkdir $1
}

# judge file exist
judge_directory() {
	if [ -d $1 ]
	then
		return 1
	fi
	return 0
}

topdir=`pwd`
logfile=$topdir/`date '+%Y%m%d-%H%M%S'`'.log'

# 写入日志
echo "log test scripts start" >> $logfile

# 调用函数
func_name '123'

judge_directory 'kkk'
result=$?
echo $result >> $logfile

cd $topdir'/123'
mkdir 222
# 退出
exit 0
# do anything

echo "log test scripts end" >> $logfile
