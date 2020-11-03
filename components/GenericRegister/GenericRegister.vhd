----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:51 10/28/2020 
-- Design Name: 
-- Module Name:    GenericRegister - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GenericRegister is
	Generic ( N : integer := 5 );
	Port (
		D : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Q : out  STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
		Clock : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		Load : in  STD_LOGIC
	);
end GenericRegister;

architecture Behavioral of GenericRegister is

begin
	process(Clock, Reset, Load)
	begin
		if Reset = '1' then
			Q <= (others => '0');
		elsif rising_edge(Clock) then
			if Load = '1' then
				Q <= D;
			else
				null;
			end if;
		else
			null;
		end if;
	end process;

end Behavioral;

