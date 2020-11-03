----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:47:10 10/28/2020 
-- Design Name: 
-- Module Name:    ArithmeticLogicUnit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ArithmeticLogicUnit is
	Port (
		A : in  STD_LOGIC_VECTOR (7 downto 0);
		B : in  STD_LOGIC_VECTOR (7 downto 0);
		Y : out  STD_LOGIC_VECTOR (7 downto 0);
		add : in  STD_LOGIC;
		sub : in  STD_LOGIC;
		load : in  STD_LOGIC
	);
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is

begin
	process(A, B, add, sub, load)
	begin
		if add = '1' and sub = '0' and load = '0' then
			Y <= STD_LOGIC_VECTOR(signed(B) + signed(A));
		elsif add = '0' and sub = '1' and load = '0' then
			Y <= STD_LOGIC_VECTOR(signed(B) - signed(A));
		elsif add = '0' and sub = '0' and load = '1' then
			Y <= A;
		else
			Y <= "00000000";
		end if;
	end process;

end Behavioral;

