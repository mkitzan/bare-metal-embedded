
package Registers is
    
    type Word is mod 2**32;
    
    -- TIM2 control register 1
    TIM2_CR1 : Word;
    -- TIM2 DMA interrupt enable register
    TIM2_DIER : Word;
    -- TIM2 status register
    TIM2_SR : Word;
    -- TIM2 event generation register
    TIM2_EGR : Word;
    -- TIM2 ecounter register
    TIM2_CNT : Word;
    -- TIM2 pre-scalar register
    TIM2_PSC : Word;
    -- TIM2 auto-reload register
    TIM2_ARR : Word;
    
    -- Flash access control register
    FLASH_ACR : Word;
    
    -- clock register
    RCC_CR : Word;
    -- clock configure register
    RCC_CFGR : Word;
    -- APB1 bus peripheral clock reset register
    RCC_APB1RST : Word;
    -- AHB bus peripheral clock enable register
    RCC_AHBENR : Word;
    -- APB1 bus peripheral clock enable register
    RCC_APB1ENR : Word;
    
    -- GPIO port B MODE register
    GPIOB_MODER : Word;
    -- GPIO port B push-up pull-down register
    GPIOB_PUPDR : Word;
    -- GPIO port B output data register
    GPIOB_ODR : Word;
    -- GPIO port B set / reset register
    GPIOB_BSRR : Word;
    
    -- NVIC interrupt set-enable register
    NVIC_ISER : Word;
    -- NVIC interrupt priority register
    NVIC_IPR3 : Word;

private
    pragma Volatile(TIM2_CR1);
    pragma Import(C, TIM2_CR1, "TIM2_CR1");
    
    pragma Volatile(TIM2_DIER);
    pragma Import(C, TIM2_DIER, "TIM2_DIER");
    
    pragma Volatile(TIM2_SR);
    pragma Import(C, TIM2_SR, "TIM2_SR");
    
    pragma Volatile(TIM2_EGR);
    pragma Import(C, TIM2_EGR, "TIM2_EGR");
    
    pragma Volatile(TIM2_CNT);
    pragma Import(C, TIM2_CNT, "TIM2_CNT");
    
    pragma Volatile(TIM2_PSC);
    pragma Import(C, TIM2_PSC, "TIM2_PSC");
    
    pragma Volatile(TIM2_ARR);
    pragma Import(C, TIM2_ARR, "TIM2_ARR");
    
    pragma Volatile(FLASH_ACR);
    pragma Import(C, FLASH_ACR, "FLASH_ACR");
    
    pragma Volatile(RCC_CR);
    pragma Import(C, RCC_CR, "RCC_CR");
    
    pragma Volatile(RCC_CFGR);
    pragma Import(C, RCC_CFGR, "RCC_CFGR");
    
    pragma Volatile(RCC_APB1RST);
    pragma Import(C, RCC_APB1RST, "RCC_APB1RST");
    
    pragma Volatile(RCC_AHBENR);
    pragma Import(C, RCC_AHBENR, "RCC_AHBENR");
    
    pragma Volatile(RCC_APB1ENR);
    pragma Import(C, RCC_APB1ENR, "RCC_APB1ENR");
    
    pragma Volatile(GPIOB_MODER);
    pragma Import(C, GPIOB_MODER, "GPIOB_MODER");
    
    pragma Volatile(GPIOB_PUPDR);
    pragma Import(C, GPIOB_PUPDR, "GPIOB_PUPDR");
    
    pragma Volatile(GPIOB_ODR);
    pragma Import(C, GPIOB_ODR, "GPIOB_ODR");
    
    pragma Volatile(GPIOB_BSRR);
    pragma Import(C, GPIOB_BSRR, "GPIOB_BSRR");
    
    pragma Volatile(NVIC_ISER);
    pragma Import(C, NVIC_ISER, "NVIC_ISER");
    
    pragma Volatile(NVIC_IPR3);
    pragma Import(C, NVIC_IPR3, "NVIC_IPR3");
    
end Registers;
