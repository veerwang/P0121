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
	$cmd new -d -n kernel -s $session "zsh"
	$cmd send-keys -t $session:1 "cd /home/kevin/armworkcopy/mkernel/src" C-m

	$cmd neww -n vim -t $session:2 "zsh"
	$cmd splitw -v -p 70 "zsh"
	$cmd splitw -v -p 70 "zsh"

	$cmd send-keys -t $session:2 "cd /home/kevin/.vagrant.d/boxes/lucid32/virtualbox/" C-m

	$cmd neww -n vim -t $session "zsh"
	$cmd send-keys -t $session:3 "cd /home/kevin/.vagrant.d/boxes/lucid32/virtualbox/" C-m

	$cmd neww -n debug -t $session "zsh"

	$cmd selectw -t $session:1
fi

$cmd -2 att -t $session

exit 0
