//testbench

`timescale 1ns/1ns

module Counter_4bit_tb ( Counter_intface cint );



 initial 
  begin
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
  end

 always 
  begin
   cint.CLK <= 0; #10;
   cint.CLK <= 1; #10;
  end 

endmodule				

