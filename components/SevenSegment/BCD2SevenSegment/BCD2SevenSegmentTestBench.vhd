--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:45:44 10/29/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/SevenSegment/BCD2SevenSegment/BCD2SevenSegmentTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BCD2SevenSegment
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
 
ENTITY BCD2SevenSegmentTestBench IS
END BCD2SevenSegmentTestBench;
 
ARCHITECTURE behavior OF BCD2SevenSegmentTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BCD2SevenSegment
    PORT(
         BCD : IN  std_logic_vector(3 downto 0);
         SevenSeg : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal BCD : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal SevenSeg : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BCD2SevenSegment PORT MAP (
          BCD => BCD,
          SevenSeg => SevenSeg
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		BCD <= "0000";
		wait for 1 ns;
		BCD <= "0001";
		wait for 1 ns;
		BCD <= "0010";
		wait for 1 ns;
		BCD <= "0011";
		wait for 1 ns;
		BCD <= "0100";
		wait for 1 ns;
		BCD <= "0101";
		wait for 1 ns;
		BCD <= "0110";
		wait for 1 ns;
		BCD <= "0111";
		wait for 1 ns;
		BCD <= "1000";
		wait for 1 ns;
		BCD <= "1001";
		wait for 1 ns;

      wait;
   end process;

END;
