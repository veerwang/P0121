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

init_log() {
	if [ -f $1 ]
	then
		mv $1 $1'-old'
	fi
}

check_result() {
	if [ $? -ne 0 ]
	then
		exit
	fi
}

#
# 参数1: 运行的命令
# 参数2：出错保存的文件路径
#
command_run() {
	$1 2>&1 | tee -a $2 
	check_result
}

topdir=`pwd`
logfile=$topdir/`date '+%Y%m%d-%H%M%S'`'.log'

init_log $logfile

# 写入日志
#echo "log test scripts start" >> $logfile

# 调用函数
func_name '123'

judge_directory 'kkk'
result=$?
#echo $result >> $logfile

newdir=$topdir"/123"
command_run 'cd $newdir' $logfile
command_run 'mkdir 222' $logfile

# do anything

#echo "log test scripts end" >> $logfile
