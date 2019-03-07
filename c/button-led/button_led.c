#include "registers.h"

void interrupt() {
    // toggle port A pin 01
    GPIOA_ODR ^= 0x00000002;
    // clear EXTI0 event
    EXTI_PR |= 0x00000001;
}

void main() {
    // enable system config clock
    RCC_APB2ENR |= 0x00000001;
    // enable clock for I/O port A
    RCC_AHBENR  |= 0x00020000;
    
    // configures EXTI0 to source port A pin 00
    SYSCFG_EXTICR1 &= 0xFFFFFFF8;
    // enable interrupt trigger on rising-edge
    EXTI_RTSR |= 0x00000001;
    // disable interrupt trigger on falling-edge
    EXTI_FTSR &= 0xFFFFFFFE;
    // enable interrupt on pin 00
    EXTI_IMR  |= 0x00000001;
    
    // set NVIC vector 5 (EXTI0_1) to lowest priority
    NVIC_IPR1 |= 0x0000C000;
    // enable NVIC vector 5 (EXTI0_1)
    NVIC_ISER |= 0x00000020;
    
    // configure port A pins 00 and 01 MODE register
    GPIOA_MODER |= 0x00000004;
    // configure port A pin 00 to a pull-down resistor
    GPIOA_PUPDR |= 0x00000002;
    
    for(;;);
}
