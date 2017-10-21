library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity halfadder is
	port(A : in std_logic;
		  B : in std_logic;
		  O : out std_logic;
		  CO : out std_logic);
end halfadder;

architecture Behavioral of halfadder is
	signal C, D : std_logic;
begin
	
	C <= A or B;
	D <= A nand B;
	CO <= not D;
	O <= C and D;

end Behavioral;

