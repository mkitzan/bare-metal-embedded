#ifndef _ALPHABET_H_
#define _ALPHABET_H_

typedef struct morse morse_t;
struct __attribute__((__packed__)) morse {
    const unsigned char signal;
    const unsigned char length;
};

#define A { .signal = 0x2, .length = 2 }
#define B { .signal = 0x1, .length = 4 }
#define C { .signal = 0x5, .length = 4 }
#define D { .signal = 0x1, .length = 3 }
#define E { .signal = 0x0, .length = 1 }
#define F { .signal = 0x4, .length = 4 }
#define G { .signal = 0x3, .length = 3 }
#define H { .signal = 0x0, .length = 4 }
#define I { .signal = 0x0, .length = 2 }
#define J { .signal = 0x7, .length = 4 }
#define K { .signal = 0x5, .length = 3 }
#define L { .signal = 0x2, .length = 4 }
#define M { .signal = 0x3, .length = 2 }
#define N { .signal = 0x1, .length = 2 }
#define O { .signal = 0x7, .length = 3 }
#define P { .signal = 0x6, .length = 4 }
#define Q { .signal = 0xb, .length = 4 }
#define R { .signal = 0x2, .length = 3 }
#define S { .signal = 0x0, .length = 3 }
#define T { .signal = 0x1, .length = 1 }
#define U { .signal = 0x4, .length = 3 }
#define V { .signal = 0x8, .length = 4 }
#define W { .signal = 0x6, .length = 3 }
#define X { .signal = 0x9, .length = 4 }
#define Y { .signal = 0xd, .length = 4 }
#define Z { .signal = 0x3, .length = 4 }

#define SPACE { .signal = 0x0, .length = 0 }

#endif
