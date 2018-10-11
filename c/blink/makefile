# makefile for blink.c
# 10-11-2018

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: blink.o

blink.o: blink.c registers.h
	$(CC) $(CFLAGS) blink.c

clean:
	rm *.o
