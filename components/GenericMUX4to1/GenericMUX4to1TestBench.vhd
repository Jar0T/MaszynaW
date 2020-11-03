--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:55:35 10/28/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/GenericMUX4to1/GenericMUX4to1TestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GenericMUX4to1
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
 
ENTITY GenericMUX4to1TestBench IS
END GenericMUX4to1TestBench;
 
ARCHITECTURE behavior OF GenericMUX4to1TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GenericMUX4to1
    PORT(
         A : IN  std_logic_vector(4 downto 0);
         B : IN  std_logic_vector(4 downto 0);
         C : IN  std_logic_vector(4 downto 0);
         D : IN  std_logic_vector(4 downto 0);
         Y : OUT  std_logic_vector(4 downto 0);
         X : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(4 downto 0) := (others => '0');
   signal B : std_logic_vector(4 downto 0) := (others => '0');
   signal C : std_logic_vector(4 downto 0) := (others => '0');
   signal D : std_logic_vector(4 downto 0) := (others => '0');
   signal X : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(4 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GenericMUX4to1 PORT MAP (
          A => A,
          B => B,
          C => C,
          D => D,
          Y => Y,
          X => X
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		A <= "10101";
		B <= "01010";
		C <= "11011";
		D <= "00100";
		X <= "00";
		wait for 1 ns;
		
		X <= "01";
		wait for 1 ns;
		
		X <= "10";
		wait for 1 ns;
		
		X <= "11";
		wait for 1 ns;

      wait;
   end process;

END;
