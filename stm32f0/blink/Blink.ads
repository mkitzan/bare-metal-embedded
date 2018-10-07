
package Blink is

    type Word is mod 2**32;
    
    -- TIM2 control register 1
    TIM2_CR1 : Word;
    pragma Volatile(TIM2_CR1);
    pragma Import(C, TIM2_CR1, "TIM2_CR1");
    
    -- TIM2 DMA interrupt enable register
    TIM2_DIER : Word;
    pragma Volatile(TIM2_DIER);
    pragma Import(C, TIM2_DIER, "TIM2_DIER");
    
    -- TIM2 status register
    TIM2_SR : Word;
    pragma Volatile(TIM2_SR);
    pragma Import(C, TIM2_SR, "TIM2_SR");
    
    -- TIM2 event generation register
    TIM2_EGR : Word;
    pragma Volatile(TIM2_EGR);
    pragma Import(C, TIM2_EGR, "TIM2_EGR");
    
    -- TIM2 ecounter register
    TIM2_CNT : Word;
    pragma Volatile(TIM2_CNT);
    pragma Import(C, TIM2_CNT, "TIM2_CNT");
    
    -- TIM2 pre-scalar register
    TIM2_PSC : Word;
    pragma Volatile(TIM2_PSC);
    pragma Import(C, TIM2_PSC, "TIM2_PSC");
    
    -- TIM2 auto-reload register
    TIM2_ARR : Word;
    pragma Volatile(TIM2_ARR);
    pragma Import(C, TIM2_ARR, "TIM2_ARR");
    
    -- Flash access control register
    FLASH_ACR : Word;
    pragma Volatile(FLASH_ACR);
    pragma Import(C, FLASH_ACR, "FLASH_ACR");
    
    -- clock register
    RCC_CR : Word;
    pragma Volatile(RCC_CR);
    pragma Import(C, RCC_CR, "RCC_CR");
    
    -- clock configure register
    RCC_CFGR : Word;
    pragma Volatile(RCC_CFGR);
    pragma Import(C, RCC_CFGR, "RCC_CFGR");
    
    -- APB1 bus peripheral clock reset register
    RCC_APB1RST : Word;
    pragma Volatile(RCC_APB1RST);
    pragma Import(C, RCC_APB1RST, "RCC_APB1RST");

    -- AHB bus peripheral clock enable register
    RCC_AHBENR : Word;
    pragma Volatile(RCC_AHBENR);
    pragma Import(C, RCC_AHBENR, "RCC_AHBENR");
    
    -- APB1 bus peripheral clock enable register
    RCC_APB1ENR : Word;
    pragma Volatile(RCC_APB1ENR);
    pragma Import(C, RCC_APB1ENR, "RCC_APB1ENR");

    -- GPIO port B MODE register
    GPIOB_MODER : Word;
    pragma Volatile(GPIOB_MODER);
    pragma Import(C, GPIOB_MODER, "GPIOB_MODER");
    
    -- GPIO port B push-up pull-down register
    GPIOB_PUPDR : Word;
    pragma Volatile(GPIOB_PUPDR);
    pragma Import(C, GPIOB_PUPDR, "GPIOB_PUPDR");
    
    -- GPIO port B output data register
    GPIOB_ODR : Word;
    pragma Volatile(GPIOB_ODR);
    pragma Import(C, GPIOB_ODR, "GPIOB_ODR");

    -- GPIO port B set / reset register
    GPIOB_BSRR : Word;
    pragma Volatile(GPIOB_BSRR);
    pragma Import(C, GPIOB_BSRR, "GPIOB_BSRR");
    
    -- NVIC interrupt set-enable register
    NVIC_ISER : Word;
    pragma Volatile(NVIC_ISER);
    pragma Import(C, NVIC_ISER, "NVIC_ISER");
    
    -- NVIC interrupt priority register
    NVIC_IPR3 : Word;
    pragma Volatile(NVIC_IPR3);
    pragma Import(C, NVIC_IPR3, "NVIC_IPR3");
    
    -- set-up hardware and peripherals
    procedure Set_Up;
    pragma Export(C, Set_Up, "RESET");
    
    -- timer 2 interrupt handler
    procedure Interrupt;
    pragma Export(C, Interrupt, "TIM2_IRQ_HANDLER");

end Blink;
