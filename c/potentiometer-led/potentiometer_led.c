#include "registers.h"

void adc_interrupt() {
    // read ADC data ADC_DR and adjust sysclock reload value
    STK_RVR = 0x30D40 * ((ADC_DR & 0x0000003F) + 1);
    // reset end of conversion flag
    ADC_ISR |= 0x00000004;
}

void systick_interrupt() {
    // toggle port A pin 01
    GPIOA_ODR ^= 0x00000002;
}

void main() {
    // enable clock for ADC
    RCC_APB2ENR |= 0x000000200;
    // enable clock for I/O port A
    RCC_AHBENR  |= 0x00020000;
    // enable port A pin 00 for analog and pin 01 for output
    GPIOA_MODER |= 0x00000007;

    // enable interrupts on end of conversion
    ADC_IER    |= 0x00000004;
    // configure ADC for continuous conversion and 6 bit resolution
    ADC_CFGR1  |= 0x00002018;
    // configure ADC for PCLCK / 2
    ADC_CFGR2  |= 0x40000000;
    // set sampling time to 13.5 ADC clock cycles
    ADC_SMPR   |= 0x00000002;
    // select GPIO line 0 as input channel
    ADC_CHSELR |= 0x00000001;
    
    // perform ADC calibration
    ADC_CR |= 0x80000000;
    while(ADC_CR & 0x80000000);
    // enable ADC
    ADC_CR |= 0x00000001;
    while(!(ADC_ISR & 0x00000001));

    // set NVIC vector 12 (ADC_COMP) to lowest priority
    NVIC_IPR3 |= 0x000000C0;
    // enable NVIC vector 12 (ADC_COMP)
    NVIC_ISER |= 0x00001000;
    // enable SysTick on processor clock, counter, and interrupt 
    STK_CSR   |= 0x00000007;
    // start ADC
    ADC_CR    |= 0x00000004;

    for(;;);
}