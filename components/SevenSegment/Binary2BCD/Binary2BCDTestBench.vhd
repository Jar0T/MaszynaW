--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:51:25 10/29/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/SevenSegment/Binary2BCD/Binary2BCDTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Binary2BCD
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
USE ieee.numeric_std.ALL;
 
ENTITY Binary2BCDTestBench IS
END Binary2BCDTestBench;
 
ARCHITECTURE behavior OF Binary2BCDTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Binary2BCD
    PORT(
         Binary : IN  std_logic_vector(7 downto 0);
         BCD : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Binary : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal BCD : std_logic_vector(11 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Binary2BCD PORT MAP (
          Binary => Binary,
          BCD => BCD
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		for i in 0 to 255 loop
			Binary <= std_logic_vector(to_unsigned(i, 8));
			wait for 1 ns;
		end loop;
      wait;
   end process;

END;
