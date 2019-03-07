# makefile for button_led.c
# 03-05-2019

CC=arm-none-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: button_led.o

button_led.o: button_led.c
	$(CC) $(CFLAGS) button_led.c

clean:
	rm *.o
