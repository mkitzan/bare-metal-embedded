# makefile for morse_code.c
# 10-11-2018

CC=arm-none-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: morse_code.o utilities.o

morse_code.o: morse_code.c morse_code.h utilities.o registers.h
	$(CC) $(CFLAGS) morse_code.c

utilities.o: utilities.c utilities.h registers.h
	$(CC) $(CFLAGS) utilities.c    
    
clean:
	rm *.o
