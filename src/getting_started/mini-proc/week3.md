# Week 3: ALU

Time for some computation!

What It Is: Arithmetic Logic Unit - it, well, does arithmetic and logical operations.

### Inputs

|Name|Size|Notes
|:---|:---:|:---:
|`alu_src1`|16-bits|Operand 1
|`alu_src2`|16-bits|Operand 2
|`ADD`|1-bit|Are we `add`ing?
|`NAND`|1-bit|Are we `nand`ing?
|`PASS1`|1-bit|See `LUI` and `JALR` in ISA
|`EQ`|1-bit|Are we checking equality? See `BEQ`


### Outputs

|Name|Size|Notes
|:---|:---:|:---:
|`alu_out`|16-bits|ALU Output
|`eq_out`|1-bit|Are values equal? See `BEQ`
