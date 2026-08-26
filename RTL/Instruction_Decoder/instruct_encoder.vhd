library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruct_encoder is
  Port (
    opcode_in   : in  STD_LOGIC_VECTOR(15 downto 0);
    t           : in  STD_LOGIC_VECTOR(7 downto 0);
    reset,start       : in  STD_LOGIC;
    PCout, MARin, Read, sel4, Zin   : out STD_LOGIC;
    Zout, PCin, WMFC, MDRout, MDRin, IRin, NAND_gate : out STD_LOGIC;
    R2out, R1out, Yin, AND_gate, OR_gate, NOT_gate, XOR_gate, XNOR_gate : out STD_LOGIC;
    MDRinE, MDRoutE, selY, NOR_gate,  ADD, SUB, INC, DEC, ALU_pass     : out STD_LOGIC;
    R1in, R3in, end_op, write: out STD_LOGIC
  );
end instruct_encoder;

architecture Behavioral of instruct_encoder is

--signal add_1, sel4_1, Zin_1, Zout_1, Yin_1, add_2, sel4_2, Zin_2, Zout_2, Yin_2: std_logic;

begin
  process(reset, opcode_in, t, start)
  begin
    if reset = '0' and start = '1' then
    
      PCout   <= t(0);
      MARin   <= t(0);
      Read    <= t(0);
      PCin    <= t(1);
      WMFC    <= t(1);
      MDRout  <= t(2);
      IRin    <= t(2);
      MDRinE  <= t(1);
     
      R1out   <= t(3) and (opcode_in(0) or opcode_in(1) or opcode_in(2) or opcode_in(3) or opcode_in(4) or opcode_in(5) or opcode_in(6) or opcode_in(7) or opcode_in(8) or opcode_in(9) or opcode_in(10) or opcode_in(11));
      R2out   <= t(4) and (opcode_in(0) or opcode_in(1) or opcode_in(3) or opcode_in(4) or opcode_in(5) or opcode_in(6) or opcode_in(7) or opcode_in(10) or opcode_in(11)); 
      selY    <= t(4) and (opcode_in(0) or opcode_in(1) or opcode_in(2) or opcode_in(3) or opcode_in(4) or opcode_in(5) or opcode_in(6) or opcode_in(7) or opcode_in(10) or opcode_in(11));
      R3in    <= t(5) and (opcode_in(0) or opcode_in(1) or opcode_in(3) or opcode_in(4) or opcode_in(5) or opcode_in(6) or opcode_in(7) or opcode_in(10) or opcode_in(11));
      R1in    <= t(5) and (opcode_in(2) or opcode_in(8) or opcode_in(9));
      SUB     <= t(4) and (opcode_in(7) or opcode_in(9));
      AND_gate<=  t(4) and opcode_in(0);
      OR_gate<=  t(4) and opcode_in(1);
      NOT_gate<=  t(4) and opcode_in(2);
      XOR_gate<=  t(4) and opcode_in(3);
      NAND_gate<=  t(4) and opcode_in(4);
      NOR_gate <= t(4) and opcode_in(5);
      SUB <= t(4) and opcode_in(7);
      INC <= t(4) and opcode_in(8);
      DEC <= t(4) and opcode_in(9);
      XNOR_gate <= t(4) and opcode_in(10);
      ALU_pass <= t(4) and opcode_in(11);
      end_op  <= (t(6) and (opcode_in(0) or opcode_in(1) or opcode_in(2) or opcode_in(3) or opcode_in(4) or opcode_in(5) or opcode_in(6) or opcode_in(7) or opcode_in(8) or opcode_in(9) or opcode_in(10) or opcode_in(11)));
                 
      sel4 <= t(0) or (t(3) and (opcode_in(9) or opcode_in(8)));
      ADD <= t(0) or ( t(4) and (opcode_in(6) or opcode_in(8)) );
      Zin <= t(0) or ( t(4) and (opcode_in(0) or opcode_in(1) or opcode_in(2) or opcode_in(3) or opcode_in(4) or opcode_in(5) or opcode_in(6) or opcode_in(7) or opcode_in(8) or opcode_in(9) or opcode_in(10) or opcode_in(11)));
      Zout <= t(1) or (t(5) and (opcode_in(0) or opcode_in(1) or opcode_in(2) or opcode_in(3) or opcode_in(4) or opcode_in(5)or opcode_in(6) or opcode_in(7) or opcode_in(8) or opcode_in(9) or opcode_in(10) or opcode_in(11)));
      Yin <= t(1) or ( t(3) and (opcode_in(0) or opcode_in(1) or opcode_in(2) or opcode_in(3) or opcode_in(4) or opcode_in(5)or opcode_in(6) or opcode_in(7) or opcode_in(10) or opcode_in(11)) );
    
     
    else
      -- When reset is not active, all control signals OFF
      PCout   <= '0'; MARin <= '0'; Read <= '0'; sel4 <= '0'; Zin <= '0';
      Zout    <= '0'; PCin <= '0'; WMFC <= '0'; MDRout <= '0'; MDRin <= '0'; IRin <= '0';
      NAND_gate <= '0'; AND_gate <= '0'; OR_gate <=  '0'; NOT_gate <= '0'; XOR_gate <=  '0';
      R2out   <= '0'; R1out <= '0'; Yin <= '0';ALU_pass <= '0'; XNOR_gate <= '0';
      MDRinE  <= '0'; MDRoutE <= '0'; selY <= '0'; ADD <= '0'; Sub <= '0';
      R1in    <= '0'; R3in <= '0'; end_op <= '0'; write <= '0';
    end if;
  end process;
end Behavioral;
