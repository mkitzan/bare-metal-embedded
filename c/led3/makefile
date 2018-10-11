# makefile for led3.c
# 10-10-2018

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: led3.o

led3.o: led3.c
	$(CC) $(CFLAGS) led3.c

clean:
	rm *.o
