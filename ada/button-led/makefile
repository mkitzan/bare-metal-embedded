# makefile for Button_LED.adb
# 03-07-2019

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: Button_LED.o

Button_LED.o: Button_LED.ads Button_LED.adb
	$(CC) $(CFLAGS) Button_LED.adb

clean:
	rm *.o *.ali
    