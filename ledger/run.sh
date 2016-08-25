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
#       CREATED: 2016年08月25日 11:30
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
ledger -f kevin-ledger.ldg -S T bal 资产 负债 > 权益
ledger -M -f kevin-ledger.ldg reg 支出 > 月度支出
ledger -f kevin-ledger.ldg bal 资产:股票 > 股票
