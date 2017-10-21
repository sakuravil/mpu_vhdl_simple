library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Regiser is
	PORT( A : in std_logic_vector(7 downto 0);
			LOAD : in std_logic;
			RESET : in std_logic;
			CLK : in std_logic;
			O : out std_logic_vector(7 downto 0));
			
end Regiser;

architecture Behavioral of Regiser is

	signal STORE : std_logic_vector(7 downto 0);
	
begin

	O <= STORE;
	
	process(CLK,RESET) is
	begin
		if(RESET = '1') then
				STORE <= "00000000";
		end if;
		if(CLK'EVENT and CLK = '1') then
			
			if(LOAD = '1') then
				STORE <= A;
			end if;
		end if;
	end process;
	
end Behavioral;

