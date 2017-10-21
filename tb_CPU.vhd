LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_CPU IS
END tb_CPU;
 
ARCHITECTURE behavior OF tb_CPU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT( CLK	: in	std_logic;
			RESET	: in	std_logic;
			
			SW		: in	std_logic_vector(2 downto 0);
			LED	: out	std_logic_vector(3 downto 0)
		 );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
	signal SW : std_logic_vector(2 downto 0) := "000";
	signal LEDB : std_logic_vector(3 downto 0) := "0000";
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          CLK => CLK,
          RESET => RESET,
			 SW => SW,
			 LED => LEDB
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
      wait for CLK_period*100;

      -- insert stimulus here 
		
      wait;
   end process;

END;
