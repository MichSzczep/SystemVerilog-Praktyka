`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2020 20:32:37
// Design Name: 
// Module Name: TDCCHAN_tb
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


module TDCCHAN_tb;

//Declaration of clock parameters
parameter CLK_600_PERIOD = 1.67;
parameter CLK_300_PERIOD = 2*CLK_600_PERIOD;

//Declaration of time bit width parameters
parameter BIT_TIME_WIDTH_1 = 0.4;
parameter BIT_TIME_WIDTH_2 = 5;
parameter BIT_TIME_WIDTH_3 = 15;

//Declaration of multiplacation factor of bit width
parameter BIT_TIME_WIDTH_FACTOR_1 = 1; //Bit width equals 0.418 ns
parameter BIT_TIME_WIDTH_FACTOR_2 = 10; //Bit width equals 4.175 ns
parameter BIT_TIME_WIDTH_FACTOR_3 = 20; //Bit width equals 8.350 ns

logic pin_in, pin_out, clk600, clk600_90, clk300, reset, tdcclk, rstr, rdata, tdc_rdy, tdc_raw_lock;
logic [3:0] tdc_count;
logic [6:0] bc_time;
logic [11:0] tdc_out;
logic [12:0] tdc_raw;

TDCCHAN_des dut (   .pin_in(pin_in),
                    .pin_out(pin_out),
                    .clk600(clk600),
                    .clk600_90(clk600_90),
                    .clk300(clk300),
                    .reset(reset),
                    .tdcclk(tdcclk),
                    .rstr(rstr),
                    .rdata(rdata),
                    .tdc_rdy(tdc_rdy),
                    .tdc_raw_lock(tdc_raw_lock) );
                    
 //tasks 
 task change_reset
                    
 //Generating clock signal of frequency 600MHz                     
    initial 
    begin : clock_600MHz
    
        clk600 = 0;
        forever #(CLK_600_PERIOD/2) clk600 = ~clk600 ;
        
    end : clock_600MHz
    
    //Generating clock signal of frequency 600MHz phase shifted                    
    initial 
    begin : clock_600MHz_phase_shifted
    
        clk600_90 = 1;
        #(CLK_600_PERIOD/4) clk600_90 = 0;
        forever #(CLK_600_PERIOD/2) clk600_90 = ~clk600_90 ;
        
    end : clock_600MHz_phase_shifted
    
    //Generating clock signal of frequency 300MHz                     
    initial 
    begin : clock_300MHz
    
        clk300 = 0;
        #(CLK_600_PERIOD/2) clk300 = 1;
        forever #(CLK_300_PERIOD/2) clk300 = ~clk300 ;
        
    end : clock_300MHz

endmodule
