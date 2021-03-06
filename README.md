# Bare Metal Embedded Programming

    Board:     STM32-F031K6
    Chipset:   ARM Cortex-M0
    Language:  Ada, C
    Toolchain: GNAT Community 2018, GNU GCC 7.3.1
    Debugger:  OpenOCD v0.10.0

"build.bat" is a script which compiles, links, and flashes the program to the board.
Script must be located in the project's directory to correctly operate.

Note: I am purposely not defining labels for the register masks/flags,
because I find seeing the explicit hex values being applied to the registers better for learning.
However, for similar reasons, any index or counter will be assigned decimal values.

## Motivations

STM32-F031K6 was chosen for the starting board, because it has the simplest ARM Cortex-Mx chip available.
Since this is my first self-directed embedded programming project (UVic's CSC 230 taught the basics), it seemed prudent to use the
simplest board possible with the least number of gizmos.
It's got a user LED to start with, and you can slap it into a bread board for more complex stuff.
Also, it's the cheapest STM32 board: can't complain there.

## Highlights

8-Bit Opcode Assembly Language (assembler and simulator):

- https://github.com/mkitzan/bare-metal-embedded/tree/master/c/k8-assembly

Morse code LED blinking:

- https://github.com/mkitzan/bare-metal-embedded/tree/master/ada/morse-code
- https://github.com/mkitzan/bare-metal-embedded/tree/master/c/morse-code
