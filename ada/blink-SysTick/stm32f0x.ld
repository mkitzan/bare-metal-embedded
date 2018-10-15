OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
    RCC_CR      = 0x40021000;
    RCC_CFGR    = 0x40021004;
    RCC_APB1RST = 0x40021010;
    RCC_AHBENR  = 0x40021014;
    
    GPIOB_MODER = 0x48000400;
    GPIOB_PUPDR = 0x4800040C;
    GPIOB_ODR   = 0x48000414;
    GPIOB_BSRR  = 0x48000418;
    
    STK_CSR     = 0xE000E010;
    STK_RVR     = 0xE000E014;
    STK_CVR     = 0xE000E018;
    STK_CALIB   = 0xE000E01C;
    
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
        LONG(SYSTICK_HANDLER + 1)
        FILL(0)
    }

    .text 0x08000100 :
    {
        *(.text)
    }
}
