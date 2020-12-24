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

init_script_fun
get_terminal_width
echo $shellwidth
echo $shellheight
