library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
    process(clk, reset)
    begin
        if (reset = '1') then --reset asincrono
            Regs <= (others => x"00000000");    
        elsif (falling_edge(clk)) then
                if (wr = '1') then
                    Regs(conv_integer(reg_wr)) <= data_wr;
                end if;
        end if;       
    end process;
    
    data1_rd <= x"00000000" when reg1_rd = "00000" else Regs(conv_integer(reg1_rd));
    data2_rd <= x"00000000" when reg2_rd = "00000" else Regs(conv_integer(reg2_rd));
    
end Behavioral;