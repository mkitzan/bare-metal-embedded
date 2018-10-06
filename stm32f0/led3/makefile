# makefile for blink.adb
# 10-05-2018

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: led3.o

led3.o: LED3.ads LED3.adb
	$(CC) $(CFLAGS) LED3.adb

clean:
	rm *.o *.ali
