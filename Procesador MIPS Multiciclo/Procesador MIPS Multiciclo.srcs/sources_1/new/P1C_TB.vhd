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

    signal a         : std_logic_vector (31 downto 0) := (others => '0');
    signal b         : std_logic_vector (31 downto 0) := (others => '0');
    signal control   : std_logic_vector (2 downto 0) := (others => '0');
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
        
        a <= x"00000010";
        b <= x"00000011";
        
        control <= "000";
        wait for 100 ns;
        
        control <= "001";
        wait for 100 ns;
        
        control <= "010";
        wait for 100 ns;
        
        control <= "110";
        wait for 100 ns;
        
        control <= "100";
        wait for 100 ns;
        
        control <= "111";
        wait for 100 ns;
 
        
    end process;

end tb;