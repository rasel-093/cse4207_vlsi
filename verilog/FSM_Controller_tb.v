`timescale 1ns/1ps
module FSM_Controller_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [5:0] result;
    reg gt_zero_flag;
    reg SF, CF, ZF;  // New flags
    
    // Outputs
    wire [5:0] a, b;
    wire [1:0] op;
    wire done;
    
    // Instantiate the FSM Controller
    FSM_Controller uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .gt_zero_flag(gt_zero_flag),
        .SF(SF),
        .CF(CF),
        .ZF(ZF),
        .a(a),
        .b(b),
        .op(op),
        .done(done)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        // Initialize and reset
        reset = 1;
        result = 6'b000000;
        gt_zero_flag = 0;
        SF = 0;
        CF = 0;
        ZF = 1;
        #20 reset = 0;
        
        // Simulate ALU outputs for state ONE
        #10;
        result = (~(6'b110011 ^ 6'b101010)) | (6'b110011 & 6'b101010); // XNOR OR AND
        gt_zero_flag = (|result);
        SF = result[5];
        CF = 0;
        ZF = ~(|result);
        
        // Simulate ALU outputs for state TWO
        #10;
        result = {6'b110011[0], 6'b110011[5:1]}; // ROR by 1
        gt_zero_flag = (|result);
        SF = result[5];
        CF = 0;
        ZF = ~(|result);
        
        // Simulate ALU outputs for state THREE
        #10;
        result = 6'b000000; // Zero result
        gt_zero_flag = 0;
        SF = 0;
        CF = 0;
        ZF = 1;
        
        // Wait for completion
        wait(done == 1);
        #10;
        
        // Verify state transitions
        $display("\nFSM State Transition Verification:");
        $display("State ONE:   A=%b, B=%b, OP=%b, Result=%b, GT_ZERO=%b, SF=%b, CF=%b, ZF=%b", 6'b110011, 6'b101010, 2'b00, result, gt_zero_flag, SF, CF, ZF);
        $display("State TWO:   A=%b, B=%b, OP=%b, Result=%b, GT_ZERO=%b, SF=%b, CF=%b, ZF=%b", 6'b110011, 6'b000001, 2'b01, result, gt_zero_flag, SF, CF, ZF);
        $display("State THREE: A=%b, B=%b, OP=%b (Zero Test), Result=%b, GT_ZERO=%b, SF=%b, CF=%b, ZF=%b", 6'b000000, 6'b000000, 2'b00, result, gt_zero_flag, SF, CF, ZF);
        
        $finish;
    end
    
    // Monitoring
    initial begin
        $monitor("Time=%0t State=%d → A=%b B=%b OP=%b Result=%b GT_ZERO=%b SF=%b CF=%b ZF=%b",
                $time, uut.current_state, a, b, op, result, gt_zero_flag, SF, CF, ZF);
    end

endmodule
