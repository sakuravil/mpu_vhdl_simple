library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use STD.TEXTIO.all; 

entity ram32 is
	port(
		clock 		: in	std_logic;
		we0			: in	std_logic;											-- write enable signal
		addr0			: in	std_logic_vector(11 downto 0);					-- 12bit address
		data_out0	: out	std_logic_vector(7 downto 0);			-- 8bit
		data_in0		: in	std_logic_vector(7 downto 0);
		
		SW				: in	std_logic_vector(3 downto 0);
		LED 			: out std_logic_vector(2 downto 0)
	);
end ram32;
architecture syn of ram32 is
	type RamType is array(0 to 1023) of std_logic_vector(7 downto 0);

	impure function InitRamFromFile (RamFileName : in string) return RamType is
		FILE RamFile         : text is in RamFileName;
		variable RamFileLine : line;
		variable RAM         : RamType;
--		variable lbuf :bit_vector(7 downto 0);
		begin
		for I in RamType'range loop
			readline (RamFile, RamFileLine);
			hread (RamFileLine, RAM(I));
--			RAM(I):=To_stdlogicvector(lbuf);
		end loop;
		return RAM;
	end function;
	signal RAM0 : RamType :=InitRamFromFile("memdata.dat");
	begin
	process (clock)
		begin
		if clock'event and clock = '1' then
			if(we0 = '1')then
--				RAM0(conv_integer(addr0))<=data_in0(31 downto 24) ;
				if(conv_integer(addr0) /= 16#10a#)then
					RAM0(conv_integer(addr0))<=data_in0 ;
				end if;
			end if;
--			data_out0(31 downto 24) <= RAM0(conv_integer(addr0));
			LED <= RAM0(16#100#)(2 downto 0);
			RAM0(16#10a#) <= "0000" & SW;
			data_out0 <= RAM0(conv_integer(addr0));
		end if;
	end process;
	
--	process (clock)
--		begin
--		if clock'event and clock = '1' then
--			if(we0(2)='1')then
--				RAM1(conv_integer(addr0))<=data_in0(23 downto 16) ;
--			end if;
--			data_out0(23 downto 16) <= RAM1(conv_integer(addr0));
--		end if;
--	end process;
--	
--	process (clock)
--		begin
--		if clock'event and clock = '1' then
--			if(we0(1)='1')then
--				RAM2(conv_integer(addr0))<=data_in0(15 downto 8) ;
--			end if;
--			data_out0(15 downto 8) <= RAM2(conv_integer(addr0));
--		end if;
--	end process;
--	
--	process (clock)
--		begin
--		if clock'event and clock = '1' then
--			if(we0(0)='1')then
--				RAM3(conv_integer(addr0))<=data_in0(7 downto 0) ;
--			end if;
--			data_out0(7 downto 0) <= RAM3(conv_integer(addr0));
--		end if;
--	end process;


end syn;
