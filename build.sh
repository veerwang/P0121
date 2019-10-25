#!/bin/bash - 
#===============================================================================
#
#          FILE: build.sh
# 
#         USAGE: ./build.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2019年10月25日 16:57
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

list_dir() {
	for dir in $1/*
	do
		if [ -d $dir ]; then
			dirname=`basename $dir`
			if [ $dirname != "library_install_dir" ]; then
				echo $dir
				cd $dirname 
				./build.sh `pwd`'/'"library_install_dir"
			fi
		fi
	done
}

list_dir `pwd`
