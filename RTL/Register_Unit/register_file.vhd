library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity register_file is
    Port ( Din : in STD_LOGIC_VECTOR (7 downto 0);
           RST, CLOCK : in STD_LOGIC;
           EN1in, EN2in, EN3in, EN4in, EN5in, EN6in, EN7in, EN8in, EN9in, EN10in   : in STD_LOGIC;
           EN1out, EN2out, EN3out, EN4out, EN5out, EN6out, EN7out, EN8out, EN9out, EN10out : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end register_file;

architecture Behavioral of register_file is

signal s1,s2,s3,s4,S5,S6,S7,S8,S9,S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20: std_logic_vector(7 downto  0);
SIGNAL A0 : std_logic_vector(9 downto  0);

component tristate_buffer 
    Port ( buf_in : in STD_LOGIC_VECTOR (7 downto 0);
           en : in STD_LOGIC;
           buf_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component register_32bit 
    Port ( input32 : in STD_LOGIC_VECTOR (7 downto 0);
           reset, clk : in STD_LOGIC;
           output32 : out STD_LOGIC_VECTOR(7 downto 0));
end component;

--signal mux_in : std_logic_vector(39 downto 0);  -- 10 registers × 4 bits each = 40 bits
--signal mux_out : std_logic_vector(3 downto 0);

begin

buf1:  tristate_buffer port map(Din, EN1in, S1);
buf2:  tristate_buffer port map(Din, EN2in, S2);
buf3:  tristate_buffer port map(Din, EN3in, S3);
buf4:  tristate_buffer port map(Din, EN4in, S4);
buf5:  tristate_buffer port map(Din, EN5in, S5);
buf6:  tristate_buffer port map(Din, EN6in, S6);
buf7:  tristate_buffer port map(Din, EN7in, S7);
buf8:  tristate_buffer port map(Din, EN8in, S8);
buf9:  tristate_buffer port map(Din, EN9in, S9);
buf10:  tristate_buffer port map(Din, EN10in, S10);
reg1 : register_32bit port map ("00000011", RST, CLOCK, S11);
reg2 : register_32bit port map ("00001110", RST, CLOCK, S12);
reg3 : register_32bit port map (S3, RST, CLOCK, S13);
reg4 : register_32bit port map (S4, RST, CLOCK, S14);
reg5 : register_32bit port map (S5, RST, CLOCK, S15);
reg6 : register_32bit port map (S6, RST, CLOCK, S16);
reg7 : register_32bit port map (S7, RST, CLOCK, S17);
reg8 : register_32bit port map (S8, RST, CLOCK, S18);
reg9 : register_32bit port map (S9, RST, CLOCK, S19);
reg10: register_32bit port map (S10, RST, CLOCK, S20);
buf11:  tristate_buffer port map(S11, EN1out, Dout);
buf12:  tristate_buffer port map(S12, EN2out, Dout);
buf13:  tristate_buffer port map(S13, EN3out, Dout);
buf14:  tristate_buffer port map(S14, EN4out, Dout);
buf15:  tristate_buffer port map(S15, EN5out, Dout);
buf16:  tristate_buffer port map(S16, EN6out, Dout);
buf17:  tristate_buffer port map(S17, EN7out, Dout);
buf18:  tristate_buffer port map(S18, EN8out, Dout);
buf19:  tristate_buffer port map(S19, EN9out, Dout);
buf20:  tristate_buffer port map(S20, EN10out, Dout);

--A0 <= (EN1out & EN2out & EN3out & EN4out & EN5out & EN6out & EN7out & EN8out & EN9out & EN10out) ;

--process(A0, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20)
--begin
--    case A0 is
--        when "1000000000" => Dout <= S20;
--        when "0100000000" => Dout <= S18;
--        when "0010000000" => Dout <= S18;
--        when "0001000000" => Dout <= S17;
--        when "0000100000" => Dout <= S16;
--        when "0000010000" => Dout <= S15;
--        when "0000001000" => Dout <= S14;
--        when "0000000100" => Dout <= S13;
--        when "0000000010" => Dout <= S12;
--        when "0000000001" => Dout <= S11;
--        when others       => Dout <= (others => 'Z');
--    end case;
--end process;

 


end Behavioral;
