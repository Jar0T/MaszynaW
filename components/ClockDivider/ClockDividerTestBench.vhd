--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:04:47 10/28/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/ClockDivider/ClockDividerTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ClockDivider
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ClockDividerTestBench IS
END ClockDividerTestBench;
 
ARCHITECTURE behavior OF ClockDividerTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClockDivider
	 GENERIC (N : integer);
    PORT(
         fastClock : IN  std_logic;
         slowClock : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal fastClock : std_logic := '0';

 	--Outputs
   signal slowClock : std_logic;

   -- Clock period definitions
   constant fastClock_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClockDivider 
		GENERIC MAP ( N => 2 ) --should give 4 ns period on slowClock
		PORT MAP (
          fastClock => fastClock,
          slowClock => slowClock
        );

   -- Clock process definitions
   fastClock_process :process
   begin
		fastClock <= '0';
		wait for fastClock_period/2;
		fastClock <= '1';
		wait for fastClock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 

      wait;
   end process;

END;
