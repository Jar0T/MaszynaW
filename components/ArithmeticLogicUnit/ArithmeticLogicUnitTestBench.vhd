--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:56:21 10/28/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/ArithmeticLogicUnit/ArithmeticLogicUnitTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ArithmeticLogicUnit
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
 
ENTITY ArithmeticLogicUnitTestBench IS
END ArithmeticLogicUnitTestBench;
 
ARCHITECTURE behavior OF ArithmeticLogicUnitTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ArithmeticLogicUnit
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Y : OUT  std_logic_vector(7 downto 0);
         add : IN  std_logic;
         sub : IN  std_logic;
         load : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal add : std_logic := '0';
   signal sub : std_logic := '0';
   signal load : std_logic := '0';

 	--Outputs
   signal Y : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ArithmeticLogicUnit PORT MAP (
          A => A,
          B => B,
          Y => Y,
          add => add,
          sub => sub,
          load => load
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		A <= "00000111";
		B <= "00000101";
		add <= '1';
		wait for 2 ns;
		add <= '0';
		sub <= '1';
		wait for 2 ns;
		sub <= '0';
		load <= '1';
		wait for 2 ns;

      wait;
   end process;

END;
