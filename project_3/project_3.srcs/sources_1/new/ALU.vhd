----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2019 08:59:48
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           alu_control : in STD_LOGIC_VECTOR (2 downto 0);
           alu_result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal result: STD_LOGIC_VECTOR (31 downto 0);
begin
    process(alu_control,a,b)
    begin
        case alu_control is
        when "000" =>
            result <= a and b; --operacion AND
        when "001" =>
            result <= a or b; --operacion OR
        when "010" =>
            result <= a + b; --operacion SUMA
        when "110" =>
            result <= a - b; --operacion RESTA
        when "111" =>
            if (a < b) then
                result <= x"0001";
            else
                result <= x"0000";
            end if;
        when "100" =>
            b sll 16;
        end case;
    end process;
        

end Behavioral;

