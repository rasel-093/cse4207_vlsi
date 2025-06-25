module Top_ALU_FSM (
    input wire clk, reset,
    output wire [5:0] result,
    output wire gt_zero_flag, // Flag indicating result > 0 or non-zero
    output wire SF,           // Sign Flag
    output wire CF,           // Carry Flag
    output wire ZF,           // Zero Flag
    output wire done
);
    // Internal wires for connecting FSM and ALU
    wire [5:0] a, b;
    wire [1:0] op;

    // Instantiate FSM_Controller
    FSM_Controller fsm (
        .clk(clk),
        .reset(reset),
        .result(result),           // Input from ALU
        .gt_zero_flag(gt_zero_flag), // Input from ALU
        .SF(SF),                   // Input from ALU
        .CF(CF),                   // Input from ALU
        .ZF(ZF),                   // Input from ALU
        .a(a),                     // Output to ALU
        .b(b),                     // Output to ALU
        .op(op),                   // Output to ALU
        .done(done)                // Output to top-level
    );

    // Instantiate ALU
    ALU alu_inst (
        .A(a),                     // From FSM
        .B(b),                     // From FSM
        .OP(op),                   // From FSM
        .R(result),                // To FSM and top-level output
        .GT_ZERO(gt_zero_flag),    // To FSM and top-level output
        .SF(SF),                   // To FSM and top-level output
        .CF(CF),                   // To FSM and top-level output
        .ZF(ZF)                    // To FSM and top-level output
    );

endmodule
