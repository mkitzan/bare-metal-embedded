
package Button_LED is

    type Word is mod 2**32;

    -- AHB bus peripheral clock enable register
    RCC_AHBENR : Word;
    pragma Volatile(RCC_AHBENR);
    pragma Import(C, RCC_AHBENR, "RCC_AHBENR");
    
    -- APB1 bus peripheral clock enable register
    RCC_APB2ENR : Word;
    pragma Volatile(RCC_APB2ENR);
    pragma Import(C, RCC_APB2ENR, "RCC_APB2ENR");
    
    -- EXTI control register in sys-config
    SYSCFG_EXTICR1 : Word;
    pragma Volatile(SYSCFG_EXTICR1);
    pragma Import(C, SYSCFG_EXTICR1, "SYSCFG_EXTICR1");
    
    -- EXTI enable register
    EXTI_IMR : Word;
    pragma Volatile(EXTI_IMR);
    pragma Import(C, EXTI_IMR, "EXTI_IMR");
    
    -- EXTI rising edge interrupt enable register
    EXTI_RTSR : Word;
    pragma Volatile(EXTI_RTSR);
    pragma Import(C, EXTI_RTSR, "EXTI_RTSR");
    
    -- EXTI falling edge interrupt enable register
    EXTI_FTSR : Word;
    pragma Volatile(EXTI_FTSR);
    pragma Import(C, EXTI_FTSR, "EXTI_FTSR");
    
    -- EXTI event reset register
    EXTI_PR : Word;
    pragma Volatile(EXTI_PR);
    pragma Import(C, EXTI_PR, "EXTI_PR");

    -- GPIO port A MODE register
    GPIOA_MODER : Word;
    pragma Volatile(GPIOA_MODER);
    pragma Import(C, GPIOA_MODER, "GPIOA_MODER");
    
    -- GPIO port A push-up pull-down register
    GPIOA_PUPDR : Word;
    pragma Volatile(GPIOA_PUPDR);
    pragma Import(C, GPIOA_PUPDR, "GPIOA_PUPDR");
    
    -- GPIO port A output data register
    GPIOA_ODR : Word;
    pragma Volatile(GPIOA_ODR);
    pragma Import(C, GPIOA_ODR, "GPIOA_ODR");
    
    -- NVIC interrupt set-enable register
    NVIC_ISER : Word;
    pragma Volatile(NVIC_ISER);
    pragma Import(C, NVIC_ISER, "NVIC_ISER");
    
    -- NVIC interrupt priority register
    NVIC_IPR1 : Word;
    pragma Volatile(NVIC_IPR1);
    pragma Import(C, NVIC_IPR1, "NVIC_IPR1");
    
    -- set-up hardware and peripherals
    procedure Set_Up;
    pragma Export(C, Set_Up, "RESET");
    
    -- EXTI interrupt handler
    procedure Interrupt;
    pragma Export(C, Interrupt, "INTERRUPT");

end Button_LED;
