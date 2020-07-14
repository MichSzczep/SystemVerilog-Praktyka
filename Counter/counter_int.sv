// interface between DUT and TB


interface Counter_intface #(BIT_WIDTH);
  logic CLK, reset, chnge;
  logic [BIT_WIDTH-1:0] load, out;
endinterface
