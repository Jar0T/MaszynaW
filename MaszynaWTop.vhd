----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:43 10/29/2020 
-- Design Name: 
-- Module Name:    MaszynaWTop - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

entity MaszynaWTop is
	Port (
		Clk : in STD_LOGIC;
		Switch : in  STD_LOGIC_VECTOR (5 downto 0);
		DPSwitch : in  STD_LOGIC_VECTOR (7 downto 0);
		LED : out  STD_LOGIC_VECTOR (7 downto 0) := "00000000";
		SevenSegment : out STD_LOGIC_VECTOR(7 downto 0) := "00000010";
		Enable : out STD_LOGIC_VECTOR(2 downto 0) := "000"
	);
end MaszynaWTop;

architecture Behavioral of MaszynaWTop is

	component InstructionDecoder
	Port (
		Instruction : in  STD_LOGIC_VECTOR (2 downto 0);
		Clock : in  STD_LOGIC;
		LessThanZero : in  STD_LOGIC;
		EqualZero : in  STD_LOGIC;
		Programming : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		SteeringSignals : out  STD_LOGIC_VECTOR (15 downto 0)
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
	
	component GenericRegister
	Generic ( N : integer );
	Port (
		D : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Q : out  STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
		Clock : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		Load : in  STD_LOGIC
	);
	end component;
	
	component ArithmeticLogicUnit
	Port (
		A : in  STD_LOGIC_VECTOR (7 downto 0);
		B : in  STD_LOGIC_VECTOR (7 downto 0);
		Y : out  STD_LOGIC_VECTOR (7 downto 0);
		add : in  STD_LOGIC;
		sub : in  STD_LOGIC;
		load : in  STD_LOGIC
	);
	end component;
	
	component MyRAM
	Port (
		a : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		clk : IN STD_LOGIC;
		we : IN STD_LOGIC;
		spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	end component;
	
	component GenericMUX2to1
	Generic ( N : integer );
	Port (
		A : in  STD_LOGIC_VECTOR (N-1 downto 0);
		B : in  STD_LOGIC_VECTOR (N-1 downto 0);
		Y : out  STD_LOGIC_VECTOR (N-1 downto 0);
		X : in  STD_LOGIC
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
	
	component ClockDivider
	Generic ( N : integer );
	Port (
		fastClock : in  STD_LOGIC;
		slowClock : out  STD_LOGIC
	);
	end component;
	
	component ClockManager
	Port (
		fastClock : in  STD_LOGIC;
		slowClock : in  STD_LOGIC;
		Clock : out  STD_LOGIC;
		whichClock : in  STD_LOGIC;
		stop : in  STD_LOGIC
	);
	end component;
	
	
	component SevenSegmentDisplay
	Port (
		Clk : in STD_LOGIC;
		Binary : in  STD_LOGIC_VECTOR (7 downto 0);
		SevenSegment : out  STD_LOGIC_VECTOR (7 downto 0);
		Enable : out  STD_LOGIC_VECTOR (2 downto 0)
	);
	end component;
	
	
	
	signal pcin, pcout, ipc, iin, adout, add, sub, load, accin, accout, adin, rd, wr, win, wout, stp : STD_LOGIC := '0';
	signal addressBus : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal wordBus : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal slow : STD_LOGIC := '1';
	signal prog : STD_LOGIC := '0';
	signal slowClock, Clock, Clock_Pi : STD_LOGIC := '0';
	signal whichClock : STD_LOGIC := '0';
	signal ProgramCounterOutput : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal Address : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal Instruction : STD_LOGIC_VECTOR(2 downto 0) := "000";
	signal AccumulatorOut : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal ALUOut : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal AddressInput, AddressOutput : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal AddressLoad : STD_LOGIC := '0';
	signal RAMInput, RAMOutput : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal WordInput, WordOutput : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal WordLoad : STD_LOGIC := '0';
	signal Word : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal RAMwe : STD_LOGIC := '0';
	signal LessThanZero, EqualZero : STD_LOGIC := '0';

begin

	SevenSegmentD : SevenSegmentDisplay
	Port map (
		Clk => Clk,
		Binary => AccumulatorOut,
		SevenSegment => SevenSegment,
		Enable => Enable
	);

	ClockBuffer : BUFG
	Port map (
		I => Clock_Pi,
		O => Clock
	);

	ClockDivider0 : ClockDivider
	Generic map ( N => 6000000 )
	Port map (
		fastClock => Clk,
		slowClock => slowClock
	);
	
	ClockManager0 : ClockManager
	Port map (
		fastClock => Clk,
		slowClock => slowClock,
		Clock => Clock_Pi,
		whichClock => whichClock,
		stop => stp
	);
	
	ProgramCounter : GenericCounter
	Generic map ( N => 5 )
	Port map (
		D => addressBus,
		Q => ProgramCounterOutput,
		Clock => Clock,
		Enable => ipc,
		Load => pcin,
		Reset => not Switch(3)
	);
	
	InstructionRegister : GenericRegister
	Generic map ( N => 8 )
	Port map (
		D => wordBus,
		Q(7 downto 5) => Instruction,
		Q(4 downto 0) => Address,
		Clock => Clock,
		Reset => not Switch(3),
		Load => iin
	);
	
	InstructionDecoder0 : InstructionDecoder
	Port map (
		Instruction => Instruction,
		Clock => not Clock,
		LessThanZero => LessThanZero,
		EqualZero => EqualZero,
		Programming => prog,
		Reset => not Switch(3),
		SteeringSignals(15) => pcin,
		SteeringSignals(14) => pcout,
		SteeringSignals(13) => ipc,
		SteeringSignals(12) => iin,
		SteeringSignals(11) => adout,
		SteeringSignals(10) => add,
		SteeringSignals(9) => sub,
		SteeringSignals(8) => load,
		SteeringSignals(7) => accin,
		SteeringSignals(6) => accout,
		SteeringSignals(5) => adin,
		SteeringSignals(4) => rd,
		SteeringSignals(3) => wr,
		SteeringSignals(2) => win,
		SteeringSignals(1) => wout,
		SteeringSignals(0) => stp
	);
	
	ALU : ArithmeticLogicUnit
	Port map (
		A => wordBus,
		B => AccumulatorOut,
		Y => ALUOut,
		add => add,
		sub => sub,
		load => load
	);
	
	Accumulator : GenericRegister
	Generic map ( N => 8 )
	Port map (
		D => ALUOut,
		Q => AccumulatorOut,
		Clock => Clock,
		Reset => not Switch(3),
		Load => accin
	);
	
	AddressRegister : GenericRegister
	Generic map ( N => 5 )
	Port map (
		D => AddressInput,
		Q => AddressOutput,
		Clock => Clock,
		Reset => not Switch(3),
		Load => AddressLoad
	);
	
	RAM : MyRAM
	Port map (
		a => AddressOutput,
		d => RAMInput,
		clk => Clock,
		we => RAMwe,
		spo => RAMOutput
	);
	
	WordRegister : GenericRegister
	Generic map ( N => 8 )
	Port map (
		D => WordInput,
		Q => WordOutput,
		Clock => Clock,
		Reset => not Switch(3),
		Load => WordLoad
	);
	
	WordBusMUX : GenericMUX4to1
	Generic map ( N => 8 )
	Port map (
		A => "00000000",
		B => Word,
		C => AccumulatorOut,
		D => "00000000",
		Y => wordBus,
		X(1) => accout,
		X(0) => wout
	);
	
	AddressBusMUX : GenericMUX4to1
	Generic map ( N => 5 )
	Port map (
		A => "00000",
		B => ProgramCounterOutput,
		C => Address,
		D => "00000",
		Y => addressBus,
		X(1) => adout,
		X(0) => pcout
	);
	
	RAMWordMUX : GenericMUX4to1
	Generic map ( N => 8 )
	Port map (
		A => "00000000",
		B => WordOutput,
		C => "00000000",
		D => RAMOutput,
		Y => Word,
		X(1) => rd,
		X(0) => wout
	);
	
	WortInputMUX : GenericMUX4to1
	Generic map ( N => 8 )
	Port map (
		A => "00000000",
		B => wordBus,
		C => RAMOutput,
		D => "00000000",
		Y => WordInput,
		X(1) => rd,
		X(0) => win
	);
	
	WordEnableMUX : GenericMUX4to1
	Generic map ( N => 1 )
	Port map (
		A => "0",
		B => "1",
		C => "1",
		D => "0",
		Y(0) => WordLoad,
		X(1) => rd,
		X(0) => win
	);
	
	ClockManagerMUX : GenericMUX2to1
	Generic map ( N => 1 )
	Port map (
		A(0) => slow,
		B(0) => '1',
		Y(0) => whichClock,
		X => prog
	);
	
	AddressInMUX : GenericMUX2to1
	Generic map ( N => 5 )
	Port map (
		A => addressBus,
		B => not DPSwitch(4 downto 0),
		Y => AddressInput,
		X => prog
	);
	
	AddressLoadMUX : GenericMUX2to1
	Generic map ( N => 1 )
	Port map (
		A(0) => adin,
		B(0) => not Switch(5),
		Y(0) => AddressLoad,
		X => prog
	);
	
	RAMInMUX : GenericMUX2to1
	Generic map ( N => 8 )
	Port map (
		A => WordOutput,
		B => not DPSwitch,
		Y => RAMInput,
		X => prog
	);
	
	RAMLoadMUX : GenericMUX2to1
	Generic map ( N => 1 )
	Port map (
		A(0) => wr,
		B(0) => not Switch(4),
		Y(0) => RAMwe,
		X => prog
	);
	
	SlowRegister : GenericRegister
	Generic map ( N => 1 )
	Port map (
		D(0) => not Switch(0),
		Q(0) => slow,
		Clock => not Switch(2),
		Reset => '0',
		Load => '1'
	);
	
	ProgRegister : GenericRegister
	Generic map ( N => 1 )
	Port map (
		D(0) => not Switch(1),
		Q(0) => prog,
		Clock => not Switch(2),
		Reset => '0',
		Load => '1'
	);
	
	
	process(AccumulatorOut)
	begin
		LessThanZero <= AccumulatorOut(7);
		EqualZero <= not(AccumulatorOut(7) or
								AccumulatorOut(6) or
								AccumulatorOut(5) or
								AccumulatorOut(4) or
								AccumulatorOut(3) or
								AccumulatorOut(2) or
								AccumulatorOut(1) or
								AccumulatorOut(0));
	end process;
	
	process(wordBus)
	begin
		LED <= wordBus;
	end process;

end Behavioral;

