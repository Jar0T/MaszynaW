----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:40 10/29/2020 
-- Design Name: 
-- Module Name:    SevenSegmentDisplay - Behavioral 
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

entity SevenSegmentDisplay is
	Port (
		Clk : in STD_LOGIC;
		Binary : in  STD_LOGIC_VECTOR (7 downto 0);
		SevenSegment : out  STD_LOGIC_VECTOR (7 downto 0);
		Enable : out  STD_LOGIC_VECTOR (2 downto 0)
	);
end SevenSegmentDisplay;

architecture Behavioral of SevenSegmentDisplay is

	component BCD2SevenSegment
	Port (
		BCD : in  STD_LOGIC_VECTOR (3 downto 0);
		SevenSeg : out  STD_LOGIC_VECTOR (7 downto 0)
	);
	end component;
	
	component Binary2BCD
	Port (
		Binary : in  STD_LOGIC_VECTOR (7 downto 0);
		BCD : out  STD_LOGIC_VECTOR (11 downto 0)
	);
	end component;
	
	component ClockDivider
	Generic ( N : integer );			--1Hz 50% duty assuming 12MHz input
	Port (
		fastClock : in  STD_LOGIC;
		slowClock : out  STD_LOGIC
	);
	end component;
	
	component GenericCounter
	Generic ( N : integer );
	Port (
		D : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Q : out  STD_LOGIC_VECTOR (N-1 downto 0);
		Clock : in  STD_LOGIC;
		Enable : in  STD_LOGIC;
		Load : in  STD_LOGIC;
		Reset : in  STD_LOGIC
	);
	end component;
	
	component GenericMUX4to1
	Generic ( N : integer );
	Port (
		A : in  STD_LOGIC_VECTOR (N-1 downto 0);
		B : in  STD_LOGIC_VECTOR (N-1 downto 0);
		C : in  STD_LOGIC_VECTOR (N-1 downto 0);
		D : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Y : out  STD_LOGIC_VECTOR (N-1 downto 0);
		X : in  STD_LOGIC_VECTOR (1 downto 0)
	);
	end component;
	
	component DMUX1to4
	Port (
		X : in  STD_LOGIC_VECTOR (1 downto 0);
		Y : out  STD_LOGIC_VECTOR (3 downto 0)
	);
	end component;
	
	signal BCD : STD_LOGIC_VECTOR(11 downto 0) := "000000000000";
	signal SevenSeg0, SevenSeg1, SevenSeg2 : STD_LOGIC_VECTOR(7 downto 0);
	signal Clock : STD_LOGIC := '0';
	signal cnt : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal en : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

	Counter : GenericCounter
	Generic map ( N => 2 )
	Port map (
		D => "00",
		Q => cnt,
		Clock => Clock,
		Enable => '1',
		Load => '0',
		Reset => '0'
	);
	
	DMUX : DMUX1to4
	Port map (
		X => cnt,
		Y => en
	);
	
	MUX : GenericMUX4to1
	Generic map ( N => 8 )
	Port map (
		A => SevenSeg0,
		B => SevenSeg1,
		C => SevenSeg2,
		D => "11111111",
		Y => SevenSegment,
		X => cnt
	);

	CD : ClockDivider
	Generic map ( N => 1000 )
	Port map (
		fastClock => Clk,
		slowClock => Clock
	);

	Binary2BCD0 : Binary2BCD
	Port map (
		Binary => Binary,
		BCD => BCD
	);
	
	BCD2SevenSegment1 : BCD2SevenSegment
	Port map (
		BCD => BCD(3 downto 0),
		SevenSeg => SevenSeg0
	);
	
	BCD2SevenSegment10 : BCD2SevenSegment
	Port map (
		BCD => BCD(7 downto 4),
		SevenSeg => SevenSeg1
	);
	
	BCD2SevenSegment100 : BCD2SevenSegment
	Port map (
		BCD => BCD(11 downto 8),
		SevenSeg => SevenSeg2
	);
	
	process(en)
	begin
		Enable <= not en(2 downto 0);
	end process;


end Behavioral;

