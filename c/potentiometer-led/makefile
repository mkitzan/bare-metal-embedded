# makefile for potentiometer_led.c
# 03-05-2019

CC=arm-none-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: potentiometer_led.o

potentiometer_led.o: potentiometer_led.c registers.h
	$(CC) $(CFLAGS) potentiometer_led.c

clean:
	rm *.o
