`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 11:55:34 AM
// Design Name: 
// Module Name: moore_vending
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module moore_vending (
    input wire clk,
    input wire reset,
    input wire [1:0] coin,  // 00=None, 01=5c, 10=10c
    output reg out
);

    // 1. Define states
    parameter S0  = 2'b00; // 0 cents
    parameter S5  = 2'b01; // 5 cents
    parameter S10 = 2'b10; // 10 cents
    parameter S15 = 2'b11; // 15 cents or more
    
    // 2. State registers
    reg [1:0] state, next_state;

    // 3. Sequential logic (State register)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // 4. Combinational logic (Next-state logic)
    always @(*) begin
        case (state)
            S0: begin
                if (coin == 2'b01)      
                    next_state = S5;
                else if (coin == 2'b10) 
                    next_state = S10;
                else                    
                    next_state = S0;
            end
            
            S5: begin
                if (coin == 2'b01)      
                    next_state = S10;
                else if (coin == 2'b10) 
                    next_state = S15;
                else                    
                    next_state = S5;
            end
            
            S10: begin
                if (coin == 2'b01)      
                    next_state = S15;
                else if (coin == 2'b10) 
                    next_state = S15;
                else                    
                    next_state = S10;
            end
            
            S15: begin
                // After dispensing, go back to S0 to wait for next customer
                next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
    
    // 5. Combinational logic (Output logic)
    always @(*) begin
        if (state == S15)
            out = 1;
        else
            out = 0;
    end

endmodule

