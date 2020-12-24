#!/bin/bash - 
#===============================================================================
#
#          FILE: utils.sh
# 
#         USAGE: ./utils.sh 
# 
#   DESCRIPTION: 一些成熟的bash脚本集合 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年12月14日 09:44
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#
# 初始化脚本,进行一些常规的设置
#
init_script_fun() {
	declare -x LC_MESSAGES="C" LC_NUMERIC="C" LC_ALL=""
	declare version="1.0.0"

	case "$(uname -s)" in
		Linux*)  system=Linux;;
		*BSD)	 system=BSD;;
		Darwin*) system=MacOS;;
		CYGWIN*) system=Cygwin;;
		MINGW*)  system=MinGw;;
		*)       system="Other"
	esac

	if [[ ! $system =~ Linux|MacOS|BSD ]]; then
		echo "This version of bashtop does not support $system platform."
		exit 1
	else
		echo "support system:" $system
	fi
}

#
# 获取终端的宽度 
#
shellwidth=0
shellheight=0
get_terminal_width() {
	shellwidth=`stty size|awk '{print $2}'`
	shellheight=`stty size|awk '{print $1}'`
}

#
# 清屏 
#
clean_screen() {
	echo -e "\E[2J"
}

#
# 真彩字符串显示 
# $1: x
# $2: y
# $3: string
#
# $4 fg-red
# $5 fg-green
# $6 fg-blue
#
# $7 bg-red
# $8 bg-green
# $9 bg-blue
true_text() {
	printf "\x1b[38;2;$4;$5;$6m\x1b[48;2;$7;$8;$9m\E[$2;$1H$3\n\x1b[0m"
}

init_script_fun
get_terminal_width
echo $shellwidth
echo $shellheight
true_text 7 4 "真彩字符串显示" 255 0 0 255 255 0
