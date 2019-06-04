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
     signal PCWrite:            std_logic;
     signal PCWriteCond:        std_logic;
     signal IorD:               std_logic;
     signal MemRead:            std_logic;
     signal MemWrite:           std_logic;
     signal IRWrite:            std_logic;
     signal MemToReg:           std_logic;
     signal PCSource:           std_logic;
     signal TargetWrite:        std_logic;
     signal ALUOp:              std_logic_vector (1 downto 0);
     signal ALUSelB:            std_logic_vector (1 downto 0);
     signal ALUSelA:            std_logic;
     signal RegWrite:           std_logic;
     signal RegDst:             std_logic;
     
     --Señales del contador de programa
     signal PCin:               std_logic_vector (31 downto 0);
     signal PCout:              std_logic_vector (31 downto 0);
     signal PCControl:          std_logic;
     
     --Señales de los mux
     signal OutMuxMem:          std_logic_vector (31 downto 0); 
     signal OutMuxBancoWrReg:   std_logic_vector (4 downto 0);
     signal OutMuxBancoWrDt:    std_logic_vector (31 downto 0);
     signal OutMuxALUx2:        std_logic_vector (31 downto 0);
     signal OutMuxALUx4:        std_logic_vector (31 downto 0);
     
     --Señal de la extension de signo
     signal OutSignExtend:      std_logic_vector (31 downto 0);
     
     --Señal target
     signal OutTarget:          std_logic_vector (31 downto 0);
     
     --Señal ALU control
     signal OutALUControl:      std_logic_vector (2 downto 0);
     
     --Señal Shift left 2
     signal OutSL2:             std_logic_vector (31 downto 0);
     
     --Señal ALU
     signal Zero:               std_logic;
     
     --Señal puerta AND
     signal OutAND:             std_logic;
     
begin 
-- procesos explicitos, implicitos e instanciacion de componentes 

    

end Multicycle_MIPS_arch;