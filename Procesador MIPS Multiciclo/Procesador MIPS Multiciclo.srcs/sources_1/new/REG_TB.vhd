LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY P1A_TB IS
END P1A_TB;
 
ARCHITECTURE PRATICA_I OF P1A_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reg
    PORT(
         clk : IN  std_logic;
         ce : IN  std_logic;
         reset : IN  std_logic;
         d : IN  std_logic_vector(31 downto 0);
         q : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ce : std_logic := '0';
   signal reset : std_logic := '0';
   signal d : std_logic_vector(31 downto 0) := (others => '0');
	
	--Constants
	constant clk_period : time := 10 ns;
	
 	--Outputs
   signal q : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reg PORT MAP (
          clk => clk,
          ce => ce,
          reset => reset,
          d => d,
          q => q
        );
 
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	   -- hold reset state for 100ms.
      reset <='1';
		wait for 100 ns;
		assert Q=x"00000000" report "No funciona el reset" severity failure;

      reset <='0';
		ce <='1';
		d <=x"A86F3456";
		wait for clk_period;
		assert q=x"A86F3456" report "No funciona el registro" severity failure;

		reset <='0';
		ce <='0';
		d <=x"12345678";
		wait for clk_period;
		assert q=x"A86F3456" report "No funciona el clock enable" severity failure;

      wait;
   end process;

END PRATICA_I;
