library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Hardwired_CU_4 is
    port(clk    : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        load_in   : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(7 downto 0);
        PCout, MARin, Read, sel4, Zin, Zout, PCin, WMFC, MDRout, MDRin, IRin, R1out, Yin : out std_logic;
        MDRinE, MDRoutE, selY, R1in, R3in, R2out, end_op, write, gate_nand, gate_and, gate_or, gate_not, gate_xor  : out std_logic;
        gate_nor, gate_xnor,  addition, subtraction, increment, decrement, alu_pass : OUT std_logic
        );          
end Hardwired_CU_4;

architecture Structural of Hardwired_CU_4 is

--component instruction_register4 
--    Port (
--        clk       : in  STD_LOGIC;
--        rst       : in  STD_LOGIC;
--        load      : in  STD_LOGIC;
--        data_in   : in  STD_LOGIC_VECTOR(1 downto 0);
--        instr_out : out STD_LOGIC_VECTOR(1 downto 0)
--    );
--end component;


component instruction_decoder 
    Port (
        opcode  : in  STD_LOGIC_VECTOR(7 downto 0);
        control : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;


component instruct_encoder
  Port (
    opcode_in   : in  STD_LOGIC_VECTOR(15 downto 0);
    t           : in  STD_LOGIC_VECTOR(7 downto 0);
    reset,start       : in  STD_LOGIC;
    PCout, MARin, Read, sel4, Zin   : out STD_LOGIC;
    Zout, PCin, WMFC, MDRout, MDRin, IRin, NAND_gate : out STD_LOGIC;
    R2out, R1out, Yin, AND_gate, OR_gate, NOT_gate, XOR_gate, XNOR_gate : out STD_LOGIC;
    MDRinE, MDRoutE, selY, NOR_gate,  ADD, SUB, INC, DEC, ALU_pass       : out STD_LOGIC;
    R1in, R3in, end_op, write: out STD_LOGIC
  );
end component;


component step_counter 
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        run   : in  STD_LOGIC;               
        count : out STD_LOGIC_VECTOR (2 downto 0)
    );
end component;

component step_decoder 
    Port (
        input_dec  : in  STD_LOGIC_VECTOR (2 downto 0);
        output_dec : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;



signal s1 : std_logic_vector(1 downto 0);
signal step_cntr_out : std_logic_vector(2 downto 0);
signal step_dec_out : std_logic_vector(7 downto 0);
signal rst_cntr : std_logic;
signal output_ID : std_logic_vector(15 downto 0);


begin

--u0: instruction_register4 port map(
--        clk     => clk,
--        rst     => rst,
--        load      => load_in,
--        data_in   => input,
--        instr_out => s1);
        
u1:  instruction_decoder port map (
--        opcode =>  s1,
         opcode =>  input,
        control => output_ID );
        
        
u2 : instruct_encoder port map ( 
        opcode_in   => output_ID,
        reset => rst,
        start => load_in,
        t => step_dec_out,
        PCout => PCout,
        MARin => MARin, 
        Read => Read,
        sel4 => sel4,
        Zin  => Zin,
        Zout => Zout,
        PCin => PCin,
        WMFC => WMFC,
        MDRout => MDRout,
        MDRin => MDRin,
        IRin => IRin,
        NAND_gate => gate_nand,
        AND_gate => gate_and,
        OR_gate => gate_or,
        NOT_gate => gate_not,
        XOR_gate => gate_xor,   
        NOR_gate => gate_nor,
        XNOR_gate => gate_xnor,    
        ADD => addition, 
        SUB  => subtraction, 
        INC  => increment, 
        DEC  => decrement, 
        ALU_pass =>alu_pass, 
        R2out => R2out,
        R1out => R1out,
        Yin => Yin,
        MDRinE => MDRinE,
        MDRoutE => MDRoutE,
        selY =>  selY,  
        R1in => R1in,
        R3in => R3in,
        end_op => rst_cntr,
        write => write);
        
                   
u3 : step_counter port map (
        clk    => clk,
        reset => rst_cntr,
        run   => load_in,             
        count => step_cntr_out);
        
 
u4 :  step_decoder port map(
        input_dec =>  step_cntr_out,       
        output_dec => step_dec_out);
        
        
        
end_op <= rst_cntr;
 
end Structural;
