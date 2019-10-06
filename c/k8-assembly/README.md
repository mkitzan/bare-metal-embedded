# K8 Assembly

K8 is a hypothetical assembly language whose opcode length is 8-bit.
It has a 256 byte program and memory address space, and is byte addressable.

Language has four registers

| Register | Encoding | Purpose |
| --- | --- | --- |
| r0 | 00 | User |
| r1 | 01 | User |
| r2 | 10 | User |
| pc | 11 | Program counter |

## Instruction Set

Formating notes:

- Bits rA rA and rB rB represent the register value used in encoded opcode
- A register representing an address will have a **\*** in front of it
- Bits v0 v1 encode an immediate value but is offset by one such that the two bits represent values 1 to 4

| Operation | Syntax | Opcode | Explanation |
| --- | --- | --- | --- |
| Store | st *rA, rB | [0 0 0 0] [rA rA rB rB] | Store the value of register rB into the memory address of rA. |
| Load | ld rA, *rB | [0 0 0 1] [rA rA rB rB] | Load the value at the memory address of rB into rA. |
| Add | add rA, rB | [0 0 1 0] [rA rA rB rB] | Adds values rA and rB, storing the result into rA. The carry bit is lost. |
| Subtract | sub rA, rB | [0 0 1 1] [rA rA rB rB] | Subtracts values rA and rB, storing the result into rA. The borrow bit is lost. |
| Bitwise AND | and rA, rB | [0 1 0 0] [rA rA rB rB] | Performs bitwise AND between values rA and rB, storing the result into rA. |
| Bitwise OR | or rA, rB | [0 1 0 1] [rA rA rB rB] | Performs bitwise OR between values rA and rB, storing the result into rA. |
| Bitwise NOT | not rA, rB | [0 1 1 0] [rA rA rB rB] | Performs bitwise NOT individually on values rA and rB, storing the results into rA and rB respectively. |
| Bitwise NOT (alt)| not rA | [0 1 1 0] [rA rA 1 1] | Performs bitwise NOT on value rA storing the results into rA (can not NOT pc). |
| Clear | clr rA, rB | [0 1 1 1] [rA rA rB rB] | Sets both registers rA and rB to 0. |
| Clear (alt) | clr rA | [0 1 1 1] [rA rA 1 1] | Sets register rA to 0 (can not Clear pc) |
| If Equal | ife rA, rB | [1 0 0 0] [rA rA rB rB] | Compares values of rA and rB: if equal pc += 2, else pc += 1 |
| If Not Equal | ifn rA, rB | [1 0 0 1] [rA rA rB rB] | Compares values of rA and rB: if not equal pc += 2, else pc += 1 |
| If Less Than | ifl rA, rB | [1 0 1 0] [rA rA rB rB] | Compares values of rA and rB: if less than pc += 2, else pc += 1 |
| If Greater Than | ifg rA, rB | [1 0 1 1] [rA rA rB rB] | Compares values of rA and rB: if greater than pc += 2, else pc += 1 |
| Increment | inc rA, value | [1 1 0 0] [rA rA] [v0 v1] | Adds value (1 to 4) to rA |
| Decrement | dec rA, value | [1 1 0 1] [rA rA] [v0 v1] | Subtracts value (1 to 4) from rA |
| Shift Left | shl rA, value | [1 1 1 0] [rA rA] [v0 v1] | Shifts value of rA to the left by value (1 to 4) |
| Shift Right | shr rA, value | [1 1 1 1] [rA rA] [v0 v1] | Shifts value of rA to the right by value (1 to 4) |

## Program Structure

The following list describes the expected syntax of K8 programs by the assembler.
Refer to **quo_rem.k8** for a concrete example of the syntax.

K8 assembler syntax:

- Text segment must come before data segment
- Start text segment with "text:" token, followed by legal K8 assembly operations
- Start data segment with "data:" token, followed by data specifiers
- @(number) used to specify the position in memory to place data at
- Many @(number) specifiers may be used in the data segment

## Assembling and Simulating

This sub repo contains an assembler and simulator for the K8 assembly language. By running the **make assembler**, an executable for
**k8_assembler.c**. By further running **k8 (program).k8**, your K8 assembly code will be assembled into a header file used by the simulator.

This is a repo for bare-metal programming, so the simulator was written to run on an ARM microcontroller and be operated through buttons.
With a wired up STM32-F031K6 like in the provided wiring diagram, the simulator is operated in the following way:

- Each time the button wired to **pin A1** is pressed, the program will be stepped forward by one instruction.
- Double clicking the button wired to **pin A1** will automatically run each instruction.
- When the program is not running automatically, pushing the button wired to **pin A0** will cycle through the contents of each register on the eight LEDs.

## Programming Patterns

Jumps in K8 are performed by operations on the program counter itself.
There are no "add immediate" type operations, so all static data must be pre-loaded and stored in the data section.
To make the static data easily accessible, it should be loaded at both the very top and bottom of the data section.
Which is to say located close to address 0 and 256.
Both **inc** and **dec** instructions can scale a register by a value between one and four inclusive.
By incrementing or decrementing a register of value zero can allow a programmer to easily access nine memory addresses with a single **inc** or **dec** instruction. The **quo_rem.k8** example program displays this idiom.
