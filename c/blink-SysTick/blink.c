#include "registers.h"

void interrupt() {
    // toggle port B pin 03 (toggle LED3)
    GPIOB_ODR ^= 0x00000008;
}

void main() {
    /*
     * Enable GPIO port B, configure pin 3
     */
    // enable clock for I/O port B:
    RCC_AHBENR  |= 0x00040000;
    // configure port B pin 03 MODE register for general purpose output:
    GPIOB_MODER |= 0x00000040;
    // disable port B pin 03 pull-up, pull-down
    GPIOB_PUPDR &= 0xFFFFFF3F;
    
    /*
     * Configure SysTick to interrupt every half second
     */
    // set counter to 4,000,000 (half second interrupts)
    STK_RVR = 0x003D0900;
    // enable SysTick on processor clock, counter, and interrupt 
    STK_CSR |= 0x00000007;

    // interrupt will control LED blink
    for(;;);
}
