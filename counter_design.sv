//design

module Counter_4bit (Counter_intface cint);

				
 logic [3:0] load_temp;				//value used as a comparator
 bit flag = 0;

  initial begin
 	//do zagospodarowania
  end

  always_ff @(posedge cint.CLK) begin
    if (!flag) begin 
    	load_temp <= 0;
     	flag = 1;
    end 
    if (cint.reset)	begin
	cint.out <= 0;
    end 
    else begin
	if (cint.chnge)	
	 cint.out <= cint.out + 1;
	else
	 cint.out <= cint.out - 1;
    end
    if (cint.load != load_temp) begin
	cint.out <= cint.load;
	load_temp <= cint.load;
    end
  end
  
endmodule
  