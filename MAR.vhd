library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAR is
	PORT( A : in std_logic_vector(11 downto 0);
			LOAD : in std_logic;
			RESET : in std_logic;
			CLK : in std_logic;
			O : out std_logic_vector(11 downto 0));
end MAR;

architecture Behavioral of MAR is
	signal STORE : std_logic_vector(11 downto 0);
	
begin

	O <= STORE;
	
	process(CLK) is
	begin
		if(CLK'EVENT and CLK = '1') then
			if(LOAD = '1') then
				STORE <= A;
			elsif(RESET = '1') then
				STORE <= "000000000000";
			end if;
		end if;
	end process;

end Behavioral;

