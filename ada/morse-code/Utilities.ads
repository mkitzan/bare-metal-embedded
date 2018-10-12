with Registers; use Registers;

package Utilities is

    subtype Milliseconds is Word;
    -- small utility set from past projects
    procedure Enable_GPIO_PortB;
    procedure Enable_Timer_2;
    procedure Start_Timer_2(Rate : in Milliseconds);
    procedure Stop_Timer_2;

private
    -- inline is no longer supported in Ada 2012, but
    pragma Inline(Enable_GPIO_PortB);
    pragma Inline(Enable_Timer_2);
    pragma Inline(Start_Timer_2);
    pragma Inline(Stop_Timer_2);

end Utilities;
