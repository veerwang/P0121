#!/bin/bash - 
#===============================================================================
#
#          FILE: ledger-run.sh
# 
#         USAGE: ./ledger-run.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/20/2016 11:23
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
echo " 个人资产负债表   --------------" > $1 
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg -S T --price-db ~/DataLibrary/kevin.wang-account/ledger/price.db --real -V bal 资产 负债 >> $1
echo "  " >> $1 
echo " 装修费用   --------------" >> $1
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg -S T --price-db ~/DataLibrary/kevin.wang-account/ledger/price.db -V bal 资产 负债 >> $1
echo "  " >> $1 
echo " 近两个月汽油支出 --------------" >> $1 
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal 支出:交通费用:汽车加油 --period last month >> $1 
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal 支出:交通费用:汽车加油 --period this month >> $1 
echo " 近两天总体支出 --------------" >> $1 
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal 支出 -n --period yesterday >> $1 
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal 支出 -n --period today >> $1 
#ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal 支出:房子交易 >> $1 
echo " 停车费用 --------------" >> $1 
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal "tag(car)" >> $1 

