library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MPU is
	PORT( CLK			: in	std_logic;
			RESET			: in	std_logic;
			DATAINBUS	: in	std_logic_vector(7 downto 0);
			DATAOUTBUS	: out	std_logic_vector(7 downto 0);
			ADDRBUS		: out	std_logic_vector(11 downto 0);
			MEM_RD		: out	std_logic;
			MEM_WR		: out std_logic);
			
end MPU;

architecture Behavioral of MPU is

	COMPONENT MAR
	PORT(
		A : IN std_logic_vector(11 downto 0);
		LOAD : IN std_logic;
		RESET : IN std_logic;
		CLK : IN std_logic;          
		O : OUT std_logic_vector(11 downto 0)
		);
	END COMPONENT;

	COMPONENT Regiser
	PORT(
		A : IN std_logic_vector(7 downto 0);
		LOAD : IN std_logic;
		RESET : IN std_logic;
		CLK : IN std_logic;          
		O : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PC
	PORT(
		ADDR_IN : IN std_logic_vector(11 downto 0);
		LOAD : IN std_logic;
		RESET : IN std_logic;
		ENABLE : IN std_logic;
		CLK : IN std_logic;          
		ADDROUT : OUT std_logic_vector(11 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Operator
	PORT(
		A1 : IN std_logic;
		A0 : IN std_logic;
		D1 : IN std_logic;
		D0 : IN std_logic;
		B1 : IN std_logic;
		B0 : IN std_logic;
		S2 : IN std_logic;
		S1 : IN std_logic;
		S0 : IN std_logic;
		CIN : IN std_logic;
		H1 : IN std_logic;
		H0 : IN std_logic;
		OBUS : IN std_logic_vector(7 downto 0);
		CLK : IN std_logic;
		RESET : IN std_logic;          
		C : OUT std_logic;
		Z : OUT std_logic;
		ABUS : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Controller
	PORT(
		CLK : IN std_logic;
		RESET : IN std_logic;
		IR : IN std_logic_vector(7 downto 0);
		C : IN std_logic;
		Z : IN std_logic;          
		X0 : OUT std_logic;
		X1 : OUT std_logic;
		X2 : OUT std_logic;
		X3 : OUT std_logic;
		X4 : OUT std_logic;
		X5 : OUT std_logic;
		X6 : OUT std_logic;
		CTRL : OUT std_logic_vector(11 downto 0);
		MEM_RD : OUT std_logic;
		MEM_WR : OUT std_logic
		);
	END COMPONENT;
	
	signal ADDRTMP	: std_logic_vector(11 downto 0);
	signal PCOUT	: std_logic_vector(11 downto 0);
	signal MARLD	: std_logic;
	signal MARIN	: std_logic_vector(11 downto 0);
	signal DIN		: std_logic_vector(7 downto 0);
	signal DOUT		: std_logic_vector(7 downto 0);
	signal DLD		: std_logic;
	signal IROUT	: std_logic_vector(7 downto 0);
	signal OPOUT	: std_logic_vector(7 downto 0);
	signal X0		: std_logic;
	signal X1		: std_logic;
	signal X2		: std_logic;
	signal X3		: std_logic;
	signal X4		: std_logic;
	signal X5		: std_logic;
	signal X6		: std_logic;
	signal CTRL		: std_logic_vector(11 downto 0);
	signal Z			: std_logic;
	signal C			: std_logic;
begin
	
	ADDRTMP	<= IROUT(3 downto 0) & DOUT;
	
	MARIN 	<= PCOUT when(X1 = '0') else
					ADDRTMP;
	MARLD		<= X0 or X1;
	
	DIN		<= DATAINBUS when(X5 = '0') else
					OPOUT;
	DLD		<= X4 or X5; 
	
	DATAOUTBUS <= DOUT;
	
	PC: PC PORT MAP(
		ADDR_IN => ADDRTMP,
		LOAD => X3,
		RESET => RESET,
		ENABLE => X2,
		CLK => CLK,
		ADDROUT => PCOUT
	);
	
	MAR: MAR PORT MAP(
		A => MARIN,
		LOAD => MARLD,
		RESET => RESET,
		CLK => CLK,
		O => ADDRBUS
	);
	
	DRegiser: Regiser PORT MAP(
		A => DIN,
		LOAD => DLD,
		RESET => RESET,
		CLK => CLK,
		O => DOUT
	);
	
	IRRegiser: Regiser PORT MAP(
		A => DOUT,
		LOAD => X6,
		RESET => RESET,
		CLK => CLK,
		O => IROUT
	);

	Inst_Operator: Operator PORT MAP(
		A1 => CTRL(11),
		A0 => CTRL(10),
		D1 => CTRL(7),
		D0 => CTRL(6),
		B1 => CTRL(9),
		B0 => CTRL(8),
		S2 => CTRL(5),
		S1 => CTRL(4),
		S0 => CTRL(3),
		CIN => CTRL(2),
		H1 => CTRL(1),
		H0 => CTRL(0),
		OBUS => DOUT,
		CLK => CLK,
		RESET => RESET,
		C => C,
		Z => Z,
		ABUS => OPOUT
	);
	
	Inst_Controller: Controller PORT MAP(
		CLK => CLK,
		RESET => RESET,
		IR => IROUT,
		C => C,
		Z => Z,
		X0 => X0,
		X1 => X1,
		X2 => X2,
		X3 => X3,
		X4 => X4,
		X5 => X5,
		X6 => X6,
		CTRL => CTRL,
		MEM_RD => MEM_RD,
		MEM_WR => MEM_WR
	);
	

end Behavioral;

