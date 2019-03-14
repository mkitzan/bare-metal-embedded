#ifndef _REGISTERS_H_
#define _REGISTERS_H_

extern unsigned int RCC_APB2ENR;
extern unsigned int RCC_AHBENR;

extern unsigned int SYSCFG_EXTICR1;

extern unsigned int EXTI_IMR;
extern unsigned int EXTI_RTSR; 
extern unsigned int EXTI_FTSR;
extern unsigned int EXTI_PR;

extern unsigned int GPIOA_MODER;
extern unsigned int GPIOA_PUPDR;
extern unsigned int GPIOA_ODR;

extern unsigned int STK_CSR;
extern unsigned int STK_RVR;

extern unsigned int NVIC_ISER;
extern unsigned int NVIC_IPR1;

#endif
