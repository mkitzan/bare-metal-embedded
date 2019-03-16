#include "k8_simulator.h"
#include "k8_program.h"
#include "registers.h"

void systick_interrupt() {
    // if in RUN mode, enable next step
    STATUS |= 0xC0;
}

void exti01_interrupt() {
    if(EXTI_PR & 0x00000001) {
        // cycle register
        STATUS = (STATUS & 0xFC) | ((STATUS + 1) & 0x03);
        // clear EXTI1 event
        EXTI_PR |= 0x00000001;
    } else {
        // set systick counter to 1/8th second
        STK_RVR = 0x000F4240;
        // enable next step
        STATUS |= 0x30;
        // clear EXTI3 event
        EXTI_PR |= 0x00000002;
    }
}

void store(unsigned char *loc, unsigned char reg) {
    if(reg = 0x00) {
        R0 = *loc;
    } else if(reg = 0x04) {
        R1 = *loc;
    } else if(reg = 0x08) {
        R2 = *loc;
    } else {
        PC = *loc;
    }
}

void load(unsigned char reg, unsigned char *loc) {
    if(reg = 0x00) {
        *loc = R0;
    } else if(reg = 0x04) {
        *loc = R1;
    } else if(reg = 0x08) {
        *loc = R2;
    } else {
        *loc = PC;
    }
}

void main() {
    // set registers
    RA = RB = OP = 0;
    PC = R0 = R1 = R2 = 0;
    STATUS = 0x00;
    
    // enable system config clock
    RCC_APB2ENR |= 0x00000001;
    // enable clock for I/O port A
    RCC_AHBENR  |= 0x00020000;
    // port A pins 00-03 for input and pins 04-11 for output
    GPIOA_MODER |= 0x00555500;
    // configure port A pins 00-01 to a pull-up resistor
    GPIOA_PUPDR |= 0x00000005;
    
    // configures EXTI to source port A pin 00-01
    SYSCFG_EXTICR1 &= 0xFFFFFF88;
    // enable interrupt triggers on rising-edge
    EXTI_RTSR |= 0x00000003;
    // disable interrupt triggers on falling-edge
    EXTI_FTSR &= 0xFFFFFFFC;
    // set systick counter to 1/8th second
    STK_RVR = 0x000F4240;
    // set NVIC vector 5 lowest priority
    NVIC_IPR1 = 0x0000C000;
    
    // enable interrupt on pins 00-01
    EXTI_IMR  |= 0x00000003;
    // enable NVIC interrupts on line 5
    NVIC_ISER |= 0x00000020;
    // enable SysTick on processor clock, counter, and interrupt 
    STK_CSR |= 0x00000007;
    
    for(;;) {
        if((STATUS & 0xF0) == 0xF0) {
            OP = TEXT[PC];
            load((OP & 0x0C), &RA);
            
            if(OP & 0xC0) {
                RB = (OP & 0x03) + 1;
            } else {
                load((OP & 0x03) << 2, &RB);
            } 
            
            switch(OP & 0xF0) {
                case 0x00:
                    DATA[RA] = RB;
                    break;
                case 0x10:
                    RA = DATA[RB];
                    break;
                case 0x20:
                    RA += RB;
                    break;
                case 0x30:
                    RA -= RB;
                    break;
                case 0x40:
                    RA &= RB;
                    break;
                case 0x50:
                    RA |= RB;
                    break;
                case 0x60:
                    RA != RA;
                    if((OP & 0x03) == 0x03) {
                        RB != RB;
                    }
                    break;
                case 0x70:
                    RA = 0;
                    if((OP & 0x03) == 0x03) {
                        RB = 0;
                    }
                    break;
                case 0x80:
                    if(RA == RB) {
                        PC += 1;
                    }
                    break;
                case 0x90:
                    if(RA != RB) {
                        PC += 1;
                    }
                    break;
                case 0xA0:
                    if(RA < RB) {
                        PC += 1;
                    }
                    break;
                case 0xB0:
                    if(RA > RB) {
                        PC += 1;
                    }
                    break;
                case 0xC0:
                    RA += RB;
                    break;
                case 0xD0:
                    RA -= RB;
                    break;
                case 0xE0:
                    RA <<= RA;
                    break;
                case 0xF0:
                    RA >>= RB;
                    break;
            }
            
            store(&RA, (OP & 0x0C));
            
            if(!(OP & 0xC0)) {
                store(&RB, (OP & 0x03) << 2);
            }
            
            PC += 1;
            STATUS &= 0x0F;
        }
        
        if((STATUS & 0x03) == 0) {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFFFF00F) | (PC << 4);
        } else if((STATUS & 0x03) == 1) {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFFFF00F) | (R0 << 4);
        } else if((STATUS & 0x03) == 2) {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFFFF00F) | (R1 << 4);
        } else {
            GPIOA_ODR = (GPIOA_ODR & 0xFFFFFF00F) | (R2 << 4);
        }
    }
}
