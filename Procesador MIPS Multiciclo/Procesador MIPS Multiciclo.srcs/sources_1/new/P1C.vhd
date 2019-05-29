
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( 
        a           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        b           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        control     : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        resultado   : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        zero        : OUT STD_LOGIC          
    );
end ALU;

architecture Behavioral of ALU is
    signal res_alu : STD_LOGIC_VECTOR (31 DOWNTO 0);
begin
    process (control, a, b)
    begin
        case control is
            when "000" =>
                res_alu <= a and b;
            when "001" =>
                res_alu <= a or b;
            when "010" =>
                res_alu <= a + b;
            when "110" =>
                res_alu <= a - b;
            when "111" =>
                if (a < b) then
                    res_alu <= x"00000001";
                else
                    res_alu <= x"00000000";
                end if;
            when "100" =>
                res_alu <= b sla 16;
            when others =>
                res_alu <= x"00000000";
        end case;
    end process;
    
    resultado <= res_alu;
    zero <= '1' when res_alu = x"00000000" else '0';
                
end Behavioral;
