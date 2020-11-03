--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:41:20 10/29/2020
-- Design Name:   
-- Module Name:   E:/Users/Jarek/Xilinx/Projects/MaszynaW/components/InstructionDecoder/InstructionDecoderTestBench.vhd
-- Project Name:  MaszynaW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InstructionDecoder
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
 
ENTITY InstructionDecoderTestBench IS
END InstructionDecoderTestBench;
 
ARCHITECTURE behavior OF InstructionDecoderTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionDecoder
    PORT(
         Instruction : IN  std_logic_vector(2 downto 0);
         Clock : IN  std_logic;
         LessThanZero : IN  std_logic;
         EqualZero : IN  std_logic;
         Programming : IN  std_logic;
         Reset : IN  std_logic;
         SteeringSignals : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instruction : std_logic_vector(2 downto 0) := (others => '0');
   signal Clock : std_logic := '0';
   signal LessThanZero : std_logic := '0';
   signal EqualZero : std_logic := '0';
   signal Programming : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal SteeringSignals : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionDecoder PORT MAP (
          Instruction => Instruction,
          Clock => Clock,
          LessThanZero => LessThanZero,
          EqualZero => EqualZero,
          Programming => Programming,
          Reset => Reset,
          SteeringSignals => SteeringSignals
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
		Programming <= '1';
		wait for 1 ns;
		Programming <= '0';
		Instruction <= "000";
		wait for 4 ns;
		Instruction <= "001";
		wait for 4 ns;
		Instruction <= "010";
		wait for 4 ns;
		Instruction <= "011";
		wait for 4 ns;
		Instruction <= "100";
		wait for 4 ns;
		Instruction <= "101";
		wait for 4 ns;
		Instruction <= "110";
		LessThanZero <= '0';
		wait for 4 ns;
		Instruction <= "110";
		LessThanZero <= '1';
		wait for 4 ns;
		Instruction <= "111";
		EqualZero <= '0';
		wait for 4 ns;
		Instruction <= "111";
		EqualZero <= '1';
		wait for 4 ns;

      wait;
   end process;

END;
