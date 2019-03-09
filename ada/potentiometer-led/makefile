# makefile for Potentiometer_LED.adb
# 03-09-2019

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: Potentiometer_LED.o

Potentiometer_LED.o: Potentiometer_LED.ads Potentiometer_LED.adb
	$(CC) $(CFLAGS) Potentiometer_LED.adb

clean:
	rm *.o *.ali
    