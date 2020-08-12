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

# 顶层工作路径
topdir=`pwd`
logdirname='log'
# 日志输出文件
logfile=$topdir/$logdirname/`date '+%Y%m%d-%H%M%S'`'.log'

ANALYZEFILE=original-exec
WORKSPACE=workspace
PREFIX=upx-
create_directory $logdirname
write_log "Starting Analyze $WORKSPACE/$ANALYZEFILE program"
core_command "./tools/upx.out -o $WORKSPACE/$PREFIX$ANALYZEFILE $WORKSPACE/$ANALYZEFILE"
write_log "upx $WORKSPACE/$ANALYZEFILE to $WORKSPACE/$PREFIX$ANALYZEFILE"
readelf -h $WORKSPACE/$PREFIX$ANALYZEFILE > $WORKSPACE/elfhead
write_log "get elfhead into $WORKSPACE/elfhead"
readelf -l $WORKSPACE/$PREFIX$ANALYZEFILE > $WORKSPACE/prohead
write_log "get program head into $WORKSPACE/prohead"
readelf -S $WORKSPACE/$PREFIX$ANALYZEFILE > $WORKSPACE/sechead
write_log "get program head into $WORKSPACE/sechead"
