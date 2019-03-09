OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
    RCC_AHBENR  = 0x40021014;
    RCC_APB2ENR = 0x40021018;
    
    ADC_ISR    = 0x40012400;
    ADC_IER    = 0x40012404;
    ADC_CR     = 0x40012408;
    ADC_CFGR1  = 0x4001240C;
    ADC_CFGR2  = 0x40012410;
    ADC_SMPR   = 0x40012414;
    ADC_CHSELR = 0x40012428;
    ADC_DR     = 0x40012440;
    
    GPIOA_MODER = 0x48000000;
    GPIOA_ODR   = 0x48000014;
    
    STK_CSR     = 0xE000E010;
    STK_RVR     = 0xE000E014;
    
    NVIC_ISER = 0xE000E100;
    NVIC_IPR3 = 0xE000E40C;
    
    .vectors 0x08000000 :
    {
        LONG(0x20001000)
        LONG(RESET + 1)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(SYSTICK_INTERRUPT + 1) /* NVIC interrupt SYSTICK */
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(ADC_INTERRUPT + 1) /* NVIC interrupt 12 ADC_COMP */
        FILL(0)
    }

    .text 0x08000100 :
    {
        *(.text)
    }
}
