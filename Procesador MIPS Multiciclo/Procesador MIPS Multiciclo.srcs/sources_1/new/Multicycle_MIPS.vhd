---------------------------------------------------------------------------------------------------
--
-- Title       : Multicycle_MIPS.vhd
-- Design      : Empty design file for multicycle MIPS
-- Author      : L. Leiva
-- Company     : UNICEN
--
--
---------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Multicycle_MIPS is
port(
	Clk       : in  std_logic;
	Reset     : in  std_logic;
	Addr      : out std_logic_vector(31 downto 0);
	RdStb     : out std_logic;
	WrStb     : out std_logic;
	DataOut   : out std_logic_vector(31 downto 0);
	DataIn    : in  std_logic_vector(31 downto 0)
);
end Multicycle_MIPS; 

architecture Multicycle_MIPS_arch of Multicycle_MIPS is 

    --Banco de registros
    component Registers
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
     end component;
     
     --ALU
     component ALU
     Port (
        a           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        b           : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        control     : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        resultado   : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        zero        : OUT STD_LOGIC
     );
     end component;
     
     --Señales de control
     signal PCWrite:        out std_logic;
     signal PCWriteCond:    out std_logic;
     signal IorD:           out std_logic;
     signal MemRead:        out std_logic;
     signal MemWrite:       out std_logic;
     signal IRWrite:        out std_logic;
     signal MemToReg:       out std_logic;
     signal PCSource:       out std_logic;
     signal TargetWrite:    out std_logic;
     signal ALUOp:          out std_logic_vector (1 downto 0);
     signal ALUSelB:        out std_logic_vector (1 downto 0);
     signal ALUSelA:        out std_logic;
     signal RegWrite:       out std_logic;
     signal RegDst:         out std_logic;
     
     
     
     
     
begin 
-- procesos explicitos, implicitos e instanciacion de componentes 

    

end Multicycle_MIPS_arch;