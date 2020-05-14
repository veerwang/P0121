#!/bin/bash - 
#===============================================================================
#
#          FILE: run.sh
# 
#         USAGE: ./run.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年05月14日 15:28
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
sudo docker run -v /home/kevin/workspace:/mnt -it workspace/centos:0.0.1 bash

