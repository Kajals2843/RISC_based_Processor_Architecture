library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RISC_DESIGN is
  Port (
    CLK, RST : IN STD_LOGIC;
    Start : IN STD_LOGIC;
    MEM_IN : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    bus_sel : IN std_logic_vector(2 downto 0);
    MEM_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    ADDRESS_OUT : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    Stop : OUT STD_LOGIC
  );
end RISC_DESIGN;

architecture Struct of RISC_DESIGN is


component Hardwired_CU_4 
    port(clk      : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        load_in   : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(1 downto 0);
        PCout, MARin, Read, sel4, Zin, Zout,PCin, WMFC, MDRout, MDRin, IRin, R3out, R1out, Yin : out std_logic;
        MDRinE, MDRoutE, selY, Add, R1in, R3in,  end_op,  IRout, write  : out std_logic
        );            
end component;


component ALU_4 
    Port (
        A      : in  STD_LOGIC_VECTOR(1 downto 0);
        B      : in  STD_LOGIC_VECTOR(1 downto 0);
        clk      : in std_logic;
        reset      : in std_logic;
        ALU_sel    : in  STD_LOGIC_VECTOR(3 downto 0);
        Result : out STD_LOGIC_VECTOR(1 downto 0);
        Cout   : out std_logic
    );
end component;


component register_file 
    Port ( Din : in STD_LOGIC_VECTOR (1 downto 0);
           RST, CLOCK : in STD_LOGIC;
           EN1in, EN2in, EN3in, EN4in, EN5in, EN6in, EN7in, EN8in, EN9in, EN10in   : in STD_LOGIC;
           EN1out, EN2out, EN3out, EN4out, EN5out, EN6out, EN7out, EN8out, EN9out, EN10out : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component MDR 
    Port (
        clk, reset         : in  STD_LOGIC;
        mdr_out_en  : in  STD_LOGIC; 
        mdr_in_en  : in  STD_LOGIC; 
        mdr_out_en_E  : in  STD_LOGIC; 
        mdr_in_en_E  : in  STD_LOGIC; 
        mem_data_in   : in STD_LOGIC_VECTOR(1 downto 0); -- data from memory
        bus_data_in      : in  STD_LOGIC_VECTOR(1 downto 0); -- data from bus
        mem_data_out   : out  STD_LOGIC_VECTOR(1 downto 0); -- data to memory
        bus_data_out      : out  STD_LOGIC_VECTOR(1 downto 0)-- data to bus
    );
end component;

component ProgramCounter 
    Port (
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        din : in std_logic_vector(1 downto 0);
        PC_in, PC_out : in std_logic;
        pc  : out STD_LOGIC_VECTOR(1 downto 0)
    );
end component;

component Y 
  Port ( Din : in std_logic_vector(1 downto 0);
         clk, reset : in std_logic;
         Y_in_en : in std_logic; 
--         Y_out_en : in std_logic; 
         Dout : out std_logic_vector(1 downto 0)
         );
end component;

component Z 
  Port ( Din : in std_logic_vector(1 downto 0);
         clk, reset : in std_logic;
         Z_in_en, Z_out_en : in std_logic; 
         Dout : out std_logic_vector(1 downto 0)
         );
end component;

component MAR 
    Port (
        clk,reset         : in  STD_LOGIC;
        mar_in      : in  STD_LOGIC;                         -- control signal to load MAR
        bus_in      : in  STD_LOGIC_VECTOR(1 downto 0);      -- data from system bus
        address_bus : out STD_LOGIC_VECTOR(1 downto 0)       -- output to memory
    );
end component;


component mux_2to1 
    Port (
        a     : in  std_logic_vector(1 downto 0);
        b     : in  STD_LOGIC_vector(1 downto 0);
        sel   : in  STD_LOGIC;
        y     : out STD_LOGIC_vector(1 downto 0)
    );
end component;

component instruction_register4 
    Port (
        clk           : in  STD_LOGIC;
        rst           : in  STD_LOGIC;
        input_enable  : in  STD_LOGIC;
        output_enable : in  STD_LOGIC;
        data_in       : in  STD_LOGIC_VECTOR(1 downto 0);
        instr_out     : out STD_LOGIC_VECTOR(1 downto 0)
    );
end component;


-- Internal Signals
signal BUS_S0 : std_logic_vector(1 downto 0);
signal regfile_out, alu_z_out, mdr_out, pc_out, ir_output, y_out : std_logic_vector(1 downto 0);
signal opr1 : std_logic_vector(1 downto 0);
signal alu_out : std_logic_vector(1 downto 0);
signal alu_select : std_logic_vector(3 downto 0);

signal carry_out : std_logic;

-- Control signals from CU
signal pcout, addition, marin, rd, wr, sel_4, sel_y, zin, zout, pcin, wmfc, mdrout, mdrin, mdrine, mdroute, irin, irout : std_logic;
signal r1out, r3out, yin, r1in, r3in : std_logic;

begin

-- Control Unit
U_0 : Hardwired_CU_4 port map (
  clk => CLK, rst => RST, load_in => Start, input => ir_output,
  PCout => pcout, MARin => marin, Read => rd, sel4 => sel_4, Zin => zin,
  Zout => zout, PCin => pcin, WMFC => wmfc, MDRout => mdrout, MDRin => mdrin,
  R3out => r3out, R1out => r1out, Yin => yin, MDRinE => mdrine, MDRoutE => mdroute,
  selY => sel_y, Add => addition, R1in => r1in, R3in => r3in,
  end_op => Stop, IRout => irout, write => wr
);

-- ALU
U_1 : ALU_4 port map (
  A => opr1,
  B => y_out,
  clk => CLK,
  reset => RST,
  ALU_sel => alu_select,
  Result => alu_out,
  Cout => carry_out
);

-- Register File
U_2 : register_file port map (
  Din => BUS_S0,
  RST => RST,
  CLOCK => CLK,
  EN1in => r1in, EN2in => '0', EN3in => r3in, EN4in => '0', EN5in => '0', EN6in => '0',
  EN7in => '0', EN8in => '0', EN9in => '0', EN10in => '0',
  EN1out => r1out, EN2out => '0', EN3out => r3out, EN4out => '0', EN5out => '0',
  EN6out => '0', EN7out => '0', EN8out => '0', EN9out => '0', EN10out => '0',
  Dout => regfile_out
);

-- MDR
U_3 : MDR port map (
  clk => CLK, reset => RST,
  mdr_out_en => mdrout, mdr_in_en => mdrin,
  mdr_out_en_E => mdroute, mdr_in_en_E => mdrine,
  mem_data_in => MEM_IN,
  mem_data_out => MEM_OUT,
  bus_data_in => BUS_S0,
  bus_data_out => mdr_out
);

-- Program Counter
U_4 : ProgramCounter port map (
  clk => CLK, rst => RST,
  din => BUS_S0,
  PC_in => pcin, PC_out => pcout,
  pc => pc_out
);

-- Y Register
U_5 : Y port map (
  Din => BUS_S0,
  clk => CLK, reset => RST,
  Y_in_en => yin,
  Dout => y_out
);

-- Z Register
U_6 : Z port map (
  Din => alu_out,
  clk => CLK, reset => RST,
  Z_in_en => zin, Z_out_en => zout,
  Dout => alu_z_out
);

-- MAR
U_7 : MAR port map (
  clk => CLK, reset => RST,
  mar_in => marin,
  bus_in => BUS_S0,
  address_bus => ADDRESS_OUT
);

-- MUX for operand selection
U_8 : mux_2to1 port map (
  a => "01",
  b => y_out,
  sel => sel_y,
  y => opr1
);

-- Instruction Register
U_9: instruction_register4 port map (
  clk => CLK, rst => RST,
  input_enable => irin,
  output_enable => irout,
  data_in => BUS_S0,
  instr_out => ir_output
);

-- Bus multiplexer process
process(bus_sel,regfile_out, mdr_out, pc_out, alu_z_out, ir_output, y_out)
begin
  case bus_sel is
    when "000" => BUS_S0 <= regfile_out;
    when "001" => BUS_S0 <= mdr_out;
    when "010" => BUS_S0 <= pc_out;
    when "011" => BUS_S0 <= alu_z_out;
    when "100" => BUS_S0 <= ir_output;
    when "101" => BUS_S0 <= y_out;
    when others => BUS_S0 <= (others => '0');
  end case;
end process;

end Struct;
