package body LED3 is

    type Word is mod 2**32;

    -- peripheral clock enable register
    RCC_AHBENR : Word;
    pragma Volatile (RCC_AHBENR);
    pragma Import (C, RCC_AHBENR, "RCC_AHBENR");

    -- GPIO port B MODE register
    GPIOB_MODER : Word;
    pragma Volatile (GPIOB_MODER);
    pragma Import (C, GPIOB_MODER, "GPIOB_MODER");

    -- GPIO port B set / reset register
    GPIOB_BSRR : Word;
    pragma Volatile (GPIOB_BSRR);
    pragma Import (C, GPIOB_BSRR, "GPIOB_BSRR");

    procedure Run is
    begin
        -- configure clock for I/O port B:
        RCC_AHBENR := RCC_AHBENR or 16#0004_0000#;

        -- configure port B pin 03 MODE register for general purpose output:
        GPIOB_MODER := (GPIOB_MODER and 16#ffff_ff3f#) or 16#0000_0040#;

        -- set port B pin 03 (enables LED3)
        GPIOB_BSRR := 16#0000_0008#;

        -- infinite loop
        loop
            null;
        end loop;
    end Run;

end LED3;
