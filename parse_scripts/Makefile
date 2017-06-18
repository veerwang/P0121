all:	main.o utils.o	
	g++ -o play main.o utils.o

main.o: main.cpp
	g++ -c main.cpp

utils.o: utils.c
	gcc -c utils.c

clean:
	rm -f play *.o
