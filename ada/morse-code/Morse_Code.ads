with Registers; use Registers;
with Alphabet;  use Alphabet;
with Utilities; use Utilities;

package Morse_Code is

    -- message to output in morse code
    Message : constant Morse_Array := (H,E,L,L,O,SPACE,W,O,R,L,D,SPACE);
    -- rate of message output
    Rate    : constant Milliseconds := 100;

    -- core logic of the morse code blinker
    procedure Run;
    pragma Export(C, Run, "RESET");
    
    -- timer 2 interrupt handler
    procedure Interrupt;
    pragma Export(C, Interrupt, "TIM2_IRQ_HANDLER");

private
    Buffer : Nibble;
    Count  : Nibble;

    procedure Buffer_Insert(State : in Nibble);
    
end Morse_Code;
