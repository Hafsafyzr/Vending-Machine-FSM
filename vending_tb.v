`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2025 12:51:25 PM
// Design Name: 
// Module Name: vending_tb
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


module vending_tb;
    reg clk;
    reg reset;
    reg [1:0] coin;
    
    wire moore_out;
    wire mealy_out;

    moore_vending moore_inst (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .out(moore_out)
    );
    
    mealy_vending mealy_inst (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .out(mealy_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; 

    // Test sequence
    initial begin
        reset = 1;
        coin = 2'b00;
        #15; 
        
        reset = 0;
        #10;

        // Test Case 1: 5c + 10c = 15c
        $display("TEST 1: 5c + 10c");
        coin = 2'b01; 
        #10;
        coin = 2'b00; 
        #10;
        coin = 2'b10; 
        #10;
        coin = 2'b00; 
        #20; 
        
        // Test Case 2: 10c + 5c = 15c
        $display("TEST 2: 10c + 5c");
        coin = 2'b10; 
        #10;
        coin = 2'b00; 
        #10;
        coin = 2'b01; 
        #10;
        coin = 2'b00; 
        #20;

        // Test Case 3: 5c + 5c (no dispense)
        $display("TEST 3: 5c + 5c");
        coin = 2'b01; 
        #10;
        coin = 2'b00; 
        #10;
        coin = 2'b01; 
        #10;
        coin = 2'b00; 
        #10;

        // Test Case 4: (from 10c) + 10c = 20c
        $display("TEST 4: (from 10c) + 10c");
        coin = 2'b10; 
        #10;
        coin = 2'b00; 
        #20;

        // Test Case 5: 10c + reset
        $display("TEST 5: 10c + reset");
        coin = 2'b10; 
        #10;
        reset = 1;    
        #10;
        reset = 0;    
        coin = 2'b00;
        #10;
        
        // End simulation
        $display("Simulation finished.");
        $stop;
    end
    
    // Monitor
    initial begin
        $monitor("Time=%0t | clk=%b rst=%b | coin=%b | MOORE_out=%b | MEALY_out=%b",
                  $time, clk, reset, coin, moore_out, mealy_out);
    end

endmodule

