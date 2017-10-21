library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
	PORT( ADDR_IN : in std_logic_vector(11 downto 0);
			LOAD : in std_logic;
			RESET : in std_logic;
			ENABLE : in std_logic;
			CLK : in std_logic;
			ADDROUT : out std_logic_vector(11 downto 0));

end PC;

architecture Behavioral of PC is
	signal STORE : std_logic_vector(11 downto 0);
begin

	ADDROUT <= STORE;
	
	process(CLK, RESET) is
	begin

		if(CLK'EVENT and CLK = '1') then
			if(RESET = '1') then
				STORE <= "000000000000";
			elsif(LOAD = '1') then 
				STORE <= ADDR_IN;
			elsif(ENABLE = '1') then
				STORE <= STORE + 1;
			end if;
		end if;
	end process;
	

end Behavioral;

