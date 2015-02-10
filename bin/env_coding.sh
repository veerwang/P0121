#! /bin/bash

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
	$cmd neww -n vim -c "/home/kevin/armworkspace/Venture_Game" -t $session "zsh"
	$cmd splitw -c "/home/kevin/armworkspace/Venture_Game" -h -p 20 "zsh"
	$cmd splitw -c "/home/kevin/armworkspace/Venture_Game/bin" -v -p 50 "zsh"
	$cmd neww -n "work" "zsh"	    # 文件操作
	$cmd selectw -t $session:2
	$cmd selectp -t 1
fi

$cmd -2 att -t $session

exit 0
