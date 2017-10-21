library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
	PORT( A : in std_logic_vector(7 downto 0);
			B : in std_logic_vector(7 downto 0);
			S2 : in std_logic;
			S1 : in std_logic;
			S0 : in std_logic;
			CIN : in std_logic;
			H1 : in std_logic;
			H0 : in std_logic;
			F : out std_logic_vector(7 downto 0);
			COUT : out std_logic;
			SOUT : out std_logic);
			
end ALU;

architecture Behavioral of ALU is

	COMPONENT Arithmetic
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		S0 : IN std_logic;
		S1 : IN std_logic;
		CIN : IN std_logic;          
		F : OUT std_logic_vector(7 downto 0);
		COUT : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Logic
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		S1 : IN std_logic;
		S0 : IN std_logic;          
		F : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Rotate
	PORT(
		G : IN std_logic_vector(7 downto 0);
		H1 : IN std_logic;
		H0 : IN std_logic;          
		F : OUT std_logic_vector(7 downto 0);
		SOUT : OUT std_logic
		);
	END COMPONENT;
	--attribute KEEP : string;
	signal G1 : std_logic_vector(7 downto 0);
	signal G2 : std_logic_vector(7 downto 0);
	signal G3 : std_logic_vector(7 downto 0);
	--attribute KEEP of G2 : signal is "TRUE";
begin
	arithmetic: Arithmetic PORT MAP(
		A => A,
		B => B,
		S0 => S0,
		S1 => S1,
		CIN => CIN,
		F => G1,
		COUT => COUT
	);
	logic: Logic PORT MAP(
		A => A,
		B => B,
		S1 => S1,
		S0 => S0,
		F => G2
	);
	
	G3 <= G1 when(S2 = '0') else
			G2;
			
	rotate: Rotate PORT MAP(
		G => G3,
		H1 => H1,
		H0 => H0,
		F => F,
		SOUT => SOUT
	);
end Behavioral;

