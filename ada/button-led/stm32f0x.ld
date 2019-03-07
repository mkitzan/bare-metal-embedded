OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
    RCC_AHBENR  = 0x40021014;
    RCC_APB2ENR = 0x40021018;
    
    SYSCFG_EXTICR1 = 0x40010008;
    
    EXTI_IMR  = 0x40010400;
    EXTI_RTSR = 0x40010408;
    EXTI_FTSR = 0x4001040C;
    EXTI_PR   = 0x40010414;
    
    GPIOA_MODER = 0x48000000;
    GPIOA_PUPDR = 0x4800000C;
    GPIOA_IDR   = 0x48000010;
    GPIOA_ODR   = 0x48000014;
    
    NVIC_ISER = 0xE000E100;
    NVIC_IPR1 = 0xE000E404;
    
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
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(0)
        LONG(INTERRUPT + 1) /* NVIC interrupt 5, EXTI0_1 */
        FILL(0)
    }

    .text 0x08000100 :
    {
        *(.text)
    }
}
