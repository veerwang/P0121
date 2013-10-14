#!/bin/bash - 
#===============================================================================
#
#          FILE: otmux.sh
# 
#         USAGE: ./otmux.sh 
# 
#   DESCRIPTION: I used this script to launtch the tmux as my ways
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2013年10月09日 13:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cmd=$(which tmux) 			    # tmux path 
session=basic

if [ -z $cmd ]; then
	echo "You need to install tmux."
	exit 1
fi

$cmd -2 has -t $session

if [ $? != 0 ]; then
	$cmd new -d -n vim -s $session "vim"
	$cmd neww -n telnet -t $session "bash"
	$cmd neww -n sdcv -t $session "sdcv"
	$cmd splitw -v -p 70 "python"
	$cmd splitw -h -p 50 "top"
	$cmd neww -n mutt -t $session "mutt"
	$cmd selectw -t $session:1
fi

$cmd -2 att -t $session

exit 0
