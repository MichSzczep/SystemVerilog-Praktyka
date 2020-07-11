//design

module Counter_4bit (Counter_intface cint);

				
 logic [3:0] load_temp;				//value used as a comparator
 bit flag = 0;

  initial begin
 	//do zagospodarowania
  end

  always_ff @(posedge cint.CLK) begin : counter_core
    if (!flag) begin : is_start					//this if is supposed to run once, just to "calibrate" load_temp value at a beginning 
    	load_temp <= 0;
     	flag = 1;
    end : is_start
    if (cint.reset)	begin : is_reset_high			//checking if reset is high, if so out value is 0...
	cint.out <= 0;
    end : is_reset_high
    else begin : is_reset_low					//if not, counter keeps counting up or down, depending on a chnge value
	if (cint.chnge)	
	 cint.out <= cint.out + 1;
	else
	 cint.out <= cint.out - 1;
    end : is_reset_low
    if (cint.load != load_temp) begin : new_load_value		//checking if counter gets a new load value, if not - it counts as before, if yes - changes current value to load and starts counting from it 
	cint.out <= cint.load;
	load_temp <= cint.load;
    end : new_load_value
  end : counter_core
  
endmodule
  