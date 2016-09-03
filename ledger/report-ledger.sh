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

#ledger  -f kevin-ledger.ldg bal 股票 --price-db price.db -V
set -o nounset                              # Treat unset variables as an error
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg -S T --price-db ~/DataLibrary/kevin.wang-account/ledger/price.db -V bal 资产 负债 > 权益
ledger -b "this month" -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg reg 支出 > 本月支出明细
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg bal --price-db ~/DataLibrary/kevin.wang-account/ledger/price.db -V 资产:股票 > 股票
ledger -f ~/DataLibrary/kevin.wang-account/ledger/kevin-ledger.ldg -b "this month" --price-db ~/DataLibrary/kevin.wang-account/ledger/price.db -V reg 收入 支出 > 本月收支表 
