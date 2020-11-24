#!/usr/bin/expect

set timeout 30
spawn ssh -l wwei 172.27.16.70
expect "password*"
send "v200431004\r"
interact
