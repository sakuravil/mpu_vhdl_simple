LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_Memory IS
END tb_Memory;
 
ARCHITECTURE behavior OF tb_Memory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Memory
    PORT(
         ADDR_IN : IN  std_logic_vector(11 downto 0);
         MEM_RD : IN  std_logic;
         MEM_WR : IN  std_logic;
         DATA_IN : IN  std_logic_vector(7 downto 0);
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADDR_IN : std_logic_vector(11 downto 0) := (others => '0');
   signal MEM_RD : std_logic := '0';
   signal MEM_WR : std_logic := '0';
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Memory PORT MAP (
          ADDR_IN => ADDR_IN,
          MEM_RD => MEM_RD,
          MEM_WR => MEM_WR,
          DATA_IN => DATA_IN,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		ADDR_IN <= "000000000000";
		wait for 100 ns;
		ADDR_IN <= "000000000001";
		wait for 100 ns;
		ADDR_IN <= "000000000010";
		wait for 100 ns;
		ADDR_IN <= "000000000011";
		wait for 100 ns;
		ADDR_IN <= "000000000100";
		wait for 100 ns;
		ADDR_IN <= "000010000000";
		wait for 100 ns;

      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
