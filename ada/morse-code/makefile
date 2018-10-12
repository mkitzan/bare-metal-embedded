# makefile for Morse_Code.adb
# 10-10-2018

CC=arm-eabi-gcc
CFLAGS=-c -mcpu=cortex-m0 -mthumb

all: morse_code.o alphabet.o registers.o utilities.o

morse_code.o: Morse_Code.ads Morse_Code.adb
	$(CC) $(CFLAGS) Morse_Code.adb
    
utilities.o: Utilities.ads Utilities.adb
	$(CC) $(CFLAGS) Utilities.adb 
    
alphabet.o: Alphabet.ads
	$(CC) $(CFLAGS) Alphabet.ads

registers.o: Registers.ads
	$(CC) $(CFLAGS) Registers.ads     

clean:
	rm *.o *.ali
