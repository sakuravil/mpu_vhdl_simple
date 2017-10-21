----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:23:22 03/18/2014 
-- Design Name: 
-- Module Name:    fulladder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fulladder is
	PORT (A : in std_logic;
			B : in std_logic;
			X : in std_logic;
			S : out std_logic;
			CO : out std_logic);
end fulladder;

architecture Behavioral of fulladder is
    COMPONENT halfadder
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         O : OUT  std_logic;
         CO : OUT  std_logic
        );
    END COMPONENT;
	 
	 signal S1 : std_logic;
	 signal S2 : std_logic;
	 signal S3 : std_logic;
	 --signal S4 : std_logic;
	 --signal S5 : std_logic;
	 
begin
	
	halfadder1: halfadder PORT MAP (
          A => A,						--‚±‚±‚Æ‚»‚Ì‰º3‚Â‚Í“¯Žž‚ÉŽÀs‚³‚ê‚é
          B => B,
          O => S1,
          CO => S2
        );
	halfadder2: halfadder PORT MAP (
          A => S1,						--‚±‚±‚Æ‚»‚Ì‰º3‚Â‚Í“¯Žž‚ÉŽÀs‚³‚ê‚é
          B => X,
          O => S,
          CO => S3
        );
		  
	CO <= S2 or S3;
	
end Behavioral;

