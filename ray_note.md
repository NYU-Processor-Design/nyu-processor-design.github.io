# Reading notes

I read two pieces on how a processor runs instructions. In Patterson and Hennessy Chapter 4, I traced a single-cycle MIPS datapath for lw, sw, add, sub, AND, OR, slt, beq, and jump. The clock has to fit the slowest path, which wastes time, so pipelining overlaps instructions. Epstein's E20 manual is the 16-bit CPU I am building: $0 stays zero, memory has 8192 words, and the same code runs on single-cycle, multicycle, or pipelined hardware with forwarding and stalls.
