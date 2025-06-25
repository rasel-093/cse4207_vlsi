module ALU (
    input wire [5:0] A, B,                   
    input wire [1:0] OP,    
    output reg [5:0] R,     
    output wire GT_ZERO,
    output wire SF,         // Sign Flag
    output wire CF,         // Carry Flag
    output wire ZF          // Zero Flag
);
    wire [5:0] R_XNOR_OR_AND, R_ROR;

    ALU_XNOR_OR_AND_6bit XNOR_OR_AND1 (.A(A), .B(B), .R(R_XNOR_OR_AND));
    ALU_ROR_6bit ROR1 (.A(A), .B(B), .R(R_ROR));

    always @(*) begin
        case (OP)
            2'b00: R = R_XNOR_OR_AND;
            2'b01: R = R_ROR;
            default: R = 6'b000000;
        endcase
    end

    // Flag assignments
    assign GT_ZERO = (|R);      // 1 if any bit in R is 1 (result > 0 or non-zero)
    assign SF = R[5];           // Sign flag: MSB of result
    assign CF = 1'b0;           // Carry flag: 0 (no arithmetic operation)
    assign ZF = ~(|R);          // Zero flag: 1 if result is all zeros
endmodule

module ALU_ROR_6bit (
    input wire [5:0] A, B,  
    output reg [5:0] R
);
    always @(*) begin
        case(B[2:0])  // Rotate right by B[2:0] positions
            3'b000: R = A;
            3'b001: R = {A[0], A[5:1]};
            3'b010: R = {A[1:0], A[5:2]};
            // ... (other cases)
            default: R = A;
        endcase
    end
endmodule

module ALU_XNOR_OR_AND_6bit (
    input wire [5:0] A, B,  
    output wire [5:0] R    
);
    assign R = (~(A ^ B)) | (A & B);
endmodule
