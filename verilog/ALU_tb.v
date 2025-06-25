`timescale 1ns/1ps
module ALU_tb;

    // Inputs
    reg [5:0] A;
    reg [5:0] B;
    reg [1:0] OP;
    
    // Outputs
    wire [5:0] R;
    wire GT_ZERO;
    wire SF, CF, ZF;
    
    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .OP(OP),
        .R(R),
        .GT_ZERO(GT_ZERO),
        .SF(SF),
        .CF(CF),
        .ZF(ZF)
    );
    
    // Test cases
    initial begin
        // Test case 1: XNOR OR AND operation
        A = 6'b110011;
        B = 6'b101010;
        OP = 2'b00;
        #10;
        $display("Test 1: XNOR OR AND");
        $display("A=%b, B=%b → R=%b, GT_ZERO=%b, SF=%b, CF=%b, ZF=%b", A, B, R, GT_ZERO, SF, CF, ZF);
        
        // Test case 2: ROR operation
        A = 6'b110011;
        B = 6'b000001;
        OP = 2'b01;
        #10;
        $display("Test 2: ROR by 1");
        $display("A=%b, B=%b → R=%b, GT_ZERO=%b, SF=%b, CF=%b, ZF=%b", A, B, R, GT_ZERO, SF, CF, ZF);
        
        // Test case 3: Zero result case
        A = 6'b000000;
        B = 6'b000000;
        OP = 2'b00;
        #10;
        $display("Test 3: Zero Result");
        $display("A=%b, B=%b → R=%b, GT_ZERO=%b (Expected: 0), SF=%b, CF=%b, ZF=%b (Expected: 1)", A, B, R, GT_ZERO, SF, CF, ZF);
        if (GT_ZERO !== 0 || ZF !== 1)
            $error("Zero-flag test failed!");
        
        // Test case 4: Another ROR case
        A = 6'b101010;
        B = 6'b000010;
        OP = 2'b01;
        #10;
        $display("Test 4: ROR by 2");
        $display("A=%b, B=%b → R=%b, GT_ZERO=%b, SF=%b, CF=%b, ZF=%b", A, B, R, GT_ZERO, SF, CF, ZF);
        
        $finish;
    end

endmodule
