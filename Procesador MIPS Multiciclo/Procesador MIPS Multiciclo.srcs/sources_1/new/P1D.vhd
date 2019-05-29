
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
    type t_registro is array(0 to 31) of std_logic_vector (31 downto 0);
    signal Regs: t_registro;
begin
    process(wr, clk, reset, reg1_rd, reg2_rd, reg_wr)
    begin
        if (reset = '1') then --reset asincrono
            Regs <= (others => x"00000000");    
        else
            if (falling_edge(clk)) then
                if (wr = '1') then
                    Regs(conv_integer(reg_wr)) <= data_wr;
                end if;
            else
                if (reg1_rd /= "0000") then
                    data1_rd <= Regs(conv_integer(reg1_rd));
                else
                    data1_rd <= x"00000000";
                end if;
                if (reg2_rd /= "0000") then
                    data2_rd <= Regs(conv_integer(reg2_rd));
                else
                    data2_rd <= x"00000000";
                end if;
            end if;
        end if;          
            
    end process;

end Behavioral;
