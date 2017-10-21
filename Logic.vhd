library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Logic is
	
	PORT( A : in std_logic_vector(7 downto 0);
			B : in std_logic_vector(7 downto 0);
			S1 : in std_logic;
			S0 : in std_logic;
			F : out std_logic_vector(7 downto 0));
			
end Logic;

architecture Behavioral of Logic is
	
begin

	F <= A and B when(S1 = '0' and S0 = '0') else
		  A or B when(S1 = '0' and S0 = '1') else
		  A xor B when(S1 = '1' and S0 = '0') else
		  not A;	

end Behavioral;

