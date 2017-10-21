LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_Operator IS
END tb_Operator;
 
ARCHITECTURE behavior OF tb_Operator IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Operator
    PORT(
         A1 : IN  std_logic;
         A0 : IN  std_logic;
         D1 : IN  std_logic;
         D0 : IN  std_logic;
         B1 : IN  std_logic;
         B0 : IN  std_logic;
         S2 : IN  std_logic;
         S1 : IN  std_logic;
         S0 : IN  std_logic;
         CIN : IN  std_logic;
         H1 : IN  std_logic;
         H0 : IN  std_logic;
         OBUS : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         C : OUT  std_logic;
         Z : OUT  std_logic;
         ABUS : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A1 : std_logic := '0';
   signal A0 : std_logic := '0';
   signal D1 : std_logic := '0';
   signal D0 : std_logic := '0';
   signal B1 : std_logic := '0';
   signal B0 : std_logic := '0';
   signal S2 : std_logic := '0';
   signal S1 : std_logic := '0';
   signal S0 : std_logic := '0';
   signal CIN : std_logic := '0';
   signal H1 : std_logic := '0';
   signal H0 : std_logic := '0';
   signal OBUS : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal C : std_logic;
   signal Z : std_logic;
   signal ABUS : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Operator PORT MAP (
          A1 => A1,
          A0 => A0,
          D1 => D1,
          D0 => D0,
          B1 => B1,
          B0 => B0,
          S2 => S2,
          S1 => S1,
          S0 => S0,
          CIN => CIN,
          H1 => H1,
          H0 => H0,
          OBUS => OBUS,
          CLK => CLK,
          C => C,
          Z => Z,
          ABUS => ABUS
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for CLK_period * 5;	
		OBUS <= "00001000";
      A1 <= '1';
		A0 <= '1';
		B1 <= '0';
		B0 <= '0';
		D1 <= '0';
		D0 <= '1';
		S2 <= '0';
		S1 <= '0';
		S0 <= '0';
		CIN <= '0';
		H1 <= '0';
		H0 <= '0';

      wait for CLK_period * 5;	
		OBUS <= "00000011";
      A1 <= '1';
		A0 <= '1';
		B1 <= '0';
		B0 <= '0';
		D1 <= '1';
		D0 <= '0';
		S2 <= '0';
		S1 <= '0';
		S0 <= '0';
		CIN <= '0';
		H1 <= '0';
		H0 <= '0';		
      wait for CLK_period * 5;	
		OBUS <= "11000000";
      A1 <= '0';
		A0 <= '1';
		B1 <= '1';
		B0 <= '0';
		D1 <= '0';
		D0 <= '0';
		S2 <= '0';
		S1 <= '0';
		S0 <= '1';
		CIN <= '0';
		H1 <= '0';
		H0 <= '0';	
      wait for CLK_period * 5;	
		OBUS <= "11110000";
      A1 <= '0';
		A0 <= '0';
		B1 <= '1';
		B0 <= '0';
		D1 <= '0';
		D0 <= '1';
		S2 <= '0';
		S1 <= '0';
		S0 <= '0';
		CIN <= '0';
		H1 <= '0';
		H0 <= '0';	
      wait for CLK_period * 5;	
		OBUS <= "00110000";
      A1 <= '0';
		A0 <= '1';
		B1 <= '1';
		B0 <= '0';
		D1 <= '1';
		D0 <= '0';
		S2 <= '1';
		S1 <= '1';
		S0 <= '1';
		CIN <= '1';
		H1 <= '0';
		H0 <= '0';	
      -- insert stimulus here 

      wait;
   end process;

END;
