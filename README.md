# Bare Metal Embedded Programming

Board(s):    STM32-F031K6 (Digikey product page: https://bit.ly/2BZMY0b)
Language(s): Ada
Toolchain:   GNAT (https://www.adacore.com/download choose ARM ELF version)
Debugger:    OpenOCD 0.10.0 (http://openocd.org/getting-openocd/)


"build.bat" runs a script to compile, link, and load a program to the board.
Script must be located in the project's directory to correctly operate.


Ada was choosen for learning embedded programming simply because the syntax and type system make for more digestable code.
God bless C, but it's much easier to understand the intention of each line in Ada compared to C.
Bare metal programming seems fairly oblique, so anything which facilitates understanding and learning is big plus.
Also, the binaries don't seem to suffer much (LED3's binary is 310 bytes and mostly a vector table).
