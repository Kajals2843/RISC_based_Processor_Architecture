library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter is
    Port (
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        din : in std_logic_vector(7 downto 0);
--        PC_in, PC_out : in std_logic;
        pc  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ProgramCounter;

architecture Structural of ProgramCounter is

    component pc_reg
        Port (
            clk  : in  STD_LOGIC;
            rst  : in  STD_LOGIC;
            d    : in  STD_LOGIC_VECTOR(7 downto 0);
            q    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
--    component tristate_buffer 
--        Port ( buf_in : in STD_LOGIC_VECTOR (3 downto 0);
--           en : in STD_LOGIC;
--           buf_out : out STD_LOGIC_VECTOR (3 downto 0));
--        end component;


--SIGNAL S1,S2 : std_logic_vector(1 downto 0);

begin
    
--    U0: tristate_buffer port map(buf_in => din , en => PC_in ,  buf_out => S1 );
    U1: pc_reg Port map(clk => clk, rst => rst, d => din, q => pc);
--    U2: tristate_buffer port map(buf_in => S2 , en => PC_out ,  buf_out => pc );

 

end Structural;