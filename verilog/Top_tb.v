module Top_ALU_FSM_tb;
    reg clk, reset;
    wire [5:0] result;
    wire gt_zero_flag, SF, CF, ZF, done;

    Top_ALU_FSM uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .gt_zero_flag(gt_zero_flag),
        .SF(SF),
        .CF(CF),
        .ZF(ZF),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #20 reset = 0;
        
        // Wait for FSM to complete
        wait(done == 1);
        #10;
        
        $finish;
    end

    // Monitoring
    initial begin
        $monitor("Time=%0t State=%d A=%b B=%b OP=%b => Result=%b GT_ZERO=%b SF=%b CF=%b ZF=%b",
            $time, uut.fsm.current_state, uut.fsm.a, uut.fsm.b, uut.fsm.op,
            result, gt_zero_flag, SF, CF, ZF);
    end
endmodule
