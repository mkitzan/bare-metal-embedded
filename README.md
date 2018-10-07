# Bare Metal Embedded Programming

    Board:     STM32-F031K6
    Chipset:   ARM Cortex-M0
    Language:  Ada
    Toolchain: GNAT Community 2018
    Debugger:  OpenOCD v0.10.0


"build.bat" runs a script to compile, link, and flash a program to the board.
Script must be located in the project's directory to correctly operate.


Note: I am purposely not defining labels for the register masks/flags, because I find seeing the explicit hex values being applied to the registers better for learning.


# Motivations
STM32-F031K6 was choosen for the starting board, because it has the simplest ARM Cortex-Mx chip available. 
Since this is my first self directed embedded programming project (UVic's CSC 230 taught the basics), it seemed prudent to use the
simplest board possible with the least number of gizmos. 
It's got a user LED to start with, and you can slap it into a bread board for more complex stuff.
Also, it's the cheapest STM32 board: can't complain there. 


Ada was choosen for learning embedded programming simply because the syntax and type system make for more digestable code.
God bless C, but it's much easier to understand the intention of each line in Ada compared to C.
Bare metal programming seems fairly oblique, so anything which facilitates understanding and learning is a big plus.
Also, the binaries don't seem to suffer much (Blink's binary is 622 bytes and mostly a vector table).
