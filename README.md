# Bare Metal Embedded Programming

    Board:     STM32-F031K6 (Digikey product page: https://bit.ly/2BZMY0b)
    Chipset:   ARM Cortex-M0
    Language:  Ada
    Toolchain: GNAT (https://www.adacore.com/download choose ARM ELF version)
    Debugger:  OpenOCD v0.10.0 (http://openocd.org/getting-openocd/)


"build.bat" runs a script to compile, link, and flash a program to the board.
Script must be located in the project's directory to correctly operate.

# Motivations
STM32-F031K6 was choosen for the starting board, because it has the simplest ARM Cortex-M chip available. 
Since this is my first self directed embedded programming expirement (UVic's CSC 230 taught me the basics), it seemed prudent to use the
simplest board possible with the least amount of gizmos. 
It's got a user LED to start with, then you can slap it into a bread board for more complex stuff.
And hey, it's the cheapest STM32 board too. 


Ada was choosen for learning embedded programming simply because the syntax and type system make for more digestable code.
God bless C, but it's much easier to understand the intention of each line in Ada compared to C.
Bare metal programming seems fairly oblique, so anything which facilitates understanding and learning is big plus.
Also, the binaries don't seem to suffer much (Blink's binary is 622 bytes and mostly a vector table).
