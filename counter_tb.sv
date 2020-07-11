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

//These are 4 simple tasks checking tasks created above
task first;
	load_value(12, 10);
	switch_reset(1, 10);
	switch_change(1, 5);
endtask

task second;
	load_value(12, 10);
	switch_reset(1, 10);
	switch_change(1, 5);
endtask

task third;
	load_value(12, 10);
	switch_reset(1, 10);
	switch_change(1, 5);
endtask

task fourth;
	load_value(12, 10);
	switch_reset(1, 10);
	switch_change(1, 5);
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

   load_value(12,50);

   #1000 $finish;
  end : testing_obj


// Part of a code which is supposed to affect simulation a whole time, in my scenario it is only clock going high and low 
 always 
  begin : clock_ticks
   cint.CLK <= 0; #10;
   cint.CLK <= 1; #10;
  end : clock_ticks



endmodule				

