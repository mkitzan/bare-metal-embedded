#include "k8_simulator.h"
#include "k8_program.h"
#include "registers.h"

void systick_interrupt() {
    // if in RUN mode, enable next step 
    if(!(STATUS & 0x0C)) {
        STATUS |= 0x30;
    }
    STATUS |= 0xC0;
}

void exti01_interrupt() {
    if(EXTI_PR & 0x00000001) {
        // reset counter
        STK_RVR = 0x000F4240;
        PC = 0;
        STATUS = 0x0C;
        // clear EXTI0 event
        EXTI_PR |= 0x00000001;
    } else {
        // cycle register
        if(!(STATUS & 0x03)) {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFF00000) | (PC << 4);
        } else if(STATUS & 0x01) {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFF00000) | (R0 << 4);
        } else if(STATUS & 0x02) {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFF00000) | (R1 << 4);
        } else {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFF00000) | (R2 << 4);
        }
        STATUS = (STATUS & 0xFC) | ((STATUS + 1) & 0x03);
        // clear EXTI1 event
        EXTI_PR |= 0x00000002;
    }
}

void exti23_interrupt() {
    if(EXTI_PR & 0x00000004) {
        // set systick counter to 1/8th second
        STK_RVR = 0x000F4240;
        // enable SysTick on processor clock, counter, and interrupt 
        STK_CSR &= 0xFFFFFFFE;
        // set proc to STEP
        STATUS ^= 0x0C;
        // clear EXTI2 event
        EXTI_PR |= 0x00000004;
    } else {
        // enable next step
        STATUS |= 0x30;
        // clear EXTI3 event
        EXTI_PR |= 0x00000008;
    }
}

void setup(unsigned char reg, unsigned char *store) {
    if(reg = 0x00) {
        store = &R0;
    } else if(reg = 0x04) {
        store = &R1;
    } else if(reg = 0x08) {
        store = &R2;
    } else {
        store = &PC;
    }
}

void main() {
    // set registers
    PC = 0;
    STATUS = 0x0C;
    
    // enable system config clock
    RCC_APB2ENR |= 0x00000001;
    // enable clock for I/O port A
    RCC_AHBENR  |= 0x00020000;
    // port A pins 00-03 for analog input and pins 04-11 for output
    GPIOA_MODER |= 0x00555F;
    // configure port A pins 00-03 to a pull-up resistor
    GPIOA_PUPDR |= 0x00000055;
    
    // configures EXTI 0 1 2 3 to source port A pin 00-03
    SYSCFG_EXTICR1 &= 0xFFFF8888;
    // enable interrupt triggers on rising-edge
    EXTI_RTSR |= 0x0000000F;
    // disable interrupt triggers on falling-edge
    EXTI_FTSR &= 0xFFFFFFF0;
    // set systick counter to 1/8th second
    STK_RVR = 0x000F4240;
    // set NVIC vectors 5 and 6 to lowest priority
    NVIC_IPR1 = 0x00C0C000;
    
    // enable interrupt on pins 00-03
    EXTI_IMR  |= 0x0000000F;
    // enable NVIC interrupts on lines 5 and 6
    NVIC_ISER |= 0x00000060;
    // enable SysTick on processor clock, counter, and interrupt 
    STK_CSR |= 0x00000007;
    
    for(;;) {
        if((STATUS & 0xF0) == 0xF0) {
            setup((TEXT[PC] & 0x0C), reg1);
            
            if(TEXT[PC] & 0xC0) {
                *reg2 = (TEXT[PC] & 0x03) + 1;
            } else {
                setup((TEXT[PC] & 0x03) << 2, reg2);
            }
            
            switch(TEXT[PC] & 0xF0) {
                case 0x00:
                    DATA[*reg1] = *reg2;
                    break;
                case 0x10:
                    *reg1 = DATA[*reg2];
                    break;
                case 0x20:
                    *reg1 += *reg2;
                    break;
                case 0x30:
                    *reg1 -= *reg2;
                    break;
                case 0x40:
                    *reg1 &= *reg2;
                    break;
                case 0x50:
                    *reg1 |= *reg2;
                    break;
                case 0x60:
                    *reg1 != *reg1;
                    if((TEXT[PC] & 0x03) == 0x03) {
                        *reg2 != *reg2;
                    }
                    break;
                case 0x70:
                    *reg1 = 0;
                    if((TEXT[PC] & 0x03) == 0x03) {
                        *reg2 = 0;
                    }
                    break;
                case 0x80:
                    if(*reg1 == *reg2) {
                        PC += 1;
                    }
                    break;
                case 0x90:
                    if(*reg1 != *reg2) {
                        PC += 1;
                    }
                    break;
                case 0xA0:
                    if(*reg1 < *reg2) {
                        PC += 1;
                    }
                    break;
                case 0xB0:
                    if(*reg1 > *reg2) {
                        PC += 1;
                    }
                    break;
                case 0xC0:
                    *reg1 += *reg2;
                    break;
                case 0xD0:
                    *reg1 -= *reg2;
                    break;
                case 0xE0:
                    *reg1 <<= *reg1;
                    break;
                case 0xF0:
                    *reg1 >>= *reg2;
                    break;
            }
            
            PC += 1;
            
            STATUS ^= 0xF0;
        }
    }
}
