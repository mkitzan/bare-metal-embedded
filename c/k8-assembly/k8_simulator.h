#ifndef _K8_SIMULATOR_H_
#define _K8_SIMULATOR_H_

#define SIM_STEP 0x001E8480

// registers
unsigned char PC, R0, R1, R2;
// [clock]00 [step]00 [mode]00 [reg]00
unsigned char STATUS;
// temp variables
unsigned char RA, RB, OP;

#endif
