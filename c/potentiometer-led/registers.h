#ifndef _REGISTERS_H_
#define _REGISTERS_H_

extern unsigned int RCC_AHBENR;
extern unsigned int RCC_APB2ENR;

extern unsigned int ADC_ISR;
extern unsigned int ADC_IER;
extern unsigned int ADC_CR;
extern unsigned int ADC_CFGR1;
extern unsigned int ADC_CFGR2;
extern unsigned int ADC_SMPR;
extern unsigned int ADC_CHSELR;
extern unsigned int ADC_DR;

extern unsigned int GPIOA_MODER;
extern unsigned int GPIOA_ODR;

extern unsigned int STK_CSR;
extern unsigned int STK_RVR;

extern unsigned int NVIC_ISER;
extern unsigned int NVIC_IPR3;

#endif
