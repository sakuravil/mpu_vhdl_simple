library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Operator is
	PORT( A1 : 		in std_logic;
			A0 : 		in std_logic;
			D1 : 		in std_logic;
			D0 : 		in std_logic;
			B1 : 		in std_logic;
			B0 : 		in std_logic;
			S2 : 		in std_logic;
			S1 : 		in std_logic;
			S0 : 		in std_logic;
			CIN :		in std_logic;
			H1 :		in std_logic;
			H0 :		in std_logic;
			OBUS :	in std_logic_vector(7 downto 0);
			CLK :		in std_logic;
			RESET :	in std_logic;
			C :		out std_logic;
			Z :		out std_logic;
			ABUS : 	out std_logic_vector(7 downto 0));
end Operator;

architecture Behavioral of Operator is

	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		S2 : IN std_logic;
		S1 : IN std_logic;
		S0 : IN std_logic;
		CIN : IN std_logic;
		H1 : IN std_logic;
		H0 : IN std_logic;          
		F : OUT std_logic_vector(7 downto 0);
		COUT : OUT std_logic;
		SOUT : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Regiser
	PORT(
		A : IN std_logic_vector(7 downto 0);
		LOAD : IN std_logic;
		RESET : IN std_logic;
		CLK : IN std_logic;          
		O : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	signal A : std_logic_vector(7 downto 0);		-- 4to1MUX -> ALU
	signal B : std_logic_vector(7 downto 0);		-- 4to1MUX -> ALU
	signal AR : std_logic_vector(7 downto 0);		-- Areg -> 4to1MUX
	signal BR : std_logic_vector(7 downto 0);		-- Breg -> 4to1MUX
	signal CR : std_logic_vector(7 downto 0);		-- Creg -> 4to1MUX
	signal F : std_logic_vector(7 downto 0);		-- ALU -> ABUS
	signal ALD : std_logic;
	signal BLD : std_logic;
	signal CLD : std_logic;
	signal COUT1 : std_logic;
	signal COUT2 : std_logic;
	
begin

	-- Register Load
	ALD <= '1' when D1 = '0' and D0 = '0' else '0';
	BLD <= '1' when D1 = '0' and D0 = '1' else '0';
	CLD <= '1' when D1 = '1' and D0 = '0' else '0';
	
	-- A register
	ARegister: Regiser PORT MAP(
		A => F,
		LOAD => ALD,
		RESET => RESET,
		CLK => CLK,
		O => AR
	);
	
	-- B register
	BRegister: Regiser PORT MAP(
		A => F,
		LOAD => BLD,
		RESET => RESET,
		CLK => CLK,
		O => BR
	);
	
	-- C register
	CRegister: Regiser PORT MAP(
		A => F,
		LOAD => CLD,
		RESET => RESET,
		CLK => CLK,
		O => CR
	);
	
	-- 4 to 1 MUX(A)
	A <= AR when(A1 = '0' and A0 = '0') else
		  BR when(A1 = '0' and A0 = '1') else
		  CR when(A1 = '1' and A0 = '0') else
		  OBUS;
	-- 4 to 1 MUX(B)
	B <= AR when(B1 = '0' and B0 = '0') else
		  BR when(B1 = '0' and B0 = '1') else
		  CR when(B1 = '1' and B0 = '0') else
		  OBUS;		  
	
	-- ALU
	Inst_ALU: ALU PORT MAP(
		A => A,
		B => B,
		S2 => S2,
		S1 => S1,
		S0 => S0,
		CIN => CIN,
		H1 => H1,
		H0 => H0,
		F => F,
		COUT => COUT1,
		SOUT => COUT2
	);
	
	C <= COUT1 or COUT2;
	Z <= '1' when(F = "00000000") else
		 '0';
	ABUS <= F;

end Behavioral;

