// Module creating interface and passes it to design and TB

module top;

//create a parameter 
parameter BIT_WIDTH = 5;

// make an interface
Counter_intface #(.BIT_WIDTH(BIT_WIDTH)) cint();

// make a design and a testbench for a counter + give them intfaces & parameters
Counter_4bit #(.BIT_WIDTH(BIT_WIDTH)) d1 (cint);
Counter_4bit_tb #(.BIT_WIDTH(BIT_WIDTH)) tb1 (cint);

endmodule
