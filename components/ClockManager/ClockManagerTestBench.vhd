--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:51:21 10/28/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/ClockManager/ClockManagerTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ClockManager
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
 
ENTITY ClockManagerTestBench IS
END ClockManagerTestBench;
 
ARCHITECTURE behavior OF ClockManagerTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClockManager
    PORT(
         fastClock : IN  std_logic;
         slowClock : IN  std_logic;
         Clock : OUT  std_logic;
         whichClock : IN  std_logic;
         stop : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal fastClock : std_logic := '0';
   signal slowClock : std_logic := '0';
   signal whichClock : std_logic := '0';
   signal stop : std_logic := '0';

 	--Outputs
   signal Clock : std_logic;

   -- Clock period definitions
   constant fastClock_period : time := 1 ns;
   constant slowClock_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClockManager PORT MAP (
          fastClock => fastClock,
          slowClock => slowClock,
          Clock => Clock,
          whichClock => whichClock,
          stop => stop
        );

   -- Clock process definitions
   fastClock_process :process
   begin
		fastClock <= '0';
		wait for fastClock_period/2;
		fastClock <= '1';
		wait for fastClock_period/2;
   end process;
 
   slowClock_process :process
   begin
		slowClock <= '0';
		wait for slowClock_period/2;
		slowClock <= '1';
		wait for slowClock_period/2;
   end process; 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		stop <= '1';
		wait for 4 ns;
		stop <= '0';
		wait for 4 ns;
		whichClock <= '1';
		wait for 4 ns;

      wait;
   end process;

END;
