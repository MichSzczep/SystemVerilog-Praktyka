//testbench

`timescale 1ns/1ns

module Counter_4bit_tb;

 logic reset;
 logic CLK;
 logic chnge;
 logic [3:0] out;

 Counter_4bit TestCounter (	.CLK(CLK),
				.reset(reset),
				.chnge(chnge),
				.out(out) );

 initial 
  begin
   chnge <= 1;
   reset <= 0; 
   CLK <= 0;
   #60 chnge <= 0;
  end

 always 
  begin 
   CLK <= 0; #10;
   CLK <= 1; #10;
   //CLK <= 0; #10;
  end 

endmodule				

