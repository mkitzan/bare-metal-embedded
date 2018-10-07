OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
    TIM2_CR1     = 0x40000000;
    TIM2_DIER    = 0x4000000C;
    TIM2_SR      = 0x40000010;
    TIM2_EGR     = 0x40000014;
    TIM2_CNT     = 0x40000024;
    TIM2_PSC     = 0x40000028;
    TIM2_ARR     = 0x4000002C;

    FLASH_ACR    = 0x40022000;
    RCC_CR       = 0x40021000;
    RCC_CFGR     = 0x40021004;
    RCC_APB1RST  = 0x40021010;
    RCC_AHBENR   = 0x40021014;
    RCC_APB1ENR  = 0x4002101C;
    
    GPIOB_MODER  = 0x48000400;
    GPIOB_PUPDR  = 0x4800040C;
    GPIOB_ODR    = 0x48000414;
    GPIOB_BSRR   = 0x48000418;
    
    NVIC_ISER    = 0xE000E100;
    NVIC_IPR3    = 0xE000E40C;
    
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
        LONG(TIM2_IRQ_HANDLER + 1)
        FILL(0)
    }

    .text 0x08000100 :
    {
        *(.text)
    }
}
