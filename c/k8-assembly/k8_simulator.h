#ifndef _K8_SIMULATOR_H_
#define _K8_SIMULATOR_H_

// registers
unsigned char PC, R0, R1, R2;
// [clock]00 [step]00 [mode]00 [reg]00
unsigned char STATUS;
// control variables
unsigned char *reg1, *reg2;

#endif
