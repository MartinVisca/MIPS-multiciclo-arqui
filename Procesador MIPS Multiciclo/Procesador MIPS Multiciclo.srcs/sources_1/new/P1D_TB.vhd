library ieee;
use ieee.std_logic_1164.all;

entity tb_Registers is
end tb_Registers;

architecture tb of tb_Registers is

    component Registers
        port (clk      : in std_logic;
              reset    : in std_logic;
              wr       : in std_logic;
              reg1_rd  : in std_logic_vector (4 downto 0);
              reg2_rd  : in std_logic_vector (4 downto 0);
              reg_wr   : in std_logic_vector (4 downto 0);
              data_wr  : in std_logic_vector (31 downto 0);
              data1_rd : out std_logic_vector (31 downto 0);
              data2_rd : out std_logic_vector (31 downto 0));
    end component;

    signal clk      : std_logic;
    signal reset    : std_logic;
    signal wr       : std_logic;
    signal reg1_rd  : std_logic_vector (4 downto 0);
    signal reg2_rd  : std_logic_vector (4 downto 0);
    signal reg_wr   : std_logic_vector (4 downto 0);
    signal data_wr  : std_logic_vector (31 downto 0);
    signal data1_rd : std_logic_vector (31 downto 0);
    signal data2_rd : std_logic_vector (31 downto 0);

begin

    dut : Registers
    port map (clk      => clk,
              reset    => reset,
              wr       => wr,
              reg1_rd  => reg1_rd,
              reg2_rd  => reg2_rd,
              reg_wr   => reg_wr,
              data_wr  => data_wr,
              data1_rd => data1_rd,
              data2_rd => data2_rd);

    stimuli : process
    begin

        clk <= '0';
        reset <= '0';
        wr <= '0';
        reg1_rd <= (others => '0');
        reg2_rd <= (others => '0');
        reg_wr <= (others => '0');
        data_wr <= (others => '0');
        
        clk <= '0';
        wr <= '1';
        data_wr <= x"00000100";
        reg_wr <= "00100";
        wait for 100ns;
        
        clk <= '1';
        wr <= '0';
        wait for 100 ns;
        
        clk <= '0';
        wr <= '1';
        data_wr <= x"00000100";
        reg_wr <= "00100";
        wait for 100ns;
        
        clk <= '1';
        wr <= '0';
        wait for 100 ns;
        
        clk <= '0';
        wr <= '1';
        data_wr <= x"00010001";
        reg_wr <= "11000";
        wait for 100ns;
        
        Reset <= '1';
        
        clk <= '1';
        wr <= '0';
        wait for 100 ns;
        
        clk <= '0';
        wr <= '1';
        data_wr <= x"00000011";
        reg_wr <= "00001";
        wait for 100ns;
        
        
    end process;

end tb;