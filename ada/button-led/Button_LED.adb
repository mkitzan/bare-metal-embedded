
package body Button_LED is

    procedure Set_Up is begin
        -- enable system config clock
        RCC_APB2ENR := RCC_APB2ENR or 16#00000001#;
        -- enable clock for I/O port A
        RCC_AHBENR  := RCC_AHBENR or 16#00020000#;
        
        -- configures EXTI0 to source port A pin 00
        SYSCFG_EXTICR1 := SYSCFG_EXTICR1 and 16#FFFFFFF8#;
        -- enable interrupt trigger on rising-edge
        EXTI_RTSR := EXTI_RTSR or 16#00000001#;
        -- disable interrupt trigger on falling-edge
        EXTI_FTSR := EXTI_FTSR and 16#FFFFFFFE#;
        -- enable interrupt on pin 00
        EXTI_IMR  := EXTI_IMR or 16#00000001#;
        
        -- set NVIC vector 5 (EXTI0_1) to lowest priority
        NVIC_IPR1 := NVIC_IPR1 or 16#0000C000#;
        -- enable NVIC vector 5 (EXTI0_1)
        NVIC_ISER := NVIC_ISER or 16#00000020#;
        
        -- configure port A pins 00 and 01 MODE register
        GPIOA_MODER := GPIOA_MODER or 16#00000004#;
        -- configure port A pin 00 to a pull-up resistor
        GPIOA_PUPDR := GPIOA_PUPDR or 16#00000001#;
        
        loop
            null;
        end loop;
    end Set_Up;
    
    
    procedure Interrupt is begin
        -- toggle port A pin 01
        GPIOA_ODR := GPIOA_ODR xor 16#00000002#;
        -- clear EXTI0 event
        EXTI_PR := EXTI_PR or 16#00000001#;
    end Interrupt;

end Button_LED;
