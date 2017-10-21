library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ManoController is
	PORT( CLK		: in	std_logic;
			RESET		: in	std_logic;
			IR			: in	std_logic_vector(7 downto 0);
			C			: in	std_logic;
			Z			: in	std_logic;
			X0			: out	std_logic;
			X1			: out	std_logic;
			X2			: out	std_logic;
			X3			: out	std_logic;
			X4			: out	std_logic;
			X5			: out	std_logic;
			X6			: out	std_logic;
			CTRL		: out	std_logic_vector(11 downto 0);
			MEM_RD	: out	std_logic;
			MEM_WR	: out std_logic);
			
end Controller;

architecture Behavioral of Controller is
	
	type STATE is (M0, M0D, M1, M2, M3, M10, M11, M11D, M12, M13, M13D, M14, M15, M16, M16D, M17, M18, M19, M20, M20D, M21, M22, M23, M24,
						M25, M25D, M26, M27, M28, M29, M30, M30D, M31, M32, M33);
	
	signal IS_STATE	: STATE;
	signal NEXT_STATE	: STATE;
	signal CODE			: std_logic_vector(21 downto 0);
	signal V				: std_logic;		-- '1'
	signal G				: std_logic;		-- '0'
	signal DTMP			: std_logic_vector(1 downto 0);
	signal ATMP			: std_logic_vector(1 downto 0);
	
begin

	V <= '1';
	G <= '0';
	
	ATMP(1) <= G		when(CODE(14 downto 13) = "00") else
				  V		when(CODE(14 downto 13) = "01") else
				  IR(1)	when(CODE(14 downto 13) = "10") else
				  IR(3);
	ATMP(0) <= G		when(CODE(14 downto 13) = "00") else
			     V		when(CODE(14 downto 13) = "01") else
			     IR(0)	when(CODE(14 downto 13) = "10") else
			     IR(2);
	DTMP(1) <= G		when(CODE(12 downto 11) = "00") else
			     V		when(CODE(12 downto 11) = "01") else
			     IR(1)	when(CODE(12 downto 11) = "10") else
			     IR(3);
	DTMP(0) <= G		when(CODE(12 downto 11) = "00") else
			     V		when(CODE(12 downto 11) = "01") else
			     IR(0)	when(CODE(12 downto 11) = "10") else
			     IR(2);	
	
  X0 <= CODE(21);
	X1 <= CODE(20);
	X2 <= CODE(19);
	X3 <= CODE(18);
	X4 <= CODE(17);
	X5 <= CODE(16);
	X6 <= CODE(15);
	
	CTRL <= ATMP & IR(1 downto 0) & DTMP & CODE(10 downto 5);
	MEM_RD <= CODE(4);
	MEM_WR <= CODE(3);

	process(CLK, RESET) is
	begin
		if(CLK'EVENT and CLK = '1') then
			if(RESET = '1') then
				IS_STATE <= M0;
			else
				IS_STATE <= NEXT_STATE;
			end if;
		end if;
	end process;
	
	process(IR, C, Z, IS_STATE) is
	begin
		case IS_STATE is
		-- ********** MAR <- PC **********
			when M0	=>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M0D;
			when M0D =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M1;
		-- ********** D <- M[MAR], PC <- PC + 1 **********
			when M1	=>
				CODE <= "0010100000000000000000";
				NEXT_STATE <= M2;
		-- ********** IR <- D **********
			when M2	=>
				CODE <= "0000001000000000000000";
				NEXT_STATE <= M3;
		-- ********** jump **********
			when M3 =>
				CODE <= "0000000000000000000001";
				if(IR(7 downto 4) = "0011") then		-- ADD
					NEXT_STATE <= M10;
				elsif(IR(7 downto 4) = "0101") then -- AND
					NEXT_STATE <= M33;
				elsif(IR(7 downto 4) = "0000") then	-- LD
					NEXT_STATE <= M11;
				elsif(IR(7 downto 4) = "1110") then	-- JZ
					NEXT_STATE <= M16;
				elsif(IR(7 downto 4) = "1101") then -- JP
					NEXT_STATE <= M25;
				elsif(IR(7 downto 4) = "1111") then -- JC
					NEXT_STATE <= M30;
				elsif(IR(7 downto 4) = "1000") then	-- INC
					NEXT_STATE <= M19;
				elsif(IR(7 downto 4) = "1001") then	-- DEC
					NEXT_STATE <= M29;
				elsif(IR(7 downto 4) = "0001") then	-- ST
					NEXT_STATE <= M20;
				elsif(IR(7 downto 4) = "0010") then	-- MOV
					NEXT_STATE <= M28;
				else
					NEXT_STATE <= M0;
				end if;
		-- ********** ADD **********
			when M10	=>
				CODE <= "0000000111100100000001";
				NEXT_STATE <= M0;
		-- ********** AND **********
			when M33	=>
				CODE <= "0000000111110000000001";
				NEXT_STATE <= M0;
		-- ********** LD **********	
			when M11 =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M11D;
			when M11D =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M12;
			when M12 =>
				CODE <= "0010100000000000000000";
				NEXT_STATE <= M13;
			when M13 =>
				CODE <= "0100000000000000000000";
				NEXT_STATE <= M13D;
			when M13D =>
				CODE <= "0100000000000000000000";
				NEXT_STATE <= M14;
			when M14 =>
				CODE <= "0000100000000000000000";
				NEXT_STATE <= M15;
			when M15 =>
				CODE <= "0000000010000000000000";
				NEXT_STATE <= M0;
		-- ********** JZ **********
			when M16 =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M16D;
			when M16D =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M17;
			when M17 =>
				CODE <= "0010100000000000000000";
				if(Z = '1') then
					NEXT_STATE <= M18;
				else
					NEXT_STATE <= M0;
				end if;
			when M18 =>
				CODE <= "0001000000000000000001";
				NEXT_STATE <= M0;
		-- ********** JC **********
			when M30 =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M30D;
			when M30D =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M31;
			when M31 =>
				CODE <= "0010100000000000000000";
				if(C = '1') then
					NEXT_STATE <= M32;
				else
					NEXT_STATE <= M0;
				end if;
			when M32 =>
				CODE <= "0001000000000000000001";
				NEXT_STATE <= M0;
		-- ********** JP **********
			when M25 =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M25D;
			when M25D =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M26;
			when M26 =>
				CODE <= "0010100000000000000000";
				NEXT_STATE <= M27;
			when M27 =>
				CODE <= "0001000000000000000001";
				NEXT_STATE <= M0;
		-- ********** INC **********	
			when M19 =>
				CODE <= "0000000101000010000001";
				NEXT_STATE <= M0;
		-- ********** DEC **********	
			when M29 =>
				CODE <= "0000000101001100000001";
				NEXT_STATE <= M0;
		-- ********** ST **********
			when M20 =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M20D;
			when M20D =>
				CODE <= "1000000000000000000000";
				NEXT_STATE <= M21;
			when M21 =>
				CODE <= "0010100000000000000000";
				NEXT_STATE <= M22;
			when M22 =>
				CODE <= "0100000000000000000000";
				NEXT_STATE <= M23;
			when M23 =>
				CODE <= "0000010000000000000000";
				NEXT_STATE <= M24;
			when M24 =>
				CODE <= "0000000000000000001001";
				NEXT_STATE <= M0;
		-- ********** MOV **********	
			when M28 =>
				CODE <= "0000000101100000000001";
				NEXT_STATE <= M0;

		end case;
	end process;
	
end Behavioral;

