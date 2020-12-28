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
# 全局变量
#
declare -x version="1.0.0"

declare -x system=
declare -i shellwidth=
declare -i shellheight=

double_hor_line="═"
double_vert_line="║"
double_left_corner_up="╔"
double_right_corner_up="╗"
double_left_corner_down="╚"
double_right_corner_down="╝"
double_title_left="╟"
double_title_right="╢"

#
# 初始化脚本,进行一些常规的设置
#
start_init() {
	_get_system_type
	_get_terminal_width_height
}

#
# 获取系统类型
#
_get_system_type() {
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
_get_terminal_width_height() {
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
#
# 下标记从1开始
_true_text() {
	printf "\x1b[38;2;$4;$5;$6m\x1b[48;2;$7;$8;$9m\E[$2;$1H$3\n\x1b[0m"
}

#
# 绘制外框函数
#
# $1 x
# $2 y
# $3 width
# $4 height
# $5 fg color array rgb
# $6 bg color array rgb 
draw_frame() {
	local fg_array=$5
	local bg_array=$6

	local fg=(`echo ${fg_array[*]}`)
	local bg=(`echo ${bg_array[*]}`)

	let l_h_pos=$4-2
	for ((i=$1;i<=$3;i++)) do
		_true_text ${i} $2 ${double_hor_line} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
		_true_text ${i} ${l_h_pos} ${double_hor_line} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
	done

	let l_w_pos=$3
	for ((i=$2;i<=l_h_pos;i++)) do
		_true_text $1 ${i} ${double_vert_line} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
		_true_text ${l_w_pos} ${i} ${double_vert_line} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
	done

	_true_text $1 $2 ${double_left_corner_up} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
	_true_text $l_w_pos $2 ${double_right_corner_up} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}

	_true_text $1 $l_h_pos ${double_left_corner_down} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
	_true_text $l_w_pos $l_h_pos ${double_right_corner_down} ${fg[0]} ${fg[1]} ${fg[2]} ${bg[0]} ${bg[1]} ${bg[2]}
}

# 设置光标位置的函数
# $1 x
# $2 y
#
set_position() {
	echo -ne "\E[$1;$2H"
}

clean_screen
start_init

fg_color_array=(255 0 0)
bg_color_array=(0 0 0)

draw_frame 10 2 100 10 "${fg_color_array[*]}" "${bg_color_array[*]}"
