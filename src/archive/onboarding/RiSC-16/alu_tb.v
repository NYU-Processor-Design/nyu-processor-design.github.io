`timescale 1ns / 1ps

module alu_tb;

    // Inputs
    reg MUX_alu1, MUX_alu2;
    reg [1:0] FUNC_alu;
    reg [15:0] src1_reg, src2_reg;
    reg [9:0] imm;

    // Outputs
    wire EQ;
    wire [15:0] alu_out;
    
    // Instantiate the Unit Under Test (UUT)
    // You can swap "alu" with "alu_corrected" to test the corrected module
    alu uut (
        .MUX_alu1(MUX_alu1),
        .MUX_alu2(MUX_alu2),
        .FUNC_alu(FUNC_alu),
        .src1_reg(src1_reg),
        .src2_reg(src2_reg),
        .imm(imm),
        .EQ(EQ),
        .alu_out(alu_out)
    );


    // Test sequence
    initial begin
        // 1. Initialize Inputs and apply reset
        $display("--------------------------------------------------");
        $display("--- Starting ALU Testbench ---");
        $display("--------------------------------------------------");

        MUX_alu1 = 0;
        MUX_alu2 = 0;
        FUNC_alu = 0;
        src1_reg = 0;
        src2_reg = 0;
        imm = 0;
        
        
        // 2. Test ADD (reg + reg)
        $display("\n--- Testing ADD (FUNC=00, MUX=0,0) ---");
        FUNC_alu = 2'b00; MUX_alu1 = 0; MUX_alu2 = 0;
        src1_reg = 16'd10; src2_reg = 16'd20; #10;
        $display("Time=%0t: 10 + 20 = %d, EQ=%b", $time, alu_out, EQ);
        src1_reg = 16'hFFFF; src2_reg = 16'd1; #10; // -1 + 1 = 0
        $display("Time=%0t: -1 + 1 = %d, EQ=%b", $time, alu_out, EQ);
        src1_reg = 16'd55; src2_reg = 16'd55; #10;
        $display("Time=%0t: 55 + 55 = %d, EQ=%b", $time, alu_out, EQ);

        // 3. Test ADDI (reg + sign-extended immediate)
        $display("\n--- Testing ADDI (FUNC=00, MUX=0,1) ---");
        FUNC_alu = 2'b00; MUX_alu1 = 0; MUX_alu2 = 1;
        src1_reg = 16'd100; imm = 10'd5; #10; // imm[6:0] = 5, positive
        $display("Time=%0t: 100 + 5 (imm) = %d", $time, alu_out);
        src1_reg = 16'd50; imm = 10'b1111110100; #10; // imm[6:0] = 110100 -> -12
        $display("Time=%0t: 50 + (-12) (imm) = %d", $time, alu_out);

        // 4. Test NAND (reg & reg)
        $display("\n--- Testing NAND (FUNC=01, MUX=0,0) ---");
        FUNC_alu = 2'b01; MUX_alu1 = 0; MUX_alu2 = 0;
        src1_reg = 16'hAAAA; src2_reg = 16'h5555; #10; // Should be all 1s
        $display("Time=%0t: 0xAAAA NAND 0x5555 = 0x%h", $time, alu_out);
        $display("Above output should be 0xffff");
        src1_reg = 16'hFFFF; src2_reg = 16'hFFFF; #10; // Should be all 0s
        $display("Time=%0t: 0xFFFF NAND 0xFFFF = 0x%h", $time, alu_out);
        $display("Above output should be 0x0000");

        // 5. Test PASS1 (src1_reg)
        $display("\n--- Testing PASS1 (FUNC=10, MUX=0,0) ---");
        FUNC_alu = 2'b10; MUX_alu1 = 0; MUX_alu2 = 0;
        src1_reg = 16'hBEEF; src2_reg = 16'hDEAD; #10;
        $display("Time=%0t: Pass src1_reg (0x%h) -> out=0x%h", $time, src1_reg, alu_out);

        // 6. Test LUI (PASS1 with left-shifted immediate)
        $display("\n--- Testing LUI (FUNC=10, MUX=1,0) ---");
        FUNC_alu = 2'b10; MUX_alu1 = 1; MUX_alu2 = 0;
        imm = 10'b1100110011; #10; // value << 6
        $display("Time=%0t: LUI with imm (0x%h) -> out=0x%h", $time, imm, alu_out);
        $display("Above output should be 0xccc0");
        // 7. Test EQL/BEQ (Equality check)
        $display("\n--- Testing EQL (FUNC=11, MUX=0,0) ---");
        FUNC_alu = 2'b11; MUX_alu1 = 0; MUX_alu2 = 0;
        src1_reg = 16'd1234; src2_reg = 16'd1234; #10; // Should be equal
        $display("Time=%0t: 1234 == 1234 -> EQ=%b, out=%d", $time, EQ, alu_out);
        src1_reg = 16'd1234; src2_reg = 16'd4321; #10; // Should not be equal
        $display("Time=%0t: 1234 == 4321 -> EQ=%b, out=%d", $time, EQ, alu_out);

        $display("\n--------------------------------------------------");
        $display("--- Testbench Finished ---");
        $display("--------------------------------------------------");
        #20;
        $finish;
    end

endmodule
