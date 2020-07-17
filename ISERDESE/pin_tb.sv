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

logic pin_in, pin_out, clk600, clk600_90, clk300, str;
logic [2:0] ptime;

parameter okres = 1.67;
   
pin_capt des1 ( .pin_in(pin_in),
                .pin_out(pin_out),
                .clk600(clk600),
                .clk600_90(clk600_90),
                .clk300(clk300),
                .str(str),
                .ptime(ptime) );
            
   
initial 
begin : init_block
clk600 <= 0;
clk600_90 <= 0;
clk300 <= 0;
pin_in <= 0;

/*
for (int i=0; i<10; i++) begin : for_loop
#50 pin_in <= ~pin_in;
end : for_loop
*/

#1000 $finish;
end : init_block

    initial begin : clk600_block
     forever #(okres/2) clk600 <= ~clk600 ;
    end : clk600_block
    
    initial begin : clk90_block
     #(okres/4);
     forever #(okres/2) clk600_90 <= ~clk600_90 ;
    end : clk90_block
    
    initial begin : clk300_block
     forever #okres clk300 <= ~clk300 ;
    end : clk300_block
    
    always
    begin : input_block
    #0.4 pin_in = $urandom_range(0, 1);
    end : input_block

endmodule
