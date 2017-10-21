LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_fulladder IS
END test_fulladder;
 
ARCHITECTURE behavior OF test_fulladder IS 
 
    COMPONENT fulladder
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         X : IN  std_logic;
         S : OUT  std_logic;
         CO : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';
   signal X : std_logic := '0';

 	--Outputs
   signal S : std_logic;
   signal CO : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fulladder PORT MAP (
          A => A,
          B => B,
          X => X,
          S => S,
          CO => CO
        );

   -- Clock process definitions
   --<clock>_process :process
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
      wait for 500 ns;	
		A <= '0';
		B <= '0';
		X <= '0';
		wait for 500 ns;
		A <= '0';
		B <= '0';
		X <= '1';
		wait for 500 ns;
		A <= '0';
		B <= '1';
		X <= '0';
		wait for 500 ns;
		A <= '0';
		B <= '1';
		X <= '1';
      wait for 500 ns;	
		A <= '1';
		B <= '0';
		X <= '0';
		wait for 500 ns;
		A <= '1';
		B <= '0';
		X <= '1';
		wait for 500 ns;
		A <= '1';
		B <= '1';
		X <= '0';
		wait for 500 ns;
		A <= '1';
		B <= '1';
		X <= '1';
		wait for 500 ns;
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
