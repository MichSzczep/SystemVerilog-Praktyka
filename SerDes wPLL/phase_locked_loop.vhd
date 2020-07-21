library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity phase_locked_loop is
    Port ( CLK40 : in  STD_LOGIC; 
           clk600 : out  STD_LOGIC;
           clk600_90 : out  STD_LOGIC;
		   clk300 : out  STD_LOGIC );
end phase_locked_loop;

architecture Behaviour of phase_locked_loop is

begin

PLLE2_BASE_inst : PLLE2_BASE
   generic map (
      BANDWIDTH => "LOW",  -- OPTIMIZED, HIGH, LOW
      CLKFBOUT_MULT => 30,        -- Multiply value for all CLKOUT, (2-64)
      CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB, (-360.000-360.000).
      CLKIN1_PERIOD => 25.0,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
      CLKOUT0_DIVIDE => 2,
      CLKOUT1_DIVIDE => 2,
      CLKOUT2_DIVIDE => 4,          -- all multiplied by 15 (to get 600 from 40, but this one needs to be 300, so dividing by 2
      CLKOUT3_DIVIDE => 1,
      CLKOUT4_DIVIDE => 1,
      CLKOUT5_DIVIDE => 1,
      -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
      CLKOUT0_DUTY_CYCLE => 0.5,
      CLKOUT1_DUTY_CYCLE => 0.5,
      CLKOUT2_DUTY_CYCLE => 0.5,
      CLKOUT3_DUTY_CYCLE => 0.5,
      CLKOUT4_DUTY_CYCLE => 0.5,
      CLKOUT5_DUTY_CYCLE => 0.5,
      -- CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      CLKOUT0_PHASE => 0.0,
      CLKOUT1_PHASE => 90.0,
      CLKOUT2_PHASE => 0.0,
      CLKOUT3_PHASE => 0.0,
      CLKOUT4_PHASE => 0.0,
      CLKOUT5_PHASE => 0.0,
      DIVCLK_DIVIDE => 1,        -- Master division value, (1-56)
      REF_JITTER1 => 0.0,        -- Reference input jitter in UI, (0.000-0.999).
      STARTUP_WAIT => "FALSE"    -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
   )
   port map (
      -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
      CLKOUT0 => clk600,   -- 1-bit output: CLKOUT0
      CLKOUT1 => clk600_90,   -- 1-bit output: CLKOUT1
      CLKOUT2 => clk300,   -- 1-bit output: CLKOUT2
      CLKOUT3 => open,   -- 1-bit output: CLKOUT3
      CLKOUT4 => open,   -- 1-bit output: CLKOUT4
      CLKOUT5 => open,   -- 1-bit output: CLKOUT5
      -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
      CLKFBOUT => open, -- 1-bit output: Feedback clock
      LOCKED => open,     -- 1-bit output: LOCK
      CLKIN1 => CLK40,     -- 1-bit input: Input clock
      -- Control Ports: 1-bit (each) input: PLL control ports
      PWRDWN => '0',     -- 1-bit input: Power-down
      RST => '0',           -- 1-bit input: Reset
      -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
      CLKFBIN => '0'    -- 1-bit input: Feedback clock
   );

   -- End of PLLE2_BASE_inst instantiation
					

end Behaviour;