-- State/Buffer codes:
--      Reset - 2#0000#
--      Dot   - 2#0001#
--      Dash  - 2#0011#
--      Space - 2#1100#
--      EoC   - 2#1000#
-- Nibble used because it is a nice power of two

package body Morse_Code is
    
    procedure Run is
        Blip_Index : Nibble;
        Mask       : Nibble;
        State      : Nibble;
    begin
        Buffer := 2#0000#;
        Count  := 1;
    
        Enable_GPIO_PortB;
        Enable_Timer_2;
        Start_Timer_2(Rate);
        
        -- infinite loop, timer interrupt handler buffered input
        loop
            for Char_Index in Message'range
            loop
                Blip_Index := 2#0000#;
                Mask       := 2#0001#;
                State      := 2#0100#;
                
                -- parse current character's signal into dots and dashes
                while Blip_Index /= Message(Char_Index).Length
                loop
                    -- dash case
                    if (Message(Char_Index).Signal and Mask) = Mask
                    then 
                        State := 2#0011#;
                    -- dot case
                    else
                        State := 2#0001#;
                    end if;
                    
                    Buffer_Insert(State);
                    
                    Blip_Index := Blip_Index + 1;
                    -- shift set bit over (left shift)
                    Mask := Mask * 2; 
                end loop;
                
                -- push state value over 8, EoC case
                Buffer_Insert(State or 2#1000#);
            end loop;
        end loop;
    end Run;
    
    
    procedure Interrupt is
    begin
        if Buffer /= 2#0000#
        then
            -- LED off case (EoC / space)
            if Buffer >= 2#1000#
            then
                GPIOB_ODR := GPIOB_ODR and 16#FFFF_FFF7#;
            -- LED on case (dot / dash)
            else
                GPIOB_ODR := GPIOB_ODR or 16#0000_0008#;
            end if;
            
            -- dash case
            if Buffer = 2#0011#
            then
                Count := 4;
            -- space case
            elsif Buffer = 2#1100#
            then
                Count := 6;
            -- dot / end of character case 
            else
                Count := 2;
            end if;
            
            Buffer := 2#0000#;
        end if;
    
        -- count zero defaults off (to pause after dashes and dots)
        if Count = 1
        then
            GPIOB_ODR := GPIOB_ODR and 16#FFFF_FFF7#;
        end if;
        
        Count := Count - 1;
        
        -- reset TIM2 interrupt status bit
        TIM2_SR := TIM2_SR and 16#FFFF_FFFE#;
    end Interrupt;
    
    
    procedure Buffer_Insert(State : in Nibble) is
    begin
        -- wait until the buffer has been processed
        while Count /= 0
        loop
            null;
        end loop;

        Buffer := State;
    end Buffer_Insert;

end Morse_Code;
