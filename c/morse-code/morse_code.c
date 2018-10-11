#include "morse_code.h"
#include "utilities.h"
#include "registers.h"

// State/Buffer codes:
//      Reset - 2#0000#
//      Dot   - 2#0001#
//      Dash  - 2#0011#
//      Space - 2#1100#
//      EoC   - 2#1000# (End of Character)

void buffer_insert(unsigned char state) {
    // wait until current buffer finished processing
    while(COUNT); 
    BUFFER = state;
}


void interrupt() {
    // on BUFFER reset, recompute LED state and COUNT
    if(BUFFER) {
        if(BUFFER >= 0x8) {
            // LED off case (EoC / space)
            GPIOB_ODR &= 0xfffffff7;
        } else {
            // LED on case (dot / dash)
            GPIOB_ODR |= 0x00000008;
        }
        
        if(BUFFER == 0x3) {
            // dash case
            COUNT = 4;
        } else if(BUFFER == 0xc) {
            // space case
            COUNT = 6;
        } else {
            // dot / EoC case
            COUNT = 2;
        }
        
        BUFFER = 0x0;
    }

    // last count tick defaults to LED off (to pause after dashes and dots)
    if(COUNT == 1) {
        GPIOB_ODR &= 0xfffffff7;
    }
    
    COUNT--;
    
    // reset TIM2 interrupt status bit
    TIM2_SR &= 0xfffffffe;
}


void main() {
    unsigned char char_i, blip_i, mask, state;
    
    // first interrupt occurs between start_timer2 and first buffer_insert, init 1 accommodates
    COUNT  = 1;
    BUFFER = 0x0;
    
    enable_led();
    enable_timer2();
    start_timer2(RATE);
    
    // infinite loop, timer interrupt handles buffered input
    for(;;) {
        for(char_i = 0; char_i < SIZE; char_i++) {
            mask  = 0x1;
            // space case
            state = 0x4;
            
            // parse current character's signal into dots and dashes
            for(blip_i = 0; blip_i < MESSAGE[char_i].length; blip_i++) {
                if((MESSAGE[char_i].signal & mask) == mask) {
                    // dash case
                    state = 0x3;
                } else {
                    // dot case
                    state = 0x1;
                }
                
                buffer_insert(state);
                mask <<= 1;
            }
            
            // push state value over 8, EoC case
            state |= 0x8;
            
            buffer_insert(state);
        }
    }
}
