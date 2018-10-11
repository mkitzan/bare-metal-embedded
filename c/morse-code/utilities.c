# include "utilities.h"

inline void enable_led() {
    // enable clock for I/O port B:
    RCC_AHBENR  |= 0x00040000;
    // configure port B pin 03 MODE register for general purpose output:
    GPIOB_MODER |= 0x00000040;
    // disable port B pin 03 pull-up, pull-down
    GPIOB_PUPDR &= 0xFFFFFF3F;
}


inline void enable_timer2() {
    // configure PLL clock register for HSI / 2 and scalar 6 => 24mhz PLL
    RCC_CFGR |= 0x00100000;
    // enable PLL clock, wait until ready
    RCC_CR   |= 0x01000000;
    while((RCC_CR & 0x02000000) != 0x02000000);
    // switch clock to PLL, wait until ready
    RCC_CFGR |=0x00000002;
    while((RCC_CFGR & 0x00000008) != 0x00000008);
    
    // set NVIC vector 15 (TIM2) to lowest priority 3
    NVIC_IPR3 |= 0xC0000000;
    // enable NVIC vector 15 (TIM2)
    NVIC_ISER |= 0x00008000;
    
    // enable clock for TIM2
    RCC_APB1ENR |= 0x00000001;
    // disable TIM2
    TIM2_CR1    &= 0xFFFFFFFE;
    // set TIM2 pre-scalar register to 1/1000 of the clock speed
    TIM2_PSC    = 24000000 / 1000; 
    // enable hardware interrupt
    TIM2_DIER   |= 0x00000001;
}


inline void stop_timer2() {
    // disable TIM2
    TIM2_CR1 &= 0xFFFFFFFE;
    // reset TIM2 interrupt status bit
    TIM2_SR &= 0xFFFFFFFE;
}


inline void start_timer2(unsigned int rate) {
    // disable TIM2
    TIM2_CR1    &= 0xFFFFFFFE;
    // reset clock for TIM2
    RCC_APB1RST &= 0xFFFFFFFE;
    // set TIM2 auto-reload register
    TIM2_ARR    = rate;
    // reset event
    TIM2_EGR    |= 0x00000001;
    // enable TIM2
    TIM2_CR1    |= 0x00000001;
}
