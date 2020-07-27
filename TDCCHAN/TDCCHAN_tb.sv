`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2020 20:32:37
// Design Name: 
// Module Name: TDCCHAN_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 



module TDCCHAN_tb;

//Declaration of clock parameters
parameter CLK_600_PERIOD = 1.67;
parameter CLK_300_PERIOD = 2*CLK_600_PERIOD;
parameter CLK_40_HALF_PERIOD = 12.5; //Declared half period since division of 25 returned 12 instead of 12.5

//Declaration of time bit width parameters
parameter BIT_TIME_WIDTH_1 = 0.4;
parameter BIT_TIME_WIDTH_2 = 5;
parameter BIT_TIME_WIDTH_3 = 15;

//Declaration of multiplacation factor of bit width
parameter BIT_TIME_WIDTH_FACTOR_1 = 1; //Bit width equals 0.418 ns
parameter BIT_TIME_WIDTH_FACTOR_2 = 10; //Bit width equals 4.175 ns
parameter BIT_TIME_WIDTH_FACTOR_3 = 20; //Bit width equals 8.350 ns

//Declaration of tdc_clk time shift parameter in seconds
parameter TDCCLK_TIME_SHIFT = CLK_40_HALF_PERIOD*2*0.025;

logic pin_in, pin_out, clk600, clk600_90, clk300, reset, tdcclk, rstr, rdata, tdc_rdy, tdc_raw_lock;
logic [3:0] tdc_count;
logic [6:0] bc_time;
logic [11:0] tdc_out;
logic [12:0] tdc_raw;

TDCCHAN dut (   .pin_in (pin_in),
                .pin_out (pin_out),
                .clk600 (clk600),
                .clk600_90 (clk600_90),
                .clk300 (clk300),
                .reset (reset),
                .tdcclk (tdcclk),
                .rstr (rstr),
                .rdata (rdata),
                .tdc_count (tdc_count), 
                .bc_time (bc_time),
                .tdc_out (tdc_out),
                .tdc_rdy (tdc_rdy),
                .tdc_raw (tdc_raw),
                .tdc_raw_lock (tdc_raw_lock) );
                    
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
    
    
    
    //Generating clock signal of frequency 300MHz                     
    initial 
    begin : clock_tdc

        tdcclk = 0;
        #TDCCLK_TIME_SHIFT tdcclk = 0;
        #(CLK_600_PERIOD/2) tdcclk = 1;
        forever #(CLK_300_PERIOD/2) tdcclk = ~tdcclk;
        
    end : clock_tdc
   

/////////////////////////BC_TIME///////////////////////// 

    //Generating bc_time incrementing with frequency of 40MHz      
    initial 
    begin : time_bc
        
        bc_time = 0; 
        forever #(CLK_40_HALF_PERIOD*2) bc_time = bc_time + 1;
            
    end : time_bc






    //Quick tests
    initial 
    begin
        
        tdc_raw_lock = 0;
        forever #200 tdc_raw_lock = ~tdc_raw_lock;
            
    end
    
    initial 
    begin
        
        tdc_count = 0; 
        forever #30 tdc_count = tdc_count + 1;
            
    end    
        
    initial 
    begin
        
        rdata = 0 ;
        forever #100 rdata = ~rdata;
            
    end
    
    initial 
    begin
        
        rstr = 0 ;
        forever #125 rstr = ~rstr;
    end
        



////////////////////// task no. 1 ///////////////
// Sprzawdzam, czy tdc_rdy jest zależne od od pina wejściowego oraz tdc_raw_lock

task numero_uno;
begin : pin_rdy_task

#10 tdc_raw_lock = 1;
#10 pin_in = 1;
#20 pin_in = 0;
#10 tdc_raw_lock = 0;

end : pin_rdy_task
endtask

// I na pierwszy rzut oka wydaje się, że nie ma to wpływu


////////////////////// task no. 2 //////////////////
// Ten task sprawdza jak długo trwa "włączanie" rdy od momentu spełnienia warunku strobe

task numero_duo;
begin : str_to_rdy

    generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_3);
    generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_3);
    generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_3);
    generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_3);
    generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_3);
    
end : str_to_rdy
endtask

// i wygląda na to, że zajmuje to dwa zbocza: pierwsze w górę wprowadza wartość rstr do rs_1 oraz rs_1 do td_rdy1, a następnie 
// zbocze w dół wpisuje wartość tdc_rdy1 do tdc_rdy

//////////////////////task no.3 ///////////////////////////
// Sprawdza jaki wpływ na powyższe ma pin_in

task numero_tre;
begin : rdy_pinin

 generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_1);
 generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_1);
 generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_1);
 generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_1);
 generating_bits_pin_in(10,BIT_TIME_WIDTH_FACTOR_1);

end : rdy_pinin
endtask


/////////////////////////PIN_IN/////////////////////////    

//Task generating desired number of bits with width which is multiplicity of 0.418ns
    task generating_bits_pin_in(input integer number_of_bits, input integer bit_length);
    
        //First bit in first area
        #(12*CLK_600_PERIOD+CLK_600_PERIOD/8) pin_in = 1;
        #(4*bit_length*CLK_600_PERIOD/4) pin_in = 0;
        
        //Further bits in second, third, ..., seventh, zeroth, first, ... areas
        for(int i = 1; i < number_of_bits; i++)
        begin : loop_of_bits
            #(12*CLK_600_PERIOD+2*(CLK_600_PERIOD/8)) pin_in = 1;
            #(6*bit_length*CLK_600_PERIOD/4) pin_in = 0;
        end : loop_of_bits
        
    endtask
    
    

/////////////////////////Reset/////////////////////////    
    
    task toggle_reset();
        reset = ~reset;
    endtask
    

	

    
    initial
    begin : simulation
        
        pin_in = 0;
        reset = 0;
        rstr = 0;
        rdata = 0;
        tdc_count = 0;
        tdc_raw_lock = 0;
        
        numero_uno;
        numero_duo;
        numero_tre;
        
    end : simulation

endmodule
