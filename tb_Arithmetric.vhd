LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_Arithmetic IS
END tb_Arithmetic;
 
ARCHITECTURE behavior OF tb_Arithmetic IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Arithmetic
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         S0 : IN  std_logic;
         S1 : IN  std_logic;
         CIN : IN  std_logic;
         F : OUT  std_logic_vector(7 downto 0);
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal S0 : std_logic := '0';
   signal S1 : std_logic := '0';
   signal CIN : std_logic := '0';

 	--Outputs
   signal F : std_logic_vector(7 downto 0);
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Arithmetic PORT MAP (
          A => A,
          B => B,
          S0 => S0,
          S1 => S1,
          CIN => CIN,
          F => F,
          COUT => COUT
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
		A <= "00001000";
		B <= "00000001";
		S0 <= '0';
		S1 <= '1';
		CIN <= '1';
		wait for 100 ns;
		
		S1 <= '0';
		S0 <= '0';
		CIN <= '0';
		wait for 100 ns;
		S1 <= '0';
		S0 <= '0';
		CIN <= '1';
		wait for 100 ns;
		S1 <= '0';
		S0 <= '1';
		CIN <= '0';
		wait for 100 ns;
		S1 <= '0';
		S0 <= '1';
		CIN <= '1';
		wait for 100 ns;
		S1 <= '1';
		S0 <= '0';
		CIN <= '0';
		wait for 100 ns;
		S1 <= '1';
		S0 <= '0';
		CIN <= '1';
		wait for 100 ns;
		S1 <= '1';
		S0 <= '1';
		CIN <= '0';
		wait for 100 ns;
		S1 <= '1';
		S0 <= '1';
		CIN <= '1';
		wait for 100 ns;
		
--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
