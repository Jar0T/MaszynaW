----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:20 10/28/2020 
-- Design Name: 
-- Module Name:    GenericMUX2to1 - Behavioral 
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

entity GenericMUX2to1 is
	Generic ( N : integer := 5 );
	Port (
		A : in  STD_LOGIC_VECTOR (N-1 downto 0);
		B : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Y : out  STD_LOGIC_VECTOR (N-1 downto 0);
		X : in  STD_LOGIC
	);
end GenericMUX2to1;

architecture Behavioral of GenericMUX2to1 is

begin
	process(A, B, X)
	begin
		case X is
			when '0' => Y <= A;
			when '1' => Y <= B;
			when others => Y <= (others => '0');
		end case;
	end process;

end Behavioral;

