----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2019 02:30:50
-- Design Name: 
-- Module Name: REG - Behavioral
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

entity REG is
    Port (
        d           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        clk         : IN STD_LOGIC;
        reset       : IN STD_LOGIC;
        ce          : IN STD_LOGIC;
        q           : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end REG;

architecture Behavioral of REG is

begin
    process (clk, reset)
    begin
        if reset = '1' then
            q <= (others => '0');
        elsif rising_edge(clk) and ce = '1' then
            q <= d;
        end if;
    end process;

end Behavioral;
