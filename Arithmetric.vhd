library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ManoArithmetic is
	PORT( A : in std_logic_vector( 7 downto 0 );
			B : in std_logic_vector( 7 downto 0 );
			S0 : in std_logic;
			S1 : in std_logic;
			CIN : in std_logic;
			F : out std_logic_vector( 7 downto 0 );
			COUT : out std_logic);
			
end ManoArithmetic;

architecture Behavioral of ManoArithmetic is
	
	COMPONENT Obitfulladder
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		CIN : IN std_logic;          
		C : OUT std_logic;
		O : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	signal ST1 : std_logic_vector(7 downto 0);
	
begin

	ST1 <= "00000000" when(S1 = '0' and S0 = '0') else
			 B          when(S1 = '0' and S0 = '1') else
			 not B      when(S1 = '1' and S0 = '0') else
			 "11111111";
			 
	obitfulladder1: Obitfulladder PORT MAP(
		A => A,
		B => ST1,
		CIN => CIN,
		C => COUT,
		O => F
	);

end Behavioral;

