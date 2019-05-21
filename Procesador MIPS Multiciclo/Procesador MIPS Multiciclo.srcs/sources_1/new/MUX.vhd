----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2019 19:17:23
-- Design Name: 
-- Module Name: MUX - Behavioral
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
