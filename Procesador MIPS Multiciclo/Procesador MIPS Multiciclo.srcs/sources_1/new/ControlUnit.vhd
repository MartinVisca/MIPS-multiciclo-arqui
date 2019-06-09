library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
    signal state, next_state: std_logic_vector(3 downto 0); 
begin

comb_process: process(OpCode, state)
begin
    case state is 
        when "0000" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '0';
               AluSelB <= "01";
               RegWrite <= '0';
               RegDst <= '0';
               PCWrite <= '1';
               PCWriteCond <= '0';
               IorD <= '0';
               MemRead <= '1';
               MemWrite <= '0';
               IRWrite <= '1';
               MemToReg <= '0';
			   next_state <= "0001"; 	
        when "0001" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '0';
               AluSelB <= "11";
               RegWrite <= '0';
               RegDst <= '0';
               PCWrite <= '0';
               PCWriteCond <= '0';
               IorD <= '0';
               MemRead <= '0';
               MemWrite <= '0';
               IRWrite <= '0';
               MemToReg <= '0';
               case (OpCode) is
                    when "100011" => next_state <= "0010";
                    when "101011" => next_state <= "0010";
                    when "000000" => next_state <= "0110";
                    when "000100" => next_state <= "1000";
                    when others => next_state <= "0000";
               end case;
        when "0010" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '1';
               AluSelB <= "10";
               RegWrite <= '0';
               RegDst <= '0';
               PCWrite <= '0';
               PCWriteCond <= '0';
               IorD <= '0';
               MemRead <= '0';
               MemWrite <= '0';
               IRWrite <= '0';
               MemToReg <= '0';
               case (OpCode) is
                    when "100011" => next_state <= "0011";
                    when "101011" => next_state <= "0101";
                    when others => next_state <= "0000";
               end case;
        when "0011" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '0';
               AluSelB <= "00";
               RegWrite <= '0';
               RegDst <= '0';
               PCWrite <= '0';
               PCWriteCond <= '0';
               IorD <= '1';
               MemRead <= '1';
               MemWrite <= '0';
               IRWrite <= '0';
               MemToReg <= '0';
               next_state <= "0100";
        when "0100" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '0';
               AluSelB <= "00";
               RegWrite <= '1';
               RegDst <= '1';
               PCWrite <= '0';
               PCWriteCond <= '0';
               IorD <= '0';
               MemRead <= '0';
               MemWrite <= '0';
               IRWrite <= '0';
               MemToReg <= '0';
			   next_state <= "0000"; 	
        when "0101" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '0';
               AluSelB <= "00";
               RegWrite <= '0';
               RegDst <= '0';
               PCWrite <= '0';
               PCWriteCond <= '0';
               IorD <= '1';
               MemRead <= '0';
               MemWrite <= '1';
               IRWrite <= '0';
               MemToReg <= '0';
               next_state <= "0000";
        when "0110" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "10";
               AluSelA <= '1';
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
               next_state <= "0111";   
        when "0111" =>
               PCSource <= '0';
               TargetWrite <= '0';
               AluOp <= "00";
               AluSelA <= '0';
               AluSelB <= "00";
               RegWrite <= '1';
               RegDst <= '1';
               PCWrite <= '0';
               PCWriteCond <= '0';
               IorD <= '0';
               MemRead <= '0';
               MemWrite <= '0';
               IRWrite <= '0';
               MemToReg <= '0';
               next_state <= "0000";
        when "1000" =>
               PCSource <= '1';
               TargetWrite <= '0';
               AluOp <= "01";
               AluSelA <= '1';
               AluSelB <= "00";
               RegWrite <= '0';
               RegDst <= '0';
               PCWrite <= '0';
               PCWriteCond <= '1';
               IorD <= '0';
               MemRead <= '0';
               MemWrite <= '0';
               IRWrite <= '0';
               MemToReg <= '0';
               next_state <= "0000";
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
			   next_state <= "0000"; 
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
