// Testbench for the Program Counter (pc) module
`timescale 1ns / 1ps

module pc_tb;

    // Inputs to the DUT (Device Under Test)
    reg clk;
    reg rst_n;
    reg [1:0] MUX_output;
    reg [6:0] imm; // Input is in 2's compliment, so MSB is the sign bit
    reg [15:0] alu_out;

    // Output from the DUT
    wire [15:0] nxt_instr;

    // Instantiate the Program Counter module
    pc uut (
        .clk(clk),
        .rst_n(rst_n),
        .MUX_output(MUX_output),
        .imm(imm),
        .alu_out(alu_out),
        .nxt_instr(nxt_instr)
    );

    // Clock generation: 100MHz clock (10ns period)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // 1. Initial state setup
        $display("T=%0t: [SETUP] Initializing testbench...", $time);
        clk = 0;
        rst_n = 1;
        MUX_output = 2'b00;
        imm = 7'b0;
        alu_out = 16'h0000;
        #10; // Wait for a moment

        // 2. Test Case: Asynchronous Reset
        $display("T=%0t: [TEST] Asserting active-low reset.", $time);
        rst_n = 0;
        #10; // Hold reset for a short period
        if (nxt_instr == 16'h0000) begin
            $display("T=%0t: [PASS] PC reset to 0x%h as expected.", $time, nxt_instr);
        end else begin
            $display("T=%0t: [FAIL] PC is 0x%h, expected 0x0000.", $time, nxt_instr);
        end
        #10;
        rst_n = 1; // De-assert reset
        $display("T=%0t: [SETUP] De-asserting reset.", $time);


        // 3. Test Case: Sequential Increment (MUX_output = 00)
        $display("\n T=%0t: [TEST] Testing sequential increment (MUX_output = 2'b00).", $time);
        MUX_output = 2'b00;
        @(posedge clk);
        #1;
        if (nxt_instr === 16'h0001) begin
            $display("T=%0t: [PASS] PC incremented to 0x%h.", $time, nxt_instr);
        end else begin
            $display("T=%0t: [FAIL] PC is 0x%h, expected 0x0001.", $time, nxt_instr);
        end
        
        @(posedge clk);
        #1;
        if (nxt_instr === 16'h0002) begin
            $display("T=%0t: [PASS] PC incremented to 0x%h.", $time, nxt_instr);
        end else begin
            $display("T=%0t: [FAIL] PC is 0x%h, expected 0x0002.", $time, nxt_instr);
        end


        // 4. Test Case: Branch with Immediate (MUX_output = 01)
        $display("\n T=%0t: [TEST] Testing branch with immediate (MUX_output = 2'b01).", $time);
        MUX_output = 2'b01;
        imm = 7'b0001110; // Adds 14
        // Set other inputs to different values to ensure they aren't selected
        alu_out = 16'hEEEE;
        @(posedge clk);
        #1;
        if (nxt_instr === 16'h0011) begin
            $display("T=%0t: [PASS] PC branched to immediate address 0x%h.", $time, nxt_instr);
        end else begin
            $display("T=%0t: [FAIL] PC is 0x%h, expected 0x0011.", $time, nxt_instr);
        end


        // 5. Test Case: Jump via ALU (MUX_output = 10)
        $display("\n T=%0t: [TEST] Testing jump via ALU output (MUX_output = 2'b10).", $time);
        MUX_output = 2'b10;
        alu_out = 16'hABCD;
        // Set other input to different values
        imm = 7'b1111110;
        @(posedge clk);
        #1;
        if (nxt_instr === 16'hABCD) begin
            $display("T=%0t: [PASS] PC jumped to ALU address 0x%h.", $time, nxt_instr);
        end else begin
            $display("T=%0t: [FAIL] PC is 0x%h, expected 0xABCD.", $time, nxt_instr);
        end
        
        // 6. Test Case: Back-to-back operations
        $display("\n T=%0t: [TEST] Testing mixed back-to-back operations.", $time);
        
        // a. Increment
        MUX_output = 2'b00;
        @(posedge clk);
        #1;
        $display("T=%0t: [INFO] Current PC: 0x%h (After increment)", $time, nxt_instr);

        // b. Jump
        MUX_output = 2'b10;
        alu_out = 16'hBEEF;
        @(posedge clk);
        #1;
        $display("T=%0t: [INFO] Current PC: 0x%h (After jump)", $time, nxt_instr);
        
        // c. Branch
        MUX_output = 2'b01;
        imm = 7'b0100110; // imm = 38. Jumps to BF15 + 1 = BF16
        @(posedge clk);
        #1;
        $display("T=%0t: [INFO] Current PC: 0x%h (After branch)", $time, nxt_instr);
        if (nxt_instr !== 16'hBF16) begin
            $display("T=%0t: [FAIL] Back-to-back sequence failed. PC is 0x%h, expected 0xBF16.", $time, nxt_instr);
        end else begin
             $display("T=%0t: [PASS] Back-to-back sequence successful.", $time);
        end

        // 7. Test Case: Undefined MUX select (2'b11)
        // Since the module's case statement does not define 2'b11, it should perform the default
        // of incrementing the PC
        $display("\n T=%0t: [TEST] Testing undefined MUX select (2'b11).", $time);
        MUX_output = 2'b11;
        imm = 7'b1010101; // Random Inputs to ensure they're ignored
        alu_out = 16'h000B;// Random Inputs to ensure they're ignored
        @(posedge clk);
        #1;
        if (nxt_instr === 16'hBF17) begin
             $display("T=%0t: [PASS] PC correctly incremented to PC+1 at 0x%h.", $time, nxt_instr);
        end else begin
             $display("T=%0t: [FAIL] PC changed to 0x%h, expected it to go to 16'hBF17.", $time, nxt_instr);
        end

        // 8. Test Case: Asynchronous Reset again
        $display("\n T=%0t: [TEST] Asserting active-low reset.", $time);
        rst_n = 0;
        #10; // Hold reset for a short period
        if (nxt_instr == 16'h0000) begin
            $display("T=%0t: [PASS] PC reset to 0x%h as expected.", $time, nxt_instr);
        end else begin
            $display("T=%0t: [FAIL] PC is 0x%h, expected 0x0000.", $time, nxt_instr);
        end
        #10;
        rst_n = 1; // De-assert reset
        $display("T=%0t: [SETUP] De-asserting reset.", $time);


        $display("\n T=%0t: [INFO] All tests completed.", $time);
        $finish; // End simulation
    end

    // Optional: Monitor to see signal changes at every time step
    // initial begin
    //     $monitor("T=%0t | clk=%b rst_n=%b | MUX_sel=%b | pc+1=%h pc+1+imm=%h alu_out=%h | nxt_instr_addr=%h",
    //         $time, clk, rst_n, MUX_output, pc_plus1, pc_plus1_imm, alu_out, nxt_instr);
    // end

endmodule
