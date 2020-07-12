//testbench

`timescale 1ns/1ns

module Counter_4bit_tb #(BIT_WIDTH) ( Counter_intface cint );

 typedef enum logic [2:0] {A, B, C, D} TestCase;

 TestCase c1;

// inputs: 1. Reset is being set high or set low 
// output: changed reset bit 
task switch_reset (input bit on);				
	#del cint.reset <= on;
endtask

// inputs: 1. Chnge is being set high or set low 
// output: Chnge bit updated
task switch_change (input bit on);
	#del cint.chnge <= on;
endtask


// inputs: 1.Load value counter will start counting from
// output: counter starts counting using load value as a starting number 
task load_value (input logic [3:0] load);
	#del cint.load <= load;
endtask

//These are 4 simple tasks checking tasks created above
task first;
	#10 load_value(12);
	#10 switch_reset(1);
	#5 switch_change(1);
endtask

task second;
	#10 load_value(12);
	#10 switch_reset(1);
	#5 switch_change(1);
endtask

task third;
	#10 load_value(12);
	#10 switch_reset(1);
	#5 switch_change(1);
endtask

task fourth;
	#10 load_value(12);
	#10 switch_reset(1);
	#5 switch_change(1);
endtask


//Initial part of a code: starting values
 initial 
  begin : testing_obj
   cint.chnge <= 1;
   cint.reset <= 0; 
   cint.CLK <= 0;

  /* case(c1)
        A: first;
	B: second;
	C: third;
	D: fourth;
   endcase */

   #50 load_value(100);
   #1000 $finish;
  end : testing_obj


// Part of a code which is supposed to affect simulation a whole time, in my scenario it is only clock going high and low 
 always 
  begin : clock_ticks
   cint.CLK <= 0; #10;
   cint.CLK <= 1; #10;
  end : clock_ticks



endmodule				

