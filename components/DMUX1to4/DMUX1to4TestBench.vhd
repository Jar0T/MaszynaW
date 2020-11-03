--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:19 10/29/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/DMUX1to4/DMUX1to4TestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DMUX1to4
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
 
ENTITY DMUX1to4TestBench IS
END DMUX1to4TestBench;
 
ARCHITECTURE behavior OF DMUX1to4TestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DMUX1to4
    PORT(
         X : IN  std_logic_vector(1 downto 0);
         Y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DMUX1to4 PORT MAP (
          X => X,
          Y => Y
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- insert stimulus here 
		X <= "00";
		wait for 1 ns;
		X <= "01";
		wait for 1 ns;
		X <= "10";
		wait for 1 ns;
		X <= "11";

      wait;
   end process;

END;
