`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2020 23:32:41
// Design Name: 
// Module Name: pin_tb
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


module pin_tb;

logic clk40;
logic pin_in, pin_out, clk600, clk600_90, clk300, str;
logic [2:0] ptime;

parameter okres = 1.67;
          
phase_locked_loop pll ( .CLK40(clk40),                      
                        .clk300(clk300),
                        .clk600(clk600),
                        .clk600_90(clk600_90) );  
                        
pin_capt des1 ( .pin_in(pin_in),
                .pin_out(pin_out),
                .clk600(clk600),
                .clk600_90(clk600_90),
                .clk300(clk300),
                .str(str),
                .ptime(ptime) );
   
initial 
begin : init_block
clk40 <= 0;
clk600 <= 0;
clk600_90 <= 0;
clk300 <= 0;
pin_in <= 0;

#1000 $finish;
end : init_block

initial 
begin : clk40_block
     forever #25 clk40 <= ~clk40;
end : clk40_block 

always
    begin : input_block
    #50 pin_in <= ~pin_in;
    end : input_block

endmodule
