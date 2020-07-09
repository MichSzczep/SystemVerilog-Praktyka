//design

module Counter_4bit (input logic CLK,
                     input logic reset,
		     input logic chnge,
                     output logic [3:0] out
                    );

  initial begin
   out <= 0;
  end

  always @(posedge CLK) begin
    if (reset)	begin
	out <= 0;
    end else begin	
	if (chnge)	
	 out <= out + 1;
	else
	 out <= out - 1;
    end
  end
  
endmodule
  