# makefile for blink.adb
# 10-05-2018

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: blink.o

blink.o: Blink.ads Blink.adb
	$(CC) $(CFLAGS) Blink.adb

clean:
	rm *.o *.ali
