#ifndef _K8_PROGRAM_H_
#define _K8_PROGRAM_H_

const unsigned char TEXT[31] = {
	113,  16, 196,  21, 123, 217, 177,  30,  49, 123,   8, 201,  18, 192,   8, 123, 
	 18, 216,  30, 123, 216, 201, 145,  30, 201,   8, 200,  22, 123,   9, 220
};

unsigned char DATA[256];

/* Copy into simulator:
	DATA[0] = 31;
	DATA[1] = 5;
	DATA[254] = 18;
	DATA[255] = 3;
*/

#endif
