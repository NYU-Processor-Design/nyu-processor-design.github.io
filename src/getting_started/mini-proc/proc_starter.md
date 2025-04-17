# Building a Simple Processor

A Beginner's Guide to Computer Architecture & Verilog

So you want to start building processors... welcome.

The goal: implement a [RiSC-16 processor](https://user.eng.umd.edu/~blj/RiSC/) (courtesy of Bruce Jacobs at UMD)

## Computer Architecture Basics
It tells you how to organize basic building blocks (like memory, registers, and ALUs) to make a working machine.

At a high level, a CPU needs:
* Program Counter (PC): Holds the address of the next instruction.
* Instruction Memory: Stores the program's instructions.
* Control Unit: Decodes instructions and controls other parts of the processor.
* Register File: Small, fast storage for operands and results.
* ALU (Arithmetic Logic Unit): Performs arithmetic and logical operations.
* Data Memory: Stores data that the program manipulates.
* Sign Extender: Extends immediate values to full width.
* Multiplexers (MUXes): Select between multiple data sources.


### Life Cycle of an Instruction:
FETCH
- fetch instruction from instruction memory using the PC

DECODE
- use opcode to figure out what instruction it is
- extract register and immediate value arguments

EXECUTE
- use ALU for computational operations

MEMORY
- access (read or write) data memory for LW and SW

WRITE-BACK
- update registers & PC

## Verilog Basics

One version of an online cheatsheet [here.](https://gist.github.com/LastZactionHero/3c1b9baed5a280e25d06f744b4a6da63)

| Concept | Description | Example |
| --------| ----------- | ------- |
`module` | Defines a block of hardware | `module my_module(input a, output b); .... endmodule`
`wire` | Connection between things (pure wire) | `wire a;`
`reg` | Like a wire, but can hold a value across clock cycles | `reg [15:0] pc;`
`assign` | Assign a wire with a continuous value | `assign out = a & b;`
`always @(*)` | Reacts whenever inputs change (combinational) | `always @(*) begin ... end`
`always @(posedge clk)` | Reacts on rising edge of clock (sequential) | `always @(posedge clk) begin ... end`
`if`, `case` | Usual control structures | ```case (opcode) ```|
||| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`4'b0000: //do something`
||| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`4'b0001: //do something else`
|||`endcase`
`[N:M]` | Bit slicing | `a[7:0]` selects the lowest 8 bits


## Overview of the RiSC-16 Processor
* 8 main instructions: `add`, `addi`, `nand`, `lui`, `sw`, `lw`, `beq`, `jalr`
* 6 pseudo-instructions/directives: `nop`, `halt`, `lli`, `movi`, `.fill`, `.space`
* 8 registers (including an immutable `R0 = 0`)
* Instruction & Data memory
* 16-bit instructions/addresses
