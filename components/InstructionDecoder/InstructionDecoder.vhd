----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:16:45 10/29/2020 
-- Design Name: 
-- Module Name:    InstructionDecoder - Behavioral 
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

entity InstructionDecoder is
	Port (
		Instruction : in  STD_LOGIC_VECTOR (2 downto 0);
		Clock : in  STD_LOGIC;
		LessThanZero : in  STD_LOGIC;
		EqualZero : in  STD_LOGIC;
		Programming : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		SteeringSignals : out  STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000"
	);
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is

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
	
	signal InstructionCounter : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal InstructionReset : STD_LOGIC := '0';
	signal CounterReset : STD_LOGIC := '0';

begin

	Counter : GenericCounter
	Generic map ( N => 2 )
	Port map (
		D => "00",
		Q => InstructionCounter,
		Clock => Clock,
		Enable => '1',
		Load => '0',
		Reset => CounterReset
	);

	process(Programming, Instruction, InstructionCounter, LessThanZero, EqualZero)
	begin
		if Programming = '1' then
			SteeringSignals <= "0000000000000000";
		else
			case Instruction is
				when "000" =>	--STP
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" => SteeringSignals <= "0000000000000001";
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "001" =>	--ADD
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" => SteeringSignals <= "0000100000100000";
						when "10" => SteeringSignals <= "0100010010110010";
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "010" =>	--SUB
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" => SteeringSignals <= "0000100000100000";
						when "10" => SteeringSignals <= "0100001010110010";
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "011" =>	--LD
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" => SteeringSignals <= "0000100000100000";
						when "10" => SteeringSignals <= "0100000110110010";
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "100" =>	--ST
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" => SteeringSignals <= "0000100001100100";
						when "10" => SteeringSignals <= "0100000000101000";
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "101" =>	--JA
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" => SteeringSignals <= "1000100000100000";
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "110" =>	--JLZ
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" =>
							case LessThanZero is
								when '0' => SteeringSignals <= "0100000000100000";
								when '1' => SteeringSignals <= "1000100000100000";
								when others => SteeringSignals <= "0000000000000000";
							end case;
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when "111" =>	--JEZ
					case InstructionCounter is
						when "00" => SteeringSignals <= "0011000000010010";
						when "01" =>
							case EqualZero is
								when '0' => SteeringSignals <= "0100000000100000";
								when '1' => SteeringSignals <= "1000100000100000";
								when others => SteeringSignals <= "0000000000000000";
							end case;
						when others => SteeringSignals <= "0000000000000000";
					end case;
				when others => SteeringSignals <= "0000000000000000";
			end case;
		end if;
	end process;
	
	process(Reset, InstructionReset)
	begin
		CounterReset <= Reset or InstructionReset;
	end process;

end Behavioral;

