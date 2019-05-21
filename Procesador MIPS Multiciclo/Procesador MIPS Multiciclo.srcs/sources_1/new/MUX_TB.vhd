
library ieee;
use ieee.std_logic_1164.all;


entity P1B_TB is
end P1B_TB;

architecture PRACTICA_I of P1B_TB is
	-- Component declaration of the tested unit
	component mux
	port(
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		sel : in std_logic;
		q : out std_logic_vector(31 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : std_logic_vector(31 downto 0);
	signal b : std_logic_vector(31 downto 0);
	signal sel : std_logic;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal q : std_logic_vector(31 downto 0);
	
	constant time_step: TIME := 20 ns;
begin

	-- Unit Under Test port map
	UUT : mux
		port map
			(a => a,
			b => b,
			sel => sel,
			q => q );

	-- Testbench propiamente dicho
	process begin
		sel <= '0';
		a <= x"AAAAAAAA";
		b <= x"11111111";
		wait for time_step;
		assert q=a report "No funciona MUX32" severity error;

		sel <= '1';
		a <= x"AAAAAAAA";
		b <= x"11111111";		
		wait for time_step;
		assert q=b report "No funciona MUX32" severity error;
		
		b <= X"FFFFFFFF";		
		wait for time_step;
		assert q=b report "No funciona MUX32" severity error;
		
		report "Testbench Finalizado";
		wait; 
		
	end process;
end PRACTICA_I;


