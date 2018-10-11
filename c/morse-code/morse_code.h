#ifndef _MORSE_CODE_H_
#define _MORSE_CODE_H_

#include "alphabet.h"

// rate of message output RATE / 10000 (interrupts per second)
#define RATE 100
// size of message
#define SIZE 13
// message to output in morse code
morse_t MESSAGE[SIZE] = { H,E,L,L,O,SPACE,W,O,R,L,D,SPACE };

// interrupt handler / core loop shared memory (initialized in main)
unsigned char COUNT;
unsigned char BUFFER;

#endif
