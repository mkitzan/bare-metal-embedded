# makefile for blink.c
# 10-14-2018

CC=arm-none-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: blink.o

blink.o: blink.c registers.h
	$(CC) $(CFLAGS) blink.c

clean:
	rm *.o
