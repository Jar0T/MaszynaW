----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:15 10/28/2020 
-- Design Name: 
-- Module Name:    ClockDivider - Behavioral 
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

entity ClockDivider is
	Generic ( N : integer := 6000000 );			--1Hz 50% duty assuming 12MHz input
	Port (
		fastClock : in  STD_LOGIC;
		slowClock : out  STD_LOGIC
	);
end ClockDivider;

architecture Behavioral of ClockDivider is

signal counter : integer range 0 to N-1 := 0;
signal clock : STD_LOGIC := '0';

begin
	process(fastClock)
	begin
		if falling_edge(fastClock) then
			if counter = N-1 then
				clock <= not clock;
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	process(clock)
	begin
		slowClock <= clock;
	end process;

end Behavioral;

