---------------------------------------------------------------------------------------------------
--
-- Title       : ControlUnit.vhd
-- Design      : Control Unit Template for Multicycle MIPS
-- Author      : L. Leiva
-- Company     : UNICEN
--
--
---------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
    Port ( clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           OpCode:  in STD_LOGIC_VECTOR(5 downto 0);
           PCSource: out STD_LOGIC;
           TargetWrite: out STD_LOGIC;
           AluOp: out STD_LOGIC_VECTOR(1 downto 0);
           AluSelA: out STD_LOGIC;
           AluSelB: out STD_LOGIC_VECTOR(1 downto 0);
           RegWrite: out STD_LOGIC;
           RegDst: out STD_LOGIC;
           PCWrite: out STD_LOGIC;
           PCWriteCond: out STD_LOGIC;
           IorD: out STD_LOGIC;
           MemRead: out STD_LOGIC;
           MemWrite: out STD_LOGIC;
           IRWrite: out STD_LOGIC;
           MemToReg: out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is
    signal state, next_state: std_logic_vector(2 downto 0); 
begin

comb_process: process(OpCode, state)
begin
    case state is 
        when "000" =>
        -- debe completarse las señales de control para este estado 
               PCSource <= 
               TargetWrite <= 
               AluOp <= 
               AluSelA <= 
               AluSelB <= 
               RegWrite <= 
               RegDst <= 
               PCWrite <= 
               PCWriteCond <=
               IorD <=
               MemRead <=
               MemWrite <=
               IRWrite <=
               MemToReg <=
			   next_state <= 	
        when "001" =>
        -- debe completarse las señales de control para este estado, y para el resto de los estados
        
        when others =>
               PCSource <= '0'; 
               TargetWrite <='0';  
               AluOp <= "00"; 
               AluSelA <= '0'; 
               AluSelB <= "00"; 
               RegWrite <= '0'; 
               RegDst <= '0'; 
               PCWrite <= '0'; 
               PCWriteCond <= '0'; 
               IorD <= '0'; 
               MemRead <= '0'; 
               MemWrite <= '0'; 
               IRWrite <= '0'; 
               MemToReg <= '0'; 
			   next_state <= "000"; 
    end case;  
 end process; 

seq_process: process(clk, reset)
begin
    if reset = '1' then
        state <= (others => '0'); 
    elsif rising_edge(clk) then 
        state <= next_state; 
    end if; 
end process; 


end Behavioral;
