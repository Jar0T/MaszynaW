--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:36:10 10/28/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/GenericRegister/GenericRegisterTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GenericRegister
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
 
ENTITY GenericRegisterTestBench IS
END GenericRegisterTestBench;
 
ARCHITECTURE behavior OF GenericRegisterTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GenericRegister
    PORT(
         D : IN  std_logic_vector(4 downto 0);
         Q : OUT  std_logic_vector(4 downto 0);
         Clock : IN  std_logic;
         Reset : IN  std_logic;
         Load : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(4 downto 0) := (others => '0');
   signal Clock : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Load : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GenericRegister PORT MAP (
          D => D,
          Q => Q,
          Clock => Clock,
          Reset => Reset,
          Load => Load
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      -- insert stimulus here 
		D <= "10101";
		wait for 1 ns;
		Load <= '1';
		Reset <= '1';
		wait for 1 ns;
		Reset <= '0';
		wait for 1 ns;
		Load <= '0';
		wait for 1 ns;
		Reset <= '1';
		wait for 1 ns;
		Reset <= '0';
		wait for 1 ns;
      wait;
   end process;

END;
