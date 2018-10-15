
package body Blink is

    procedure Set_Up is
    begin
        -- enable clock for I/O port B:
        RCC_AHBENR := RCC_AHBENR or 16#0004_0000#;

        -- configure port B pin 03 MODE register for general purpose output:
        GPIOB_MODER := (GPIOB_MODER and 16#FFFF_FF3F#) or 16#0000_0040#;
        -- disable port B pin 03 pull-up, pull-down
        GPIOB_PUPDR := GPIOB_PUPDR and 16#FFFF_FF3F#;
        
        -- set counter to 4,000,000 (half second interrupts)
        STK_RVR := 16#003D_0900#;
        -- enable SysTick on processor clock, counter, and interrupt 
        STK_CSR := STK_CSR or 16#0000_0007#;
        
        -- infinite loop, timer interrupt handler will toggle the LED
        loop
            null;
        end loop;
    end Set_Up;
    
    
    procedure Interrupt is
    begin
        -- toggle port B pin 03 (toggle LED3)
        GPIOB_ODR := GPIOB_ODR xor 16#0000_0008#;
    end Interrupt;

end Blink;
