extern unsigned int RCC_AHBENR;
extern unsigned int GPIOB_MODER;
extern unsigned int GPIOB_BSRR;

int main() {
    // enable clock for I/O port B:
    RCC_AHBENR  |= 0x00040000;
    // configure port B pin 03 MODE register for general purpose output
    GPIOB_MODER |= 0x00000040;
    // set port B pin 03 (enables LED3)
    GPIOB_BSRR  |= 0x00000008;
    
    for(;;);
}
