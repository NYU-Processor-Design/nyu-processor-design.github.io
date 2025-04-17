# Week 5: Top-Level Processor

The time has come to put everything together! We are going to implement a top-level module that connects all of our components together and is able to run a machine-code program.


**Step 1: Set up inputs and outputs.**

#### Inputs

|Name|Size|
|:---|:---:|
|`clk`|1-bit|
|`reset`|1-bit|

#### Outputs

You can output whichever elements you may want to monitor / print in the testbench. For example, I might return the PC, the current instruction, and the number of the destination register for the current instruction (for debugging purposes). It would look like this:

|Name|Size|
|:---|:---:|
|`curr_pc`|16-bits|
|`curr_instr`|16-bits|
|`curr_regA`|3-bits|

**Step 2: Set up necessary wires and registers**

We need hardware to store all the data our processor needs to run. This list will correspond with the inputs and outputs of our other modules.

We will also need to parse and decode the current instruction into registers/immediate values by slicing our instruction by bit number (according to the ISA). 

*An important detail to remember is that immediate values need to be sign-extended -- if the 7-bit immediate begins with `1`, it is negative, and we need to insert 9 `1`'s at the beginning to "sign-extend" this number, converting it from 7 bits to 16 bits.*

**Step 3.1: Set inputs based on opcode**

Using `always` and `case` statements, use the opcode to set the appropriate wires/registers that correspond to the inputs of our other components. For example, for the `ADD` instruction, I would want to set the inputs for the register file to the correct registers, and the inputs for the ALU to the correct data. We also want to store the output of the ALU, and set the program counter. You may have to play around with the instantiation of your modules (see Step 3.2)

**Step 3.2: Instantiate all other components.**

If I have a module file `sample.v` that looks like this:
```
module sample(
    input wire [3:0] a, b,
    output wire [4:0] sum
);
    assign sum = a + b;
endmodule
```

My top level module file `top.v` might have something like this:
```
`include "sample.v" //important! make sure you include your component files

module top;
    reg [3:0] a, b;
    wire [4:0] sum;

    // uut = unit under test
    the_module sample uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    //... other modules and operations
endmodule
```

You want to instantiate all of our modules and connect them with Step 3.1. What we want to happen is that Step 3.1 sets up inputs, sends the inputs to the corresponding components, and then stores the output to potentially be used by another component.

For example, for `ADD`, we will send the register arguments to the Register File, which returns the values. We then send those values to the ALU, and store the ALU output that gets sent back to the register file to edit the destination register.