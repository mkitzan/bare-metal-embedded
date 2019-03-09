
package body Potentiometer_LED is

    procedure Reset is
    begin
        -- enable clock for ADC
        RCC_APB2ENR :=  RCC_APB2ENR or 16#000000200#;
        -- enable clock for I/O port A
        RCC_AHBENR  := RCC_AHBENR or 16#00020000#;
        -- enable port A pin 00 for analog and pin 01 for output
        GPIOA_MODER := GPIOA_MODER or 16#00000007#;
        
        -- enable interrupts on end of conversion
        ADC_IER    := ADC_IER or 16#00000004#;
        -- configure ADC for continuous conversion and 6 bit resolution
        ADC_CFGR1  := ADC_CFGR1 or 16#00002018#;
        -- configure ADC for PCLCK / 2
        ADC_CFGR2  := ADC_CFGR2 or 16#40000000#;
        -- set sampling time to 13.5 ADC clock cycles
        ADC_SMPR   := ADC_SMPR or 16#00000002#;
        -- select GPIO line 0 as input channel
        ADC_CHSELR := ADC_CHSELR or 16#00000001#;
        
        -- perform ADC calibration
        ADC_CR := ADC_CR or 16#80000000#;
        while (ADC_CR and 16#80000000#) /= 0
        loop
            null;
        end loop;
        -- enable ADC
        ADC_CR := ADC_CR or 16#00000001#;
        while (ADC_ISR and 16#00000001#) /= 0
        loop
            null;
        end loop;
        
        -- set NVIC vector 12 (ADC_COMP) to lowest priority
        NVIC_IPR3 := NVIC_IPR3 or 16#000000C0#;
        -- enable NVIC vector 12 (ADC_COMP)
        NVIC_ISER := NVIC_ISER or 16#00001000#;
        -- enable SysTick on processor clock, counter, and interrupt 
        STK_CSR   := STK_CSR or 16#00000007#;
        -- start ADC
        ADC_CR    := 16#00000004#;
        
        loop
            null;
        end loop;
    end Reset;
    
    procedure SYSTICK_Interrupt is
    begin
        -- toggle port A pin 01
        GPIOA_ODR := GPIOA_ODR xor 16#00000002#;
        null;
    end SYSTICK_Interrupt;
    
    procedure ADC_Interrupt is
    begin
        -- read ADC data ADC_DR and adjust sysclock reload value
        STK_RVR := 16#30D40# * ((ADC_DR and 16#0000003F#) + 1);
        -- reset end of conversion flag
        ADC_ISR := ADC_ISR or 16#00000004#;
    end ADC_Interrupt;

end Potentiometer_LED;
    