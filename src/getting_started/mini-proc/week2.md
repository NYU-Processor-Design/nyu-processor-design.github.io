# Week 2: Instruction and Data Memory
Next up, where we store our program instructions and data.


## Instruction Memory
- What It Is: read-only memory array containing program instructions

- Not specified in the RiSC-16 docs, but we will have 256 cells.

- Reads machine code file and loads into memory array, and returns instruction at current PC.

### Inputs

|Name|Size|
|:---|:---:|
|`pc`|16-bits|

### Outputs

|Name|Size|
|:---|:---:|
|`instr`|16-bits|


## Data Memory
- What It Is: read-and-write memory array containing any data written by the program

- Not specified in the RiSC-16 docs, but we will have 256 cells.

- `LW` reads from data memory, `SW` writes to data memory.

### Inputs

|Name|Size|Notes
|:---|:---:|:---:
|`clk`|1-bit|
|`we_mem`|1-bit|Write-Enable signal for data memory
|`addr`|16-bits|
|`data_in`|16-bits|data for SW

### Outputs

|Name|Size|Notes
|:---|:---:|:---:
|`data_out`|16-bits|data read by LW
