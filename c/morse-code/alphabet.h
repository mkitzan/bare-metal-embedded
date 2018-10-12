#ifndef _ALPHABET_H_
#define _ALPHABET_H_

typedef struct morse morse_t;
struct __attribute__((__packed__)) morse {
    const unsigned char signal;
    const unsigned char length;
};

#define A { .signal = 0b0010, .length = 2 }
#define B { .signal = 0b0001, .length = 4 }
#define C { .signal = 0b0101, .length = 4 }
#define D { .signal = 0b0001, .length = 3 }
#define E { .signal = 0b0000, .length = 1 }
#define F { .signal = 0b0100, .length = 4 }
#define G { .signal = 0b0011, .length = 3 }
#define H { .signal = 0b0000, .length = 4 }
#define I { .signal = 0b0000, .length = 2 }
#define J { .signal = 0b0111, .length = 4 }
#define K { .signal = 0b0101, .length = 3 }
#define L { .signal = 0b0010, .length = 4 }
#define M { .signal = 0b0011, .length = 2 }
#define N { .signal = 0b0001, .length = 2 }
#define O { .signal = 0b0111, .length = 3 }
#define P { .signal = 0b0110, .length = 4 }
#define Q { .signal = 0b1011, .length = 4 }
#define R { .signal = 0b0010, .length = 3 }
#define S { .signal = 0b0000, .length = 3 }
#define T { .signal = 0b0001, .length = 1 }
#define U { .signal = 0b0100, .length = 3 }
#define V { .signal = 0b1000, .length = 4 }
#define W { .signal = 0b0110, .length = 3 }
#define X { .signal = 0b1001, .length = 4 }
#define Y { .signal = 0x1101, .length = 4 }
#define Z { .signal = 0b0011, .length = 4 }

#define SPACE { .signal = 0b0000, .length = 0 }

#endif
