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
     
     --Unidad de Control
     component ControlUnit
     Port (
        clk : in STD_LOGIC;
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
        MemToReg: out STD_LOGIC
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
     signal OutMuxTarget:       std_logic_vector (31 downto 0);
     
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
     signal AluOut:             std_logic_vector (31 downto 0);
     
     --Señal puerta AND
     signal OutAND:             std_logic;
     
     --Señal puerta OR
     signal OutOr:              std_logic;
     
     --Señales Banco de Registros
     signal outBR1, outBR2  :   std_logic_vector (31 downto 0);
     
     --Señal Memory
     signal writeIR : std_logic;
     
     --Señales registro de instrucciones
     signal outmemory   :   std_logic_vector (31 downto 0);
     signal outIRHigh   :   std_logic_vector (5 downto 0);
     signal outIRLow    :   std_logic_vector (25 downto 0);
     
begin 
-- procesos explicitos, implicitos e instanciacion de componentes 
    
    --Registro PC
    PCReg : process(Clk,Reset)
    begin
        if (Reset = '1') then
            PCout <= x"00000000";
        elsif rising_edge(Clk) then
            if (PCControl = '1') then
                PCout <= PCin;
            end if;
        end if;
    end process;
    
    --Mux entre PC y Memory
    OutMuxMem <= AluOut when IorD = '1' else PCout;
			
	Addr <= OutMuxMem; --Conectados el mux y la memoria de datos
	RdStb <= MemRead; --Conectada la habilitacion de lectura
	WrStb <= MemWrite; --Conectada la habilitacion de escritura
	DataOut <= outBR2; --Salida baja del banco de registros conectada con la escritura del dato en la memoria de datos
	
	--Enchufe IRWrite al Instruction Register
	writeIR <= IRWrite;
	
	--Instruction Register
	process(Reset, Clk)
	begin
	   if (Reset = '1') then
            outmemory <= x"00000000";
       elsif rising_edge(Clk) then
            if (TargetWrite = '1') then
                outmemory <= DataIn;
            end if;
       end if;
	end process;
	
	OutOr <= OutAnd or PcWrite; --Conexion de la puerta OR
	OutAnd <= Zero and PcWriteCond; --Conexion de la puerta AND
	
	PCControl <= OutOr; --Entrada del PC igual a la salida de la puerta OR
    PCin <= OutMuxTarget; --Conexion de la entrada del PC con la siguien direccion en memoria
    
    UnidadControl : ControlUnit port map(
        clk => Clk,
        Reset => Reset,
        OpCode => outIRHigh,
        PCSource => PCSource,
        TargetWrite => TargetWrite,
        AluOp => AluOp,
        AluSelA => AluSelA,
        AluSelB => AluSelB,
        RegWrite => RegWrite,
        RegDst => RegDst,
        PCWrite => PCWrite,
        PCWriteCond => PCWriteCond,
        IorD => IorD,
        MemRead => MemRead,
        MemWrite => MemWrite,
        IRWrite => IRWrite,
        MemToReg => MemToReg
    );    
        
    
    OutMuxTarget <= OutTarget when PCSource = '1' else ALUOut; --Multiplexor siguiente al target
    
    
    OutMuxALUx2 <= PCout when ALUSelA = '0' else outBR1; --Multiplexor de dos entradas que da la entrada "a" a la ALU
    
    --MUX 4 a 1
    process (ALUSelB, outBR1, OutSignExtend, OutSL2)
    begin
        case ALUSelB is 
            when "00" =>
                OutMuxALUx4 <= outBR1;
            when "01" =>
                OutMuxALUx4 <= x"00000004";
            when "10" =>
                OutMuxALUx4 <= OutSignExtend;
            when others =>
                OutMuxALUx4 <= OutSL2;
         end case;
    end process;
                   
    --Instanciacion del banco de registros
    BancoRegistros : Registers port map(
        clk         => Clk,
        reset       => Reset,
        wr          => RegWrite,
        reg1_rd     => outIRLow (25 downto 21),
        reg2_rd     => outIRLow (20 downto 16),
        reg_wr      => OutMuxBancoWrReg,
        data_wr     => OutMuxBancoWrDt,
        data1_rd    => outBR1,
        data2_rd    => outBR2
    );
    
    OutMuxBancoWrReg <= outIRLow (20 downto 16) when RegDst = '0' else outIRLow (15 downto 11); --Multiplexor que da la entrada reg_wr del banco de registros
    
    OutMuxBancoWrDt <= AluOut when MemToReg = '0' else DataIn; --Mux que elige entre el resultado de la ALU y el DataOut para darle la entrada a data_wr del banco de registros
  
    --Extensor de signo
    OutSignExtend <= (x"0000" & outIRLow (15 downto 0)) when (outIRLow (15) = '0') else  (x"FFFF" & outIRLow (15 downto 0)); 
    --Si el primer bit (desde la derecha) de la entrada es igual a cero, se hace un and entre la instruccion y una mascara inicializada en ceros.
    --Si es igual a uno, la mascara esta inicializada en FFFF para invertir el numero.

    --Shift Left 2
    OutSL2 <= OutSignExtend (29 downto 0) & "00";

    --Instanciacion de la ALU
    ALUinst : ALU port map (
        a => OutMuxALUx2,
        b => OutMuxALUx4,
        control => OutALUControl,
        resultado => ALUOut,
        zero => Zero    
    );    

    --Instanciacion de ALU Control
    process (outIRLow (5 downto 0), ALUOp)
    begin
        case (ALUOp) is
            when "10" => --Operaciones tipo R
                case (outIRLow (5 downto 0)) is
                    when "100000" => --Suma 
                        OutALUControl <= "010";
                    when "100010" => --Resta
                        OutALUControl <= "110";
                    when "100100" => --AND
                        OutALUControl <= "000";
                    when "100101" => --OR
                        OutALUControl <= "001";
                    when "101010" => --Set on less
                        OutALUControl <= "111";
                    when others => --Todos los casos restantes
                        OutALUControl <= "000"; 
                end case;
            when "00" => --Operaciones LW y SW
                OutALUControl <= "010";
            when "01" => --Branch on equal
                OutALUControl <= "110";
            when others => --Caso 11
                OutALUControl <= "000";
        end case;
    end process;
    
    --Target
    process(Reset, Clk)
    begin
        if (Reset = '1') then
            OutTarget <= x"00000000";
        elsif rising_edge(Clk) then
            if (TargetWrite = '1') then
                OutTarget <= AluOut;
            end if;
        end if;
    end process;
    
end Multicycle_MIPS_arch;