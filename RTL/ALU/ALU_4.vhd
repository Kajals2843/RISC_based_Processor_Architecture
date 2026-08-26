library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_4 is
    Port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0);
        B      : in  STD_LOGIC_VECTOR(7 downto 0);
        clk      : in std_logic;
        reset      : in std_logic;
        ALU_sel    : in  STD_LOGIC_VECTOR(3 downto 0);
        Result : out STD_LOGIC_VECTOR(7 downto 0);
        Cout   : out std_logic
    );
end ALU_4;

architecture Struct of ALU_4 is

    -- Component declarations
  
    component AND_4bit
        Port(A, B: in STD_LOGIC_VECTOR(7 downto 0); 
            Y: out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component OR_4bit
        Port(A, B: in STD_LOGIC_VECTOR(7 downto 0); 
            Y: out STD_LOGIC_VECTOR(7 downto 0));
    end component;


    component NOR_4bit
        Port(A, B: in STD_LOGIC_VECTOR(7 downto 0); 
            Y: out STD_LOGIC_VECTOR(7 downto 0));
    end component;

    component adder_4  -- your adder
        Port(A, B: in STD_LOGIC_VECTOR(7 downto 0); 
--            Cin   : in  STD_LOGIC;
            Sum: out STD_LOGIC_VECTOR(7 downto 0);
            Cout  : out STD_LOGIC);
    end component;

    component SUBTRACTOR_4bit  -- your subtractor
        Port(A, B: in STD_LOGIC_VECTOR(7 downto 0); 
--        Bin    : in std_logic;
        Diff: out STD_LOGIC_VECTOR(7 downto 0);
        Borrow : out STD_LOGIC);
    end component;
    
    component NOT_4bit 
        Port(A : in STD_LOGIC_VECTOR(7 downto 0);
            Y : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component XOR_4bit 
        Port(A, B : in STD_LOGIC_VECTOR(7 downto 0);
            Y    : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component NAND_4bit 
        Port(A, B : in STD_LOGIC_VECTOR(7 downto 0);
            Y    : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component right_shift_reg 
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        din   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Parallel input
        q     : out STD_LOGIC_VECTOR(7 downto 0)   -- Parallel output
    );
    end component;
    
    component left_shift_reg
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        din   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Parallel input
        q     : out STD_LOGIC_VECTOR(7 downto 0)   -- Parallel output
    );
    end component;
    
    component xnor_8bit 
        Port ( a,b : in STD_LOGIC_VECTOR (7 downto 0);
               q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component pass 
        Port ( alu_in : in std_logic_vector(7 downto 0);
                alu_out : out std_logic_vector(7 downto 0));
    end component;
    
    
    
component mux_16to1 
    Port (
        mux_sel : in STD_LOGIC_VECTOR(3 downto 0);   -- 4-bit select input
        I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15   : in STD_LOGIC_VECTOR(7 downto 0);  
        Y   : out STD_LOGIC_VECTOR(7 downto 0)                     -- Output
    );
end component;
    
    


    -- Internal signals for all outputs
    signal and_out, or_out, xor_out, not_out, nand_out, nor_out, add_out, sub_out, xnor_out, pass_out : STD_LOGIC_VECTOR(7 downto 0);
    signal C_OUT,B_OUT : std_logic;
begin

 
    
    U1: AND_4bit       port map (A, B, and_out);
    U2: OR_4bit        port map (A, B, or_out);
    U3: NOT_4bit       port map(A,  not_out);
    U4: XOR_4bit       port map(A, B, xor_out);
    U5: NAND_4bit      port map(A, B, nand_out);
    U6: NOR_4bit       port map(A, B, nor_out);
    U7: adder_4     port map(A, B, add_out, C_OUT);
    U8: SUBTRACTOR_4bit port map(A, B, sub_out, B_OUT);
    U9 : xnor_8bit PORT MAP (A, B, xnor_out);
    U10 : pass port map (A, pass_out);
--    U9: right_shift_reg port map (clk => clk, reset => reset, 
--                                    din=> A, q => right_shift_out );
--    U10: left_shift_reg port map (clk => clk, reset => reset, 
--                                    din=> A, q => left_shift_out );
    U11: mux_16to1 port map (mux_sel => ALU_sel, I0 => and_out, I1 => or_out, I2 => not_out, I3 => xor_out,
                             I4  => nand_out, I5 => nor_out, I6 => add_out, I7 => sub_out, I8 => add_out, 
                             I9 => sub_out, I10 => xnor_out, 
                             I11 => pass_out, I12 => "00000000",  I13 => "00000000", 
                             I14 => "00000000",  I15 => "00000000", Y => Result );
       with ALU_sel select
        Cout <= C_OUT  when "0110",
                  B_OUT   when "0111",
                  '0' when others;           
                                    

end Struct;