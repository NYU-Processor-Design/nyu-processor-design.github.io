# Week 1: PC and Register File
We are going to start with two of the basic building blocks of the RiSC-16 processor.

## Program Counter
- What It Is: a register that holds the address of our current instruction.

- Starts at 0 at the beginning of a program

### Inputs

|Name|Size|Notes
|:---|:---:|:---:|
|`clk`|1-bit|
|`rst`|1-bit|Reset|
|`nextpc`|16-bits|Next PC|

### Outputs

|Name|Size|
|:---|:---:|
|`pc`|16-bits|


## Register File
- What It Is: array containing 8 16-bit registers, that can return values or edit a register

- Register 0 is immutable and is always 0.

**NOTE:** If you want to output the final register values in your testbench (which will make sense later), you can edit this module by creating extra wires that store the value of each register in the array, and outputting these wires.

### Inputs

|Name|Size|Notes
|:---|:---:|:---:|
|`clk`|1-bit|
|`we_reg`|1-bit|Write-Enable signal for registers
|`src1`|3-bits|Source Register 1|
|`src2`|3-bits|Source Register 2|
|`tgt`|3-bits|Destination Register
|`write_data`|16-bits|Data to be stored in Destination Register


### Outputs

|Name|Size|Notes
|:---|:---:|:---:
|`src1_val`|16-bits|Value of Source Reg 1
|`src2_val`|16-bits|Value of Source Reg 2