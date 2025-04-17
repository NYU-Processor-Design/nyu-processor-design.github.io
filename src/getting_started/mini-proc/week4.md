# Week 4: Control Unit

The mastermind of signals...

What It Is: decodes instructions and sends different signals to the various components based on the type of instruction. For example, for the `ADD` or `ADDI` instructions, it would set the `ADD` signal to 1 and the `we_reg` signal to 1, to allow the ALU to add two source values and edit the register file with the result.

**IMPORTANT NOTE**: There are other ways to implement the Control Unit than specified below, that would also change the inputs of the other modules. If you want to follow the RiSC-16 documentation more closely, you can add multiplexers, adjust the other modules, and implement the control signals listed in the RiSC-seq file.

*Editor Note: This page is still in-progress, due to BEQ.*

### Inputs

|Name|Size|Notes
|:---|:---:|:---:
|`opcode`|3-bits|
|`eq_out`|1-bit|for `BEQ`


### Outputs

|Name|Size|Notes
|:---|:---:|:---:
|`we_reg`|1-bit|
|`ADD`|1-bit|
|`NAND`|1-bit
|`PASS1`|1-bit
|`we_mem`|1-bit
|`EQ`|1-bit
|`BR`|1-bit
