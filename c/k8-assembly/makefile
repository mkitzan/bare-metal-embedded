# makefile for k8_simulator.c
# 03-05-2019

CC=arm-none-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: k8_simulator.o

assembler: k8

k8_simulator.o: k8_simulator.c k8_simulator.h registers.h
	$(CC) $(CFLAGS) k8_simulator.c
    
k8_assembler.o: k8_assembler.c
	gcc -c k8_assembler.c

k8: k8_assembler.o
	gcc k8_assembler.o -o k8

clean:
	rm *.o
