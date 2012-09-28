#! /bin/bash
#
#                     The scrip is written for automatic patch vim source tree
#                                                                   kevin  2011.10.01

echo 
echo start patch processing ....
for ((a=0;a<=9;a++))
do
	for ((b=0;b<=9;b++))
	do
		for ((c=0;c<=9;c++))
		do
			if [ -e "../patch/7.3.$a$b$c" ]; then
				echo "7.3.$a$b$c patching ...."
				patch -p0 < "../patch/7.3.$a$b$c"
			else
				if [ $a$b$c -eq 000 ]; then
					echo the patch index from 001 
				else
					break	
				fi
			fi
		done
	done
done
echo 
echo patch processing finished 
