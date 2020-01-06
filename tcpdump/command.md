1.tcpdump -i eth0 					最简单的tcpdump命令，查看接口的数据。
2.tcpdump host 192.168.1.30				查看从192.168.1.30这个ip地址出去或进入的数据包 
3.tcpdump dst/src 192.168.1.28				查看目的地址是192.168.1.28的数据包
4.tcpdump net 172.27.16					查看地址当中存在172.27.16字段的地址	
5.tcpdump -X host 172.27.16.28				将发往172.27.16.28的数据包以16进制与ascii码的形式进行显示
6.tcpdump port 7768					侦测端口为7768的数据包
7.tcpdump portrange 7768-7771				侦听范围内的端口号
8.tcpdump -c 1 -X host 172.27.16.28			将发往172.27.16.28的数据包以16进制与ascii码的形式进行显示,-c 1的意思是仅仅接收一次数据包
9.tcpdump icmp						侦听imcp协议的报文
10.tcpdump -X greater/less 350 host 172.27.16.28	侦听数据包的长度大于350的传入或传出172.27.16.28的报文,并且以16进制的形式显示 
11.tcpdump -w/-r example.pcap				将获取到的数据保存进入example.pcap文件或从example.pcap文件读取出来
12.tcpdump -D						显示全部的端口
13.tcpdump -q 						显示较少的其他报文的信息，可以专注于IP或IP6的报文内容
14.tcpdump -Q in / -Q out				显示输入或输出的报文
15.tcpdump -tt						在每条报文前头显示时间戳
16.tcpdump src 172.27.16.221 and dst 172.27.16.28	and字符进行报文目的地与源地址的同时限制
							or字符进行或的连接
							not字符为排除
17.字符串组合
tcpdump 'src 172.27.17.221 and (dst port 3389 or 22)'	添加单引号保证（）不会被解析
