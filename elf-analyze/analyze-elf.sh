#!/bin/bash - 
#===============================================================================
#
#          FILE: go.sh
# 
#         USAGE: ./go.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年07月23日 10:10
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# 判断目录是否存在,如果不存在就创建
create_directory() {
	echo $1
	if [ -d $1 ]
	then
		return
	fi
	mkdir $1
}

#
# 将日志保存
#
write_log() {
	echo $1 >> $logfile
	printf "$1\n"
}

# 判断模块是否存在
check_result() {
	if [ $? -ne 0 ]
	then
		exit
	fi
}

core_command() {
	$1 2>&1
	check_result
}

#
# 核心分析函数
#
#
analyze_process() {
	readelf -h $1 > $2/elfhead
	write_log "get elfhead into $2/elfhead"
	readelf -l $1 > $2/prohead
	write_log "get program head into $2/prohead"
	readelf -S $1 > $2/sechead
	write_log "get section head into $2/sechead"
	readelf -s $1 > $2/symstab
	write_log "get symbols symtab into $2/symtab"
	readelf -d $1 > $2/dynamictab
	write_log "get symbols symtab into $2/dynamictab"
}

# 顶层工作路径
topdir=`pwd`
logdirname='log'
# 日志输出文件
logfile=$topdir/$logdirname/`date '+%Y%m%d-%H%M%S'`'.log'

if [ $# != 2 ] ; then 
	echo "USAGE: $0 pro action" 
	echo " e.g.: $0 which analyze" 
	echo "action: analyze"
	echo "        clean"
	exit 1; 
fi 

ANALYZEFILE=$1
WORKSPACE=workspace
PREFIX=upx
ANALYZERESULT=$PREFIX-data

if [ $2 == clean ] ; then
	core_command "rm -rf $WORKSPACE/$ANALYZERESULT"
	write_log "rm -rf $WORKSPACE/$ANALYZERESULT"
	core_command "rm -rf $WORKSPACE/$PREFIX$ANALYZEFILE"
	write_log "rm -rf $WORKSPACE/$PREFIX$ANALYZEFILE"
	core_command "rm -rf $WORKSPACE/data"
	write_log "rm -rf $WORKSPACE/data"
fi

if [ $2 == analyze ] ; then
	create_directory $logdirname
	create_directory $WORKSPACE/$ANALYZERESULT
	create_directory $WORKSPACE/data
	write_log "Starting Analyze $WORKSPACE/$ANALYZEFILE program"
	core_command "./tools/upx.out -o $WORKSPACE/$PREFIX$ANALYZEFILE $WORKSPACE/$ANALYZEFILE"
	write_log "upx $WORKSPACE/$ANALYZEFILE to $WORKSPACE/$PREFIX$ANALYZEFILE"

	analyze_process $WORKSPACE/$PREFIX$ANALYZEFILE $WORKSPACE/$ANALYZERESULT
	analyze_process $WORKSPACE/$ANALYZEFILE $WORKSPACE/data
fi

#./tools/upx.out -d workspace/upx-original-exec -o new-exec
