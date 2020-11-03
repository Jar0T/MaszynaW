----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:36 10/29/2020 
-- Design Name: 
-- Module Name:    BCD2SevenSegment - Behavioral 
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

entity BCD2SevenSegment is
	Port (
		BCD : in  STD_LOGIC_VECTOR (3 downto 0);
		SevenSeg : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end BCD2SevenSegment;

architecture Behavioral of BCD2SevenSegment is

begin
	process(BCD)
	begin
		SevenSeg(7) <= not(BCD(1) or BCD(3) or ((not BCD(2)) and (not BCD(0))) or (BCD(2) and BCD(0)));
		SevenSeg(6) <= not((not BCD(2)) or ((not BCD(1)) and (not BCD(0))) or (BCD(1) and BCD(0)));
		SevenSeg(5) <= not((not BCD(1)) or BCD(0) or BCD(2));
		SevenSeg(4) <= not(BCD(3) or ((not BCD(2)) and (not BCD(0))) or ((not BCD(2)) and BCD(1)) or (BCD(1) and (not BCD(0))) or (BCD(2) and (not BCD(1)) and BCD(0)));
		SevenSeg(3) <= not(((not BCD(2)) and (not BCD(0))) or (BCD(1) and (not BCD(0))));
		SevenSeg(2) <= not(BCD(3) or ((not BCD(1)) and (not BCD(0))) or (BCD(2) and (not BCD(1))) or (BCD(2) and (not BCD(0))));
		SevenSeg(1) <= not(BCD(3) or ((not BCD(2)) and BCD(1)) or (BCD(1) and (not BCD(0))) or (BCD(2) and (not BCD(1))));
		SevenSeg(0) <= '1';
	end process;

end Behavioral;

