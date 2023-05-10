# ssdsim linux support
DOCKER_IMAGE_NAME = ssdsim
DOCKER_TAG = $(shell git describe --tags --always)
docker-build:
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_TAG) .

all:ssd 
	
clean:
	rm -f ssd *.o *~
.PHONY: clean

ssd: ssd.o avlTree.o flash.o initialize.o pagemap.o 
	cc -g -o ssd ssd.o avlTree.o flash.o initialize.o pagemap.o
#	rm -f *.o
ssd.o: flash.h initialize.h pagemap.h ssd.c
	gcc -c -g ssd.c
flash.o: pagemap.h flash.c
	gcc -c -g flash.c
initialize.o: avlTree.h pagemap.h initialize.c
	gcc -c -g initialize.c
pagemap.o: initialize.h pagemap.c
	gcc -c -g pagemap.c
avlTree.o: avlTree.c
	gcc -c -g avlTree.c

