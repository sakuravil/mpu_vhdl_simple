library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rotate is
	PORT( G : in std_logic_vector(7 downto 0);
			H1 : in std_logic;
			H0 : in std_logic;
			F : out std_logic_vector(7 downto 0);
			SOUT : out std_logic);
			
end Rotate;

architecture Behavioral of Rotate is
	
begin
	F <= G when(H1 = '0' and H0 = '0') else
			G(0) & G(7 downto 1) when(H1 = '0' and H0 = '1') else
			G(6 downto 0) & G(7) when(H1 = '1' and H0 = '0') else
			"00000000";
	
	SOUT <= '0' when(H1 = '0' and H0 = '0') else
			  G(0) when(H1 = '0' and H0 = '1') else
			  G(7) when(H1 = '1' and H0 = '0') else
			  '0';
			  
end Behavioral;

