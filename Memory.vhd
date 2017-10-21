library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Memory is
	PORT( ADDR_IN	: in	std_logic_vector(11 downto 0);
			MEM_RD	: in	std_logic;
			MEM_WR	: in	std_logic;
			DATA_IN	: in	std_logic_vector(7 downto 0);
			DATA_OUT	: out	std_logic_vector(7 downto 0));
			
end Memory;

architecture Behavioral of Memory is
--	-- LD	0x80
--	-- JZ 6
--	-- INC A
	
--	signal LD0	: std_logic_vector(7 downto 0);
--	signal LD1	: std_logic_vector(7 downto 0);
--	signal JZ0	: std_logic_vector(7 downto 0);
--	signal JZ1	: std_logic_vector(7 downto 0);
--	signal INC	: std_logic_vector(7 downto 0);

--	signal INCA	: std_logic_vector(7 downto 0);
--	signal INCB	: std_logic_vector(7 downto 0);
--	signal ADD	: std_logic_vector(7 downto 0);
	-- INC A
	-- JP 0
	
	signal INCA	: std_logic_vector(7 downto 0);
	signal JP0	: std_logic_vector(7 downto 0);
	signal JP1	: std_logic_vector(7 downto 0);

begin

	INCA <= "10000000";
	JP0  <= "11010000";
	JP1  <= "00000000";
	
	DATA_OUT <= INCA		when(ADDR_IN = "000000000000") else
					JP0		when(ADDR_IN = "000000000001") else
					JP1		when(ADDR_IN = "000000000010");
	
--	INCA <= "10000000";
--	INCB <= "10000001";
--	ADD  <= "00110001";
--	
--	DATA_OUT <= INCA		when(ADDR_IN = "000000000000") else
--					INCB		when(ADDR_IN = "000000000001") else
--					ADD		when(ADDR_IN = "000000000010") else
--					"00000000";
--	LD0 <= "00000000";
--	LD1 <= "10000000";
--	JZ0 <= "11100000";
--	JZ1 <= "00000110";
--	INC <= "10000000";
--	
--	DATA_OUT <= LD0			when(ADDR_IN = "000000000000") else
--					LD1			when(ADDR_IN = "000000000001") else
--					JZ0			when(ADDR_IN = "000000000010") else
--					JZ1			when(ADDR_IN = "000000000011") else
--					INC			when(ADDR_IN = "000000000100") else
--					"00000000"	when(ADDR_IN = "000010000000");

end Behavioral;

