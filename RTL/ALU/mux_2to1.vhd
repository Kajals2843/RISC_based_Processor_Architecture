library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
    Port (
        a     : in  std_logic_vector(7 downto 0);
        b     : in  STD_LOGIC_vector(7 downto 0);
        sel   : in  STD_LOGIC;
        y     : out STD_LOGIC_vector(7 downto 0)
    );
end mux_2to1;

architecture Behavioral of mux_2to1 is
begin
    process(a, b, sel)
    begin
        if sel = '0' then
            y <= a;
        else
            y <= b;
        end if;
    end process;
end Behavioral;