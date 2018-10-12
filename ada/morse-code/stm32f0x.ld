OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
    /* change address of data start between programs */
    .data 0x080004d8 :
    {
        *(.data)
    }

    /* STM32 F013K6 registers */
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
    
    /* STM32 F013K6 vector table */
    .vectors 0x08000000 :
    {
        LONG(0x20001000) /* top of stack */
        LONG(RESET + 1) /* reset handler */
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
        LONG(TIM2_IRQ_HANDLER + 1) /* NVIC interrupt 15, TIM2 */
        FILL(0)
    }

    /* STM32 F013K6 flash start */
    .text 0x08000100 :
    {
        *(.text)
    }
    
    /* STM32 F013K6 bss start */
    .bss 0x20000000 :
    {
        *(.bss)
    }
}
