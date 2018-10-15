
package Blink is

    type Word is mod 2**32;

    -- AHB bus peripheral clock enable register
    RCC_AHBENR : Word;
    pragma Volatile(RCC_AHBENR);
    pragma Import(C, RCC_AHBENR, "RCC_AHBENR");
    
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
    
    -- SysTick control status register
    STK_CSR : Word;
    pragma Volatile(STK_CSR);
    pragma Import(C, STK_CSR, "STK_CSR");
    
    -- SysTick reload value register
    STK_RVR : Word;
    pragma Volatile(STK_RVR);
    pragma Import(C, STK_RVR, "STK_RVR");

    -- SysTick counter vlaue register
    STK_CVR : Word;
    pragma Volatile(STK_CVR);
    pragma Import(C, STK_CVR, "STK_CVR");

    -- SysTick calibration register
    STK_CALIB : Word;
    pragma Volatile(STK_CALIB);
    pragma Import(C, STK_CALIB, "STK_CALIB");
    
    -- set-up hardware and peripherals
    procedure Set_Up;
    pragma Export(C, Set_Up, "RESET");
    
    -- SysTick interrupt handler
    procedure Interrupt;
    pragma Export(C, Interrupt, "SYSTICK_HANDLER");

end Blink;
