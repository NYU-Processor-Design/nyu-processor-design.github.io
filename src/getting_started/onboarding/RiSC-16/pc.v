module pc (
    input clk,
    input rst_n,
    input [1:0] MUX_output, // Controlled by Control module
    input [15:0] imm, // Immediate value
    input [15:0] alu_out, // The output from regB that has been passed through the ALU
    output [15:0] nxt_instr
);

reg [15:0] pc_reg; // Internal Register to hold state of pc

assign nxt_instr = pc_reg; // Assigns output to be linked to pc_reg

always @(posedge clk or negedge rst_n) 
begin
    if (!rst_n) 
    begin
        // On reset, the program counter is initialized to the starting address 0.
        pc_reg <= 16'h0000;
    end 
    else 
    begin
        // On a clock edge, the next value of the PC is determined by the MUX selector.
        case (MUX_output)
            2'b00:
                pc_reg <= pc_reg + 1;
            2'b01:
                pc_reg <= pc_reg + imm + 1;
            2'b10:
                pc_reg <= alu_out;
            default: 
                pc_reg <= pc_reg + 1; // safety
        endcase
    end
end

endmodule
