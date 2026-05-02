module alu (
    input MUX_alu1, MUX_alu2, // Controlled by Control module. 0-src_reg, 1-alternate input
    input [1:0] FUNC_alu, // Controlled by Control module. 00-ADD, 01-NAND, 10-PASS1, 11-EQL
    input [15:0] src1_reg, src2_reg, // The two inputs from the register file
    input [9:0] imm, // 10 bits from immediate. Only 7 used for the sign-extend-7 value
    output reg EQ, // EQ! bit output for BEQ instruction
    output reg [15:0] alu_out // Function output
);


wire [15:0] se_imm, ls_imm;
wire [15:0] SRC1, SRC2;

assign se_imm = {{9{imm[6]}}, imm[6:0]}; // Sign extends the least significant 7 bits from immediate value to 16 digits
assign ls_imm = imm << 6; // Left shifts the full 10 digits of immediate value and fills the rest with 0's

assign SRC1 = MUX_alu1 ? ls_imm : src1_reg; // Chooses the input to SRC1
assign SRC2 = MUX_alu2 ? se_imm : src2_reg; // Chooses the input for SRC2

always @(*) 
begin
    alu_out = 16'h0000;
    EQ = (SRC1 == SRC2);
    case (FUNC_alu) 
        2'b00: // Add SRC1 and SRC2 (ADD/ADDI/LW/SW)
        begin
            alu_out = SRC1 + SRC2;
        end
        2'b01: // bitwise NAND operation (NAND)
        begin
            alu_out = ~(SRC1 & SRC2);
        end
        2'b10: // PASS1 operation (LUI/JALR)
        begin
            alu_out = SRC1;
        end
        2'b11: // EQ! operation (BEQ)
        begin 
            alu_out = 16'b0;
        end
        default: // Default case
        begin
            alu_out = 16'b0;
            EQ = 1'b0;
        end
    endcase
end
endmodule