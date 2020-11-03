----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:26:31 10/28/2020 
-- Design Name: 
-- Module Name:    ClockManager - Behavioral 
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

entity ClockManager is
	Port (
		fastClock : in  STD_LOGIC;
		slowClock : in  STD_LOGIC;
		Clock : out  STD_LOGIC;
		whichClock : in  STD_LOGIC;
		stop : in  STD_LOGIC
	);
end ClockManager;

architecture Behavioral of ClockManager is

begin
	process(fastClock, slowClock, whichClock, stop)
	begin
		if stop = '0' then
			case whichClock is
				when '0' => Clock <= fastClock;
				when '1' => Clock <= slowClock;
				when others => Clock <= '0';
			end case;
		end if;
	end process;

end Behavioral;

