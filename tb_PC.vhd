LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_PC IS
END tb_PC;
 
ARCHITECTURE behavior OF tb_PC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         ADDR_IN : IN  std_logic_vector(7 downto 0);
         LOAD : IN  std_logic;
         RESET : IN  std_logic;
         ENABLE : IN  std_logic;
         CLK : IN  std_logic;
         ADDROUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADDR_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal LOAD : std_logic := '0';
   signal RESET : std_logic := '0';
   signal ENABLE : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal ADDROUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          ADDR_IN => ADDR_IN,
          LOAD => LOAD,
          RESET => RESET,
          ENABLE => ENABLE,
          CLK => CLK,
          ADDROUT => ADDROUT
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

		ADDR_IN <= "10000000";
		RESET <= '1';
		ENABLE <= '1';
		LOAD <= '0';
		wait for CLK_period;
		RESET <= '0';
		wait for CLK_period*9;
		ENABLE <= '0';
		LOAD <= '1';
		wait for CLK_period;
		ENABLE <= '1';
		LOAD <= '0';
		wait for CLK_period*9;
		RESET <= '1';
		wait for CLK_period;
      -- insert stimulus here 

      wait;
   end process;

END;
