library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX is
    Port ( 
        a           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        b           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        sel         : IN STD_LOGIC;
        q           : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end MUX;

architecture Behavioral of MUX is
    signal salida : STD_LOGIC_VECTOR (31 DOWNTO 0);
begin
    process (a, b, sel)
    begin
        case sel is
            when "0" =>
                salida <= a;
            when others =>
                salida <= b;
        end case;
    end process;
    q <= salida;

end Behavioral;
