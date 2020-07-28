`timescale 1ns/1ps

module own_tb;

//Declaration of clock parameters
parameter CLK_600_PERIOD = 1.67;
parameter CLK_300_PERIOD = 2*CLK_600_PERIOD;
parameter CLK_40_HALF_PERIOD = 12.5; //Declared half period since division of 25 returned 12 instead of 12.5

//Place when the 6 10bits numbers from txt file will be held: 0,2,4 are times in ns when impuls comes and 1,3,5 are respectively durations of 0,2,4
logic [9:0] input_data_time [5:0];

logic clk40, clk600, clk600_90, clk300, pin_in, pin_out, str;
logic [2:0] ptime;

pin_capt des1 ( .clk600(clk600),
                .clk600_90(clk600_90),
                .clk300(clk300),
                .pin_in(pin_in),
                .pin_out(pin_out),
                .str(str),
                .ptime(ptime) );

/////////////////////////CLOCKS/////////////////////////
                    
 //Generating clock signal of frequency 600MHz                     
    initial 
    begin : clock_600MHz
    
        clk600 = 0;
        forever #(CLK_600_PERIOD/2) clk600 = ~clk600 ;
        
    end : clock_600MHz
    
    
    
    //Generating clock signal of frequency 600MHz phase shifted                    
    initial 
    begin : clock_600MHz_phase_shifted
    
        clk600_90 = 1;
        #(CLK_600_PERIOD/4) clk600_90 = 0;
        forever #(CLK_600_PERIOD/2) clk600_90 = ~clk600_90 ;
        
    end : clock_600MHz_phase_shifted
    
    
    
    //Generating clock signal of frequency 300MHz                     
    initial 
    begin : clock_300MHz
    
        clk300 = 0;
        #(CLK_600_PERIOD/2) clk300 = 1;
        forever #(CLK_300_PERIOD/2) clk300 = ~clk300;
        
    end : clock_300MHz
    
    
    //Generating clock signal of frequency 40MHz                     
    initial 
    begin : clock_40MHz
    
        clk40 = 0;
        #(CLK_40_HALF_PERIOD) clk300 = 1;
        forever #(CLK_40_HALF_PERIOD) clk300 = ~clk300;
        
    end : clock_40MHz
    
    
    integer help_time = 0;              //zmienna do pomocy przy wlasciwym wywolaniu pin_in=1
    
    initial 
    begin : input_pin
       $readmemb("C:/Users/wodzu/OneDrive/Pulpit/studia/prakyki/own_module/own_module.srcs/sources_1/inputs.txt", input_data_time);
       for (int i=0; i<6; i=i+2) begin : for_loop
               if (i==0) begin 
                help_time = input_data_time[i]+input_data_time[i+1];
                #input_data_time[i] pin_in = 1;             //czas rozpoczecia
                #input_data_time[i+1] pin_in = 0;           //czas trwania
               end
               else begin
                #(input_data_time[i] - help_time) pin_in=1;  //czas rozpoczecia
                #(input_data_time[i+1]) pin_in=0;                       //czas trwania
                help_time = input_data_time[i]+input_data_time[i+1];
               end
       end : for_loop
        
    end : input_pin 
    
    initial
    begin : initial_config
        pin_in<=0;
    end : initial_config


endmodule