----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:15 10/28/2020 
-- Design Name: 
-- Module Name:    GenericMUX4to1 - Behavioral 
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

entity GenericMUX4to1 is
	Generic ( N : integer := 5 );
	Port (
		A : in  STD_LOGIC_VECTOR (N-1 downto 0);
		B : in  STD_LOGIC_VECTOR (N-1 downto 0);
		C : in  STD_LOGIC_VECTOR (N-1 downto 0);
		D : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Y : out  STD_LOGIC_VECTOR (N-1 downto 0);
		X : in  STD_LOGIC_VECTOR (1 downto 0)
	);
end GenericMUX4to1;

architecture Behavioral of GenericMUX4to1 is

begin
	process(A, B, C, D, X)
	begin
		case X is
			when "00" => Y <= A;
			when "01" => Y <= B;
			when "10" => Y <= C;
			when "11" => Y <= D;
			when others => Y <= (others => '0');
		end case;
	end process;

end Behavioral;

