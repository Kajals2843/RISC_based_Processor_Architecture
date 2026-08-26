library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity register_32bit is
    Port ( input32 : in STD_LOGIC_VECTOR (7 downto 0);
           reset, clk : in STD_LOGIC;
           output32 : out STD_LOGIC_VECTOR(7 downto 0));
end register_32bit;

architecture Behavioral of register_32bit is

begin
process(reset, clk)
begin
    if reset = '1' then
        output32 <= (others => '0');
    elsif clk'event and clk = '1' then
        
            output32 <= input32;
        
   END IF;
end process;
end Behavioral;
