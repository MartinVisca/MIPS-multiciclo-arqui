
library ieee;
use ieee.std_logic_1164.all;

entity P1C_TB is
end P1C_TB;


architecture PRACTICA_I of P1C_TB is
	-- Component declaration of the tested unit
	component shift
	port(
		d : in std_logic_vector(31 downto 0);
		dir : in std_logic;
		load : in std_logic;
		clk : in std_logic;
		reset : in std_logic;
		q : out std_logic_vector(31 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal d : std_logic_vector(31 downto 0);
	signal dir : std_logic;
	signal load : std_logic;
	signal clk : std_logic;
	signal reset : std_logic;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : std_logic_vector(31 downto 0);  
	
	signal end_sim : boolean := false;

	constant clk_period: time := 10 ns;	 
	
	constant zeros31: std_logic_vector(30 downto 0) := (others => '0');

begin

	-- Unit Under Test port map
	UUT : shift
		port map (
			d => d,
			dir => dir,
			load => load,
			clk => clk,
			reset => reset,
			q => q
		);

	process begin
		while not end_sim loop
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		end loop;
		
		wait;
	end process;			   
	

	process
	begin
		reset <= '0';
		d <= x"00000001";
		load <= '1';
		dir <= '0'; -- desplazamiento a izquierda
		
		-- Prueba de LOAD
		wait for clk_period;
	   assert q = x"00000001" report "No funcionó el LOAD." severity failure; 				
		
		-- Prueba de desplazamiento a izquierda
		load <= '0';  
		for i in 1 to 31 loop
			wait for clk_period;
	    	assert q(i) = '1' report "No funcionó el SHIFT a izquierda." severity failure; 				
			assert (q(31 downto i+1) & q(i-1 downto 0)) = zeros31 report "No funcionó el SHIFT a izquierda" severity failure;
		end loop; 
		
		-- Prueba de desplazamiento a derecha
		dir <= '1'; -- desplazamiento a derecha
		for i in 30 downto 0 loop
			wait for clk_period;
	    	assert q(i) = '1' report "No funcionó el SHIFT a derecha." severity failure; 				
			assert (q(31 downto i+1) & q(i-1 downto 0)) = zeros31 report "No funcionó el SHIFT a derecha" severity failure;
		end loop;							 
		
		-- Prueba Reset
		reset <= '1';															
		wait for clk_period;
	   assert q = x"00000000" report "No funcionó el RESET." severity failure; 				
		
		reset <= '0';															
		d <= x"AAAAAAAA";
		load <= '1';
		-- Prueba de LOAD
		wait for clk_period;
	   assert q = x"AAAAAAAA" report "No funcionó el LOAD." severity failure; 				
		
		end_sim <= true;
		wait;
		
	end process;

end PRACTICA_I;



