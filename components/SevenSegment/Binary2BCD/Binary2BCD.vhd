----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:08 10/29/2020 
-- Design Name: 
-- Module Name:    Binary2BCD - Behavioral 
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

entity Binary2BCD is
	Port (
		Binary : in  STD_LOGIC_VECTOR (7 downto 0);
		BCD : out  STD_LOGIC_VECTOR (11 downto 0)
	);
end Binary2BCD;

architecture Behavioral of Binary2BCD is
	procedure add3 (
		signal bin: in  std_logic_vector (3 downto 0);
		signal bcd: out std_logic_vector (3 downto 0)
	) is
	variable is_gt_4:  std_logic;
	begin
		is_gt_4 := bin(3) or (bin(2) and (bin(1) or bin(0)));
		
		if is_gt_4 = '1' then	-- if to_integer(unsigned (bin)) > 4 then
			bcd <= std_logic_vector(unsigned(bin) + "0011");
		else
			bcd <= bin;
		end if;
	end procedure;
	
	signal U0bin,U1bin,U2bin,U3bin,U4bin,U5bin,U6bin : std_logic_vector (3 downto 0);
	signal U0bcd,U1bcd,U2bcd,U3bcd,U4bcd,U5bcd,U6bcd : std_logic_vector (3 downto 0); 

begin
	U0bin <= '0' & Binary (7 downto 5);
	U1bin <= U0bcd(2 downto 0) & Binary(4);
	U2bin <= U1bcd(2 downto 0) & Binary(3);
	U3bin <= U2bcd(2 downto 0) & Binary(2);
	U4bin <= U3bcd(2 downto 0) & Binary(1);
	U5bin <= '0' & U0bcd(3) & U1bcd(3) & U2bcd(3);
	U6bin <= U5bcd(2 downto 0) & U3bcd(3);
	
	U0: add3(U0bin,U0bcd);
	U1: add3(U1bin,U1bcd);
	U2: add3(U2bin,U2bcd);
	U3: add3(U3bin,U3bcd);
	U4: add3(U4bin,U4bcd);
	U5: add3(U5bin,U5bcd);
	U6: add3(U6bin,U6bcd);
	
	OUTP:
		bcd <= '0' & '0' & U5bcd(3) & U6bcd & U4bcd & Binary(0);

end Behavioral;

