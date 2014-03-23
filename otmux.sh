#!/bin/bash - 
#===============================================================================
#
#          FILE: otmux.sh
# 
#         USAGE: ./otmux.sh 
# 
#   DESCRIPTION: 
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
cd ~
cmd=$(which tmux) 			    # tmux path 
session=basic

if [ -z $cmd ]; then
	echo "You need to install tmux."
	exit 1
fi

$cmd -2 has -t $session

if [ $? != 0 ]; then
	$cmd new -d -n calcurse -s $session "calcurse"
	$cmd neww -n Ruby -t $session:2 "zsh"
	$cmd neww -n vim2 -t $session "zsh"
	$cmd neww -n debug -t $session "zsh"
	$cmd neww -n sdcv -t $session "sdcv"
	$cmd splitw -v -p 70 "python"
	$cmd splitw -h -p 50 "htop"
	$cmd neww -n mutt -t $session "mutt"
	$cmd neww -n cmus -t $session "cmus"
	$cmd neww -n mc -t $session "mc"
	$cmd selectw -t $session:2

	$cmd send-keys -t $session:2 "cd /home/kevin/armworkcopy/Ruby" C-m
	$cmd send-keys -t $session:2 "vim README" C-m
fi

$cmd -2 att -t $session

exit 0
