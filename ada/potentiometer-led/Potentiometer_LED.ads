
package Potentiometer_LED is
    
    type Word is mod 2**32;

    -- AHB bus peripheral clock enable register
    RCC_AHBENR : Word;
    pragma Volatile(RCC_AHBENR);
    pragma Import(C, RCC_AHBENR, "RCC_AHBENR");
    
    -- APB1 bus peripheral clock enable register
    RCC_APB2ENR : Word;
    pragma Volatile(RCC_APB2ENR);
    pragma Import(C, RCC_APB2ENR, "RCC_APB2ENR");
    
    -- ADC interrupt status register
    ADC_ISR : Word;
    pragma Volatile(ADC_ISR);
    pragma Import(C, ADC_ISR, "ADC_ISR");
    
    -- ADC interrupt enable register
    ADC_IER : Word;
    pragma Volatile(ADC_IER);
    pragma Import(C, ADC_IER, "ADC_IER");
    
    -- ADC control register
    ADC_CR : Word;
    pragma Volatile(ADC_CR);
    pragma Import(C, ADC_CR, "ADC_CR");
    
    -- ADC configure register 1
    ADC_CFGR1 : Word;
    pragma Volatile(ADC_CFGR1);
    pragma Import(C, ADC_CFGR1, "ADC_CFGR1");
    
    -- ADC configure register 2
    ADC_CFGR2 : Word;
    pragma Volatile(ADC_CFGR2);
    pragma Import(C, ADC_CFGR2, "ADC_CFGR2");
    
    -- ADC sample time register
    ADC_SMPR : Word;
    pragma Volatile(ADC_SMPR);
    pragma Import(C, ADC_SMPR, "ADC_SMPR");
    
    -- ADC channel select register
    ADC_CHSELR : Word;
    pragma Volatile(ADC_CHSELR);
    pragma Import(C, ADC_CHSELR, "ADC_CHSELR");
    
    -- ADC data register
    ADC_DR : Word;
    pragma Volatile(ADC_DR);
    pragma Import(C, ADC_DR, "ADC_DR");

    -- GPIO port A MODE register
    GPIOA_MODER : Word;
    pragma Volatile(GPIOA_MODER);
    pragma Import(C, GPIOA_MODER, "GPIOA_MODER");
    
    -- GPIO port A output data register
    GPIOA_ODR : Word;
    pragma Volatile(GPIOA_ODR);
    pragma Import(C, GPIOA_ODR, "GPIOA_ODR");
    
    -- SYSTICK control register
    STK_CSR : Word;
    pragma Volatile(STK_CSR);
    pragma Import(C, STK_CSR, "STK_CSR");
    
    -- SYSTICK counter reload value register
    STK_RVR : Word;
    pragma Volatile(STK_RVR);
    pragma Import(C, STK_RVR, "STK_RVR");
    
    -- NVIC interrupt set-enable register
    NVIC_ISER : Word;
    pragma Volatile(NVIC_ISER);
    pragma Import(C, NVIC_ISER, "NVIC_ISER");
    
    -- NVIC interrupt priority register
    NVIC_IPR3 : Word;
    pragma Volatile(NVIC_IPR3);
    pragma Import(C, NVIC_IPR3, "NVIC_IPR3");
    
    -- set-up hardware and peripherals
    procedure Reset;
    pragma Export(C, Reset, "RESET");
    
    -- SYSTICK interrupt handler
    procedure SYSTICK_Interrupt;
    pragma Export(C, SYSTICK_Interrupt, "SYSTICK_INTERRUPT");

    -- ADC_COMP interrupt handler
    procedure ADC_Interrupt;
    pragma Export(C, ADC_Interrupt, "ADC_INTERRUPT");

end Potentiometer_LED;
