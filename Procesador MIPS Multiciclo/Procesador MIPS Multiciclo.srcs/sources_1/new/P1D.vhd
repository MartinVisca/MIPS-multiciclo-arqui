
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers is
    Port ( 
        clk         : in std_logic;
        reset       : in std_logic;
        wr          : in std_logic;
        reg1_rd     : in std_logic_vector (4 downto 0);
        reg2_rd     : in std_logic_vector (4 downto 0);
        reg_wr      : in std_logic_vector (4 downto 0);
        data_wr     : in std_logic_vector (31 downto 0);
        data1_rd    : out std_logic_vector (31 downto 0);
        data2_rd    : out std_logic_vector (31 downto 0)
    );
end Registers;

architecture Behavioral of Registers is
    signal d1 : std_logic_vector (31 downto 0);
    signal d2 : std_logic_vector (31 downto 0);
    signal dwr : std_logic_vector (31 downto 0);
begin
    process(wr, clk)
    begin
        if falling_edge(clk) and wr = '1' then
            
    end process;

end Behavioral;
