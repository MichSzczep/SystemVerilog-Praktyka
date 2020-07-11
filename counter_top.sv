// Module creating interface and passes it to design and TB

module boss;

Counter_intface cint();

Counter_4bit d1 (cint);
Counter_4bit_tb tb1 (cint);

endmodule
