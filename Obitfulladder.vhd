library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Obitfulladder is
	PORT (A : in std_logic_vector(7 downto 0);
			B : in std_logic_vector(7 downto 0);
			CIN : in std_logic;
			C : out std_logic;
			O : out std_logic_vector(7 downto 0));
			
end Obitfulladder;

architecture Behavioral of Obitfulladder is
	COMPONENT fulladder
	PORT(
		A : IN std_logic;
		B : IN std_logic;
		X : IN std_logic;          
		S : OUT std_logic;
		CO : OUT std_logic
		);
	END COMPONENT;
	
	--signal G : std_logic;
	signal S1 : std_logic;
	signal S2 : std_logic;
	signal S3 : std_logic;
	signal S4 : std_logic;
	signal S5 : std_logic;
	signal S6 : std_logic;
	signal S7 : std_logic;
	
begin

	--G <= '0';
	
	fulladder1: fulladder PORT MAP(
		A => A(0),
		B => B(0),
		X => CIN,
		S => O(0),
		CO => S1
	);
	fulladder2: fulladder PORT MAP(
		A => A(1),
		B => B(1),
		X => S1,
		S => O(1),
		CO => S2
	);
	fulladder3: fulladder PORT MAP(
		A => A(2),
		B => B(2),
		X => S2,
		S => O(2),
		CO => S3
	);
	fulladder4: fulladder PORT MAP(
		A => A(3),
		B => B(3),
		X => S3,
		S => O(3),
		CO => S4
	);
	fulladder5: fulladder PORT MAP(
		A => A(4),
		B => B(4),
		X => S4,
		S => O(4),
		CO => S5
	);
	fulladder6: fulladder PORT MAP(
		A => A(5),
		B => B(5),
		X => S5,
		S => O(5),
		CO => S6
	);
	fulladder7: fulladder PORT MAP(
		A => A(6),
		B => B(6),
		X => S6,
		S => O(6),
		CO => S7
	);
	fulladder8: fulladder PORT MAP(
		A => A(7),
		B => B(7),
		X => S7,
		S => O(7),
		CO => C
	);

end Behavioral;

