CC := g++ -Wall -Werror
FLAGS := -std=c99
FLAG := -std=c++11

.PHONY: all clean install uninstall rebuild

all: bin/client bin/main

bin/client: builds/client.o
	$(CC) builds/client.o -o bin/client

bin/main: builds/main.o builds/LiteSH.o
	$(CC) builds/main.o builds/LiteSH.o -I home/wanderer/OS/CW_OS/libs/libinfo.so -ldl -o bin/main $(FLAG)

builds/client.o: src/client.cpp
	$(CC) -c src/client.cpp -o builds/client.o

builds/main.o: src/main.cpp
	$(CC) -c src/main.cpp -o builds/main.o $(FLAG)

builds/LiteSH.o: src/LiteSH.cpp
	$(CC) -c src/LiteSH.cpp -o builds/LiteSH.o

clean:
	find -name "*.o" -exec rm -rf {} +
	rm -rf ./bin/main ./bin/client

install:
	sudo cp ./bin/proc /usr/bin/main
	sudo cp ./bin/proc /usr/bin/client

uninstall:
	sudo rm -f /usr/bin/main
	sudo rm -f /usr/bin/client

rebuild: clean all
