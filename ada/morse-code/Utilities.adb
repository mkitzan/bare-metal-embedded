
package body Utilities is

    procedure Enable_GPIO_PortB is
    begin
        -- enable clock for I/O port B:
        RCC_AHBENR := RCC_AHBENR or 16#0004_0000#;
        -- configure port B pin 03 MODE register for general purpose output:
        GPIOB_MODER := GPIOB_MODER or 16#0000_0040#;
        -- disable port B pin 03 pull-up, pull-down
        GPIOB_PUPDR := GPIOB_PUPDR and 16#FFFF_FF3F#;
    end Enable_GPIO_PortB;
    

    procedure Enable_Timer_2 is
    begin
        -- configure PLL clock register for HSI / 2 and scalar 6 => 24mhz PLL
        RCC_CFGR := RCC_CFGR or 16#0010_0000#;
        -- enable PLL clock, wait until ready
        RCC_CR := RCC_CR or 16#0100_0000#;
        while (RCC_CR and 16#0200_0000#) /= 16#0200_0000# 
        loop 
            null;
        end loop;
        
        -- switch clock to PLL, wait until ready
        RCC_CFGR := RCC_CFGR or 16#0000_0002#;
        while (RCC_CFGR and 16#0000_0008#) /= 16#0000_0008# 
        loop 
            null;
        end loop;
        
        -- enable clock for TIM2
        RCC_APB1ENR := RCC_APB1ENR or 16#0000_0001#;
        -- disable TIM2
        TIM2_CR1 := TIM2_CR1 and 16#FFFF_FFFE#;
        -- set TIM2 pre-scalar register to 1/1000 of the clock speed
        TIM2_PSC := 24000000 / 1000; 
        
        -- set NVIC vector 15 (TIM2) to lowest priority 3
        NVIC_IPR3 := NVIC_IPR3 or 16#C000_0000#;
        -- enable NVIC vector 15 (TIM2)
        NVIC_ISER := NVIC_ISER or 16#0000_8000#;
        
        -- enable hardware interrupt
        TIM2_DIER := TIM2_DIER or 16#0000_0001#;
    end Enable_Timer_2;
    
    
    procedure Start_Timer_2(Rate : in Milliseconds) is
    begin
        -- disable TIM2
        TIM2_CR1 := TIM2_CR1 and 16#FFFF_FFFE#;
        -- reset clock for TIM2
        RCC_APB1RST := RCC_APB1RST and 16#FFFF_FFFE#;
        -- set TIM2 auto-reload register to 1000
        TIM2_ARR := Rate;
        -- reset event
        TIM2_EGR := TIM2_EGR or 16#0000_0001#;
        -- enable TIM2
        TIM2_CR1 := TIM2_CR1 or 16#0000_0001#;
    end Start_Timer_2;
    
    
    procedure Stop_Timer_2 is
    begin
        -- disable TIM2
        TIM2_CR1 := TIM2_CR1 and 16#FFFF_FFFE#;
        -- reset TIM2 interrupt status bit
        TIM2_SR := TIM2_SR and 16#FFFF_FFFE#;
    end Stop_Timer_2;

end Utilities;
