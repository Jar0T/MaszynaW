----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:04 10/28/2020 
-- Design Name: 
-- Module Name:    GenericCounter - Behavioral 
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

entity GenericCounter is
	Generic ( N : integer := 3 );
	Port (
		D : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Q : out  STD_LOGIC_VECTOR (N-1 downto 0);
		Clock : in  STD_LOGIC;
		Enable : in  STD_LOGIC;
		Load : in  STD_LOGIC;
		Reset : in  STD_LOGIC
	);
end GenericCounter;

architecture Behavioral of GenericCounter is

signal counter : unsigned(N-1 downto 0) := (others => '0');

begin
	process(Clock, Reset)
	begin
		if Reset = '1' then
			counter <= (others => '0');
		else
			if rising_edge(Clock) then
				if Load = '1' then
					counter <= unsigned(D);
				elsif Enable = '1' then
					counter <= counter + 1;
				else
					null;
				end if;
			else
				null;
			end if;
		end if;
	end process;
	
	process(counter)
	begin
		Q <= STD_LOGIC_VECTOR(counter);
	end process;

end Behavioral;

