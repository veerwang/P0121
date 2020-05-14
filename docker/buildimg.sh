#!/bin/bash - 
#===============================================================================
#
#          FILE: buildimg.sh
# 
#         USAGE: ./buildimg.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2020年05月14日 15:26
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sudo docker build -t workspace/centos:0.0.1 .
