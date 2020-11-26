#!/bin/bash - 
#===============================================================================
#
#          FILE: tmuxwork.sh
# 
#         USAGE: ./tmuxwork.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年11月26日 10:50
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

read -p "输入session名称：" sessionname

tmux has-session -t $sessionname 2>/dev/null

if [ $? -eq 0 ]; then
	# 存在session
	tmux -2 attach -t $sessionname
else
	# 不存在session
	tmux -2 new-session -s $sessionname
fi
