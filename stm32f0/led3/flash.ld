OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)

SECTIONS
{
    RCC_AHBENR  = 0x40021014;
    GPIOB_MODER = 0x48000400;
    GPIOB_BSRR  = 0x48000418;
    
    .vectors 0x08000000 :
    {
        LONG(0x20001000)
        LONG(run + 1)
        FILL(0)
    }

    .text 0x08000100 :
    {
        *(.text)
    }
}
