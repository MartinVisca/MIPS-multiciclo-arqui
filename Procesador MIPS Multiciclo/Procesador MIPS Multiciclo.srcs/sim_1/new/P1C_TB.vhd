
library ieee;
use ieee.std_logic_1164.all;

entity tb_ALU is
end tb_ALU;

architecture tb of tb_ALU is

    component ALU
        port (a         : in std_logic_vector (31 downto 0);
              b         : in std_logic_vector (31 downto 0);
              control   : in std_logic_vector (2 downto 0);
              resultado : out std_logic_vector (31 downto 0);
              zero      : out std_logic);
    end component;

    signal a         : std_logic_vector (31 downto 0);
    signal b         : std_logic_vector (31 downto 0);
    signal control   : std_logic_vector (2 downto 0);
    signal resultado : std_logic_vector (31 downto 0);
    signal zero      : std_logic;

begin

    dut : ALU
    port map (a         => a,
              b         => b,
              control   => control,
              resultado => resultado,
              zero      => zero);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a <= (others => '0');
        b <= (others => '0');
        control <= (others => '0');

        -- EDIT Add stimuli here
        a <= x"00000001";
        b <= x"00000001";
        control <= "010";
        wait for 100 ns;
        
        
        
        
        
        wait;
    end process;

end tb;