#! /bin/bash
#
#                     The scrip is written for automatic patch vim source tree
#                                                                   kevin  2011.10.01

echo 
echo start patch processing ....
for ((a=9;a>=0;a--))
do
	for ((b=9;b>=0;b--))
	do
		for ((c=9;c>=0;c--))
		do
			if [ -e "../patch/7.3.$a$b$c" ]; then
				echo "7.3.$a$b$c re-patching ...."
				patch -RE -p0 < "../patch/7.3.$a$b$c"
			else
				if [ $a$b$c -eq 000 ]; then
					echo the patch index is from 001 
				else
					continue	
				fi
			fi
		done
	done
done
echo 
echo patch processing finished 
