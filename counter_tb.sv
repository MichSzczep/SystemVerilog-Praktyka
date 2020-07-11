//testbench

`timescale 1ns/1ns

module Counter_4bit_tb ( Counter_intface cint );

 typedef enum logic [2:0] {A, B, C, D} TestCase;

 TestCase c1;

// inputs: 1. Reset is being set high or set low 2. When to start it
// output: changed reset bit 
task switch_reset (input bit on, input int del);				
	#del cint.reset <= on;
endtask

// inputs: 1. Chnge is being set high or set low 2. When to start it
// output: Chnge bit updated
task switch_change (input bit on, input int del);
	#del cint.chnge <= on;
endtask


// inputs: 1.Load value counter will start counting from, 2. When to start it
// output: counter starts counting using load value as a starting number 
task load_value (input logic [3:0] load, input int del);
	#del cint.load <= load;
endtask


 initial 
  begin : testing_obj
   cint.chnge <= 1;
   cint.reset <= 0; 
   cint.CLK <= 0;
   #10 cint.reset <= 1;
   #10 cint.reset <= 0;
   #30 cint.chnge <= 0;
   #10 cint.load <= 3;
   #20 cint.reset <=1 ;
   #100 cint.reset <= 0;
   #300 cint.load <= 11;

   #1000 $finish;
  end : testing_obj

 always 
  begin : clock_ticks
   cint.CLK <= 0; #10;
   cint.CLK <= 1; #10;
  end : clock_ticks

endmodule				

