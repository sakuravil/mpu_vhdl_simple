library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity CPU is
	PORT( CLK	: in	std_logic;
			RESET	: in	std_logic;
			
			SW		: in	std_logic_vector(3 downto 0);
			LED	: out	std_logic_vector(3 downto 0)
		 );
			
end CPU;

architecture Behavioral of CPU is
	COMPONENT MPU
	PORT(
		CLK : IN std_logic;
		RESET : IN std_logic;
		DATAINBUS : IN std_logic_vector(7 downto 0);          
		DATAOUTBUS : OUT std_logic_vector(7 downto 0);          
		ADDRBUS : OUT std_logic_vector(11 downto 0);
		MEM_RD : OUT std_logic;
		MEM_WR : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT ram32
	PORT(
		clock : IN std_logic;
		we0 : IN std_logic;
		addr0 : IN std_logic_vector(11 downto 0);
		data_in0 : IN std_logic_vector(7 downto 0);          
		data_out0 : OUT std_logic_vector(7 downto 0);
		SW				: in	std_logic_vector(3 downto 0);
		LED : out std_logic_vector(2 downto 0)

		);
	END COMPONENT;
	
	signal ADDRBUS	:	std_logic_vector(11 downto 0);
	signal DATAIN	:	std_logic_vector(7 downto 0);
	signal DATAOUT	:	std_logic_vector(7 downto 0);
	signal MEM_RD	:	std_logic;
	signal MEM_WR	:	std_logic;
	signal LEDBUS	:	std_logic_vector(2 downto 0);
	
begin

--	LED(0) <= CLK;
	LED(0) <= RESET;
--	LEDBUS <= LED(3) & LED(2);
	LED(1) <= LEDBUS(0);
	LED(2) <= LEDBUS(1);
	LED(3) <= LEDBUS(2);
	
	Inst_MPU: MPU PORT MAP(
		CLK => CLK,
		RESET => RESET,
		DATAINBUS => DATAIN,
		DATAOUTBUS => DATAOUT,
		ADDRBUS => ADDRBUS,
		MEM_RD => MEM_RD,
		MEM_WR => MEM_WR
	);
	
	Inst_ram32: ram32 PORT MAP(
		clock => CLK,
		we0 => MEM_WR,
		addr0 => ADDRBUS,
		data_out0 => DATAIN,
		data_in0 => DATAOUT,
		SW => SW,
		LED => LEDBUS
	);

end Behavioral;

