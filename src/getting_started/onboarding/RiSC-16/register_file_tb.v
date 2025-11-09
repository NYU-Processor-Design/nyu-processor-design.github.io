`timescale 1ns / 1ps

module register_file_tb;

    // Inputs
    reg clk;
    reg [1:0] MUX_tgt; // 00:mem_out      01:alu_out      10:pc+1
    reg MUX_rf; //        0:rC(ADD/NAND)  1:rA(SW/BEQ)
    reg WE_rf; //         0:SW/BEQ        1:ADD/ADDI/NAND/LUI/LW/JALR
    reg [15:0] mem_out, alu_out, pc, instruction;

    // Outputs
    wire [15:0] reg_out1, reg_out2;
    
    // Instantiate the Unit Under Test (UUT)
    register_file uut (
        .clk(clk),
        .MUX_tgt(MUX_tgt),
        .MUX_rf(MUX_rf),
        .WE_rf(WE_rf),
        .mem_out(mem_out),
        .alu_out(alu_out),
        .pc(pc),
        .instruction(instruction),
        .reg_out1(reg_out1),
        .reg_out2(reg_out2)
    );

    // --- Clock Generator ---
    initial begin
        clk = 0;
    end
    always begin
        #5 clk = ~clk;
    end

    // --- Verification Task ---
    task check_and_print_regs;
        input [15:0] exp_r0, exp_r1, exp_r2, exp_r3, exp_r4, exp_r5, exp_r6, exp_r7;
        reg [15:0] expected_regs [0:7];
        integer i;
        integer errors;

        begin
            expected_regs[0] = exp_r0; expected_regs[1] = exp_r1; expected_regs[2] = exp_r2;
            expected_regs[3] = exp_r3; expected_regs[4] = exp_r4; expected_regs[5] = exp_r5;
            expected_regs[6] = exp_r6; expected_regs[7] = exp_r7;

            errors = 0;
            $display("   -> Verifying all register values...");
            for (i = 0; i < 8; i = i + 1) begin
                if (uut.register_file[i] !== expected_regs[i]) begin
                    $display("      R%0d: Expected=%h, Actual=%h  <-- MISMATCH", i, expected_regs[i], uut.register_file[i]);
                    errors = errors + 1;
                end else begin
                    $display("      R%0d: Expected=%h, Actual=%h", i, expected_regs[i], uut.register_file[i]);
                end
            end

            if (errors == 0) $display(">> PASSED: All register values are correct.");
            else $display(">> FAILED: %0d register value(s) are incorrect.", errors);
        end
    endtask

    // --- Test Sequence ---
    initial begin
        $display("Starting Official RiSC-16 Register File Testbench...");
        
        // 1. Initialize all inputs.
        WE_rf <= 0; MUX_tgt <= 2'bxx; MUX_rf <= 1'bx; instruction <= 16'h0000;
        alu_out <= 16'h0000; mem_out <= 16'h0000; pc <= 16'h0000;
        @(posedge clk); @(posedge clk);

        // TEST 2: Check initial state (all zeros).
        $display("\n[TEST] Verifying initial register state...");
        @(posedge clk); @(posedge clk);
        check_and_print_regs(16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0);

        // TEST 3: LUI (op:011) write 0xE380 to R1.
        $display("\n[TEST] LUI writing 0xE380 to R1...");
        WE_rf <= 1; MUX_tgt <= 2'b01; MUX_rf <= 0; alu_out <= 16'hE380; // Assume ALU left shifts imm-10 by 6. MUX_rf val doesn't matter
        // instr: op=011, rA=R1, imm=10b1110001110 = 10'h38E: This value shifts to 1110001110_000000 = 16'hE380 = 58240
        instruction <= 16'b011_001_1110001110; 
        @(posedge clk); @(posedge clk);
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0, 16'h0);
        


        // TEST 4: ADDI (op:001) add 7'b1110001 to R1.
        $display("\n[TEST] ADDI adding 7'b1110001 to R1 and store in R3");
        WE_rf <= 1; MUX_tgt <= 2'b01; MUX_rf <= 1; // Assume ALU computes rB(R1) + imm. MUX_rf val doesn't matter
        // instr:     op=001, rA=R3, rB=R1, imm = 7'd113/7'h71
        instruction <= 16'b001_011_001_1110001;
        alu_out <= 16'hE3F1; // 16'hE380 + 7'h71 = 58240 + 113 = 58353 = 16'hE3F1
        @(posedge clk); @(posedge clk);

        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT] reg_out1 should be contents of rB/R1: 16'hE380");
        if(reg_out1 == 16'hE380) begin
            $display("\n[TEST PASSED]");
        end else begin
            $display("\n[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        // Check regs
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'hE3F1, 16'h0, 16'h0, 16'h0, 16'h0);



        // TEST 5: ADD (op:000) attempt to ADD to R0. SHOULD HAVE NO EFFECT
        $display("\n[TEST] ADD adding R1 and R3 to R0 (should have no effect)");
        WE_rf <= 1; MUX_tgt <= 2'b01; alu_out <= 16'hC771;
        MUX_rf <= 0; //MUX_rf chooses the output of rC for the second input
        // instr: op=000, rA=R0, rB=R1, rC=R3
        instruction <= 16'b000_000_001_0000_011;
        @(posedge clk);
        @(posedge clk);
        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT 1] reg_out1 should be contents of rB/R1: 16'hE380");
        if(reg_out1 == 16'hE380) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        // Check SRC2 is correct val
        $display("\n[TEST OUTPUT 2] reg_out2 should be contents of rC/R3: 16'hE3F1");
        if(reg_out2 == 16'hE3F1) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out2 contains %h", reg_out2);
        end
        check_and_print_regs(16'h0, 16'hE380, 16'h0000, 16'hE3F1, 16'h0, 16'h0, 16'h0, 16'h0);



        // TEST 6: NAND (op:010) R1 and R3, store in R5
        $display("\n[TEST] NAND R1 and R3, store in R5");
        WE_rf <= 1; MUX_tgt <= 2'b01; 
        MUX_rf <= 0; //MUX_rf chooses the output of rC for the second input
        // instr: op=010, rA=R5, rB=R1,   rC=R3
        instruction <= 16'b010_101_001_0000_011;
        alu_out <= ~(16'hE380 & 16'hE3F1); // Result is ~(16'hE380) = 16'h1C7F
        @(posedge clk); @(posedge clk);
        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT 1] reg_out1 should be contents of rB/R1: 16'hE380");
        if(reg_out1 == 16'hE380) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        // Check SRC2 is correct val
        $display("\n[TEST OUTPUT 2] reg_out2 should be contents of rC/R3: 16'hE3F1");
        if(reg_out2 == 16'hE3F1) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out2 contains %h", reg_out2);
        end
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'hE3F1, 16'h0, 16'h1C7F, 16'h0, 16'h0);
        


        // TEST 7: LW (op:100) write 0xBEEF from memory to R6 (dest:rA).
        $display("\n[TEST] LW writing 0xBEEF to R6...");
        WE_rf <= 1; MUX_tgt <= 2'b00; mem_out <= 16'hBEEF; //16'hBEEF is hypothetical val at mem loc [rB] + imm
        // instr: op=100, rA=R6, rB=R5
        instruction <= 16'b100_110_101_0001110; // Loads instruction from memory location [rB] + imm
        @(posedge clk); @(posedge clk);
        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT 1] reg_out1 should be contents of rB/R5: 16'h1C7F");
        if(reg_out1 == 16'h1C7F) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'hE3F1, 16'h0, 16'h1C7F, 16'hBEEF, 16'h0);




        // TEST 8: SW (op:101) Write Inhibit test. Should NOT change any registers.
        // reg_out1 should be the value in rB, reg_out2 should be the value in rA to be sent to memory
        $display("\n[TEST] SW Write Inhibit. Should not change registers...");
        MUX_rf <= 1; WE_rf <= 0; // For SW
        MUX_tgt <= 2'b00; //doesn't matter
        // instr: op=101, rA=R5 (source), rB=R3, Random imm val
        instruction <= 16'b101_101_011_0000111; // Storing [R5] in mem loc [R3] + imm
        @(posedge clk); @(posedge clk);
        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT 1] reg_out1 should be contents of rB/R3: 16'hE3F1");
        if(reg_out1 == 16'hE3F1) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        // Check SRC2 is correct val
        $display("\n[TEST OUTPUT 2] reg_out2 should be contents of rA/R5: 16'h1C7F");
        if(reg_out2 == 16'h1C7F) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out2 contains %h", reg_out2);
        end
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'hE3F1, 16'h0, 16'h1C7F, 16'hBEEF, 16'h0);



        // TEST 9: JALR (op:111) write PC+1 to R7 (dest:rA).
        // reg_out1 should be [rB]
        // pc+1 stored in rA
        $display("\n[TEST] JALR writing PC+1 (0xF00E) to R7...");
        WE_rf <= 1; MUX_tgt <= 2'b10; pc <= 16'hF00D;
        // instr: op=111, rA=R7, rB= R1
        instruction <= 16'b111_111_001_0000000;
        @(posedge clk); @(posedge clk);
        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT 1] reg_out1 should be contents of rB/R1: 16'hE380");
        if(reg_out1 == 16'hE380) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'hE3F1, 16'h0, 16'h1C7F, 16'hBEEF, 16'hF00E);



        // TEST 10: BEQ (op:110) Write Inhibit test. Should NOT change any registers.
        // reg_out1 should be [rA], reg_out2 should be [rB]
        $display("\n[TEST] BEQ Write Inhibit. Should not change registers...");
        MUX_tgt <= 2'b01; // Doesn't matter
        MUX_rf <= 1; //For BEQ
        WE_rf <= 0; // For BEQ
        // instr: op=110, rA=R1 (source), rB=R3 (source)
        instruction <= 16'b110_001_011_0000000;
        @(posedge clk); @(posedge clk);
        // Check SRC1 is correct val
        $display("\n[TEST OUTPUT 1] reg_out1 should be contents of rB/R3: 16'hE3F1");
        if(reg_out1 == 16'hE3F1) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out1 contains %h", reg_out1);
        end
        // Check SRC2 is correct val
        $display("\n[TEST OUTPUT 2] reg_out2 should be contents of rA/R1: 16'hE380");
        if(reg_out2 == 16'hE380) begin
            $display("[TEST PASSED]");
        end else begin
            $display("[TEST FAILED] reg_out2 contains %h", reg_out2);
        end
        check_and_print_regs(16'h0, 16'hE380, 16'h0, 16'hE3F1, 16'h0, 16'h1C7F, 16'hBEEF, 16'hF00E);



        #20;
        $display("\nAll tests completed.");
        $finish;
    end
endmodule

