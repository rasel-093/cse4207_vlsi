module FSM_Controller (
    input wire clk, reset,
    input wire [5:0] result,          
    input wire gt_zero_flag,           
    input wire SF, CF, ZF,            // New flags
    output reg [5:0] a, b,
    output reg [1:0] op,
    output reg done
);

    // State encoding
    parameter START  = 0;
    parameter ONE    = 1;
    parameter TWO    = 2;
    parameter THREE  = 3;
    parameter FINISH = 4;
    
    reg [2:0] current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) current_state <= START;
        else current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            START:  next_state = ONE;
            ONE:    next_state = TWO;
            TWO:    next_state = THREE;
            THREE:  next_state = FINISH;
            FINISH: next_state = FINISH;
            default: next_state = START;
        endcase
    end

    // Unique outputs for each state
    always @(*) begin
        case (current_state)
            START: begin 
                a = 6'b000000;  // Initialization values
                b = 6'b000000;
                op = 2'b00;
            end
            ONE: begin 
                a = 6'b110011;  
                b = 6'b101010;
                op = 2'b00;
            end
            TWO: begin 
                a = 6'b110011;  
                b = 6'b000001;
                op = 2'b01;
            end
            THREE: begin 
                a = 6'b000000;  
                b = 6'b000000;
                op = 2'b00;     
            end
            FINISH: begin 
                a = 6'b001100;  
                b = 6'b110011;
                op = 2'b00;
            end
        endcase
    end

    // Done signal
    always @(*) begin
        done = (current_state == FINISH);
    end

endmodule
