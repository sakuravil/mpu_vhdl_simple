LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_Obitfulladder IS
END tb_Obitfulladder;
 
ARCHITECTURE behavior OF tb_Obitfulladder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Obitfulladder
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         C : OUT  std_logic;
         O : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal C : std_logic;
   signal O : std_logic_vector(7 downto 0);
	
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Obitfulladder PORT MAP (
          A => A,
          B => B,
          C => C,
          O => O
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
      wait for 500 ns;	
		A <= "00000001";
		B <= "00000000";
		wait for 500 ns;
		A <= "00001000";
		B <= "00001000";
		wait for 500 ns;
		A <= "10000000";
		B <= "10000001";
		wait for 500 ns;
      --wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
