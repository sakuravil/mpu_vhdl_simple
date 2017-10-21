LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_Register IS
END tb_Register;
 
ARCHITECTURE behavior OF tb_Register IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Regiser
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         LOAD : IN  std_logic;
			RESET : IN std_logic;
         CLK : IN  std_logic;
         O : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal LOAD : std_logic := '0';
	signal RESET : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal O : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Regiser PORT MAP (
          A => A,
          LOAD => LOAD,
			 RESET => RESET,
          CLK => CLK,
          O => O
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
      wait for 100 ns;	

		RESET <= '1';
      wait for CLK_period*10;
		RESET <= '0';
		A <= "01010000";
		LOAD <= '1';
		wait for CLK_period*10;
		A <= "00001111";
		LOAD <= '0';
		wait for CLK_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
