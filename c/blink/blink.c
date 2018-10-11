#include "registers.h"

void interrupt() {
    // toggle port B pin 03 (toggle LED3)
    GPIOB_ODR ^= 0x00000008;
    // reset TIM2 interrupt status bit
    TIM2_SR   &= 0xfffffffe;
}

int main() {
    /*
     * Switch system clock over to pulse-locked loop set to flash RAM
     *      max speed (24mhz)
     */
    // configure PLL clock register for HSI / 2 and scalar 6 => 24mhz PLL
    RCC_CFGR |= 0x00100000;
    // enable PLL clock, wait until ready
    RCC_CR   |= 0x01000000;
    while((RCC_CR & 0x02000000) != 0x02000000);
    // switch clock to PLL, wait until ready
    RCC_CFGR |=0x00000002;
    while((RCC_CFGR & 0x00000008) != 0x00000008);
    
    /*
     * Enable GPIO port B, configure pin 3
     */
    // enable clock for I/O port B:
    RCC_AHBENR  |= 0x00040000;
    // enable clock for TIM2
    RCC_APB1ENR |= 0x00000001;
    // configure port B pin 03 MODE register for general purpose output:
    GPIOB_MODER |= 0x00000040;
    // disable port B pin 03 pull-up, pull-down
    GPIOB_PUPDR &= 0xFFFFFF3F;
    
    /*
     * Configure NVIC interrupt vector 15 (TIM2)
     */
    // set NVIC vector 15 (TIM2) to lowest priority 3
    NVIC_IPR3 |= 0xC0000000;
    // enable NVIC vector 15 (TIM2)
    NVIC_ISER |= 0x00008000;
    
    /*
     * Configure TIM2 interrupt to interrupt 10 times a second, then
     *      enable the interrupt
     */
    // disable TIM2
    TIM2_CR1    &= 0xFFFFFFFE;
    // reset clock for TIM2
    RCC_APB1RST &= 0xFFFFFFFE;
    // set TIM2 pre-scalar register to 1/1000 of the clock speed
    TIM2_PSC    = 24000000 / 1000; 
    // set TIM2 auto-reload register to 1000
    TIM2_ARR    = 100;
    // reset event
    TIM2_EGR    |= 0x00000001;
    // enable hardware interrupt
    TIM2_DIER   |= 0x00000001;
    // enable TIM2
    TIM2_CR1    |= 0x00000001;

    // interrupt will control LED blink
    for(;;);
    
    return 0;
}
