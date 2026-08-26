library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_reg is
    Port (
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;
        d    : in  STD_LOGIC_VECTOR(7 downto 0);
        q    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end pc_reg;

architecture Behavioral of pc_reg is
    signal temp : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            temp <= (others => '0');
        elsif rising_edge(clk) then
            temp <= d;
        end if;
    end process;

    q <= temp;
end Behavioral;
