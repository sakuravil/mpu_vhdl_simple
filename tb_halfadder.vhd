LIBRARY ieee;									
USE ieee.std_logic_1164.ALL;
 
ENTITY test_halfadder IS
END test_halfadder;
 
ARCHITECTURE behavior OF test_halfadder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT halfadder
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         O : OUT  std_logic;
         CO : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';	--Ç±ÇÍÇ∆ÇªÇÃâ∫ÇÕèáÇ…é¿çsÇ≥ÇÍÇÈ	
   signal B : std_logic := '0';

 	--Outputs
   signal O : std_logic;
   signal CO : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: halfadder PORT MAP (
          A => A,
          B => B,
          O => O,
          CO => CO
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
      wait for 500 ns;	
		A <= '0';
		B <= '0';
		wait for 500 ns;
		A <= '0';
		B <= '1';
		wait for 500 ns;
		A <= '1';
		B <= '0';
		wait for 500 ns;
		A <= '1';
		B <= '1';
		wait for 500 ns;
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
