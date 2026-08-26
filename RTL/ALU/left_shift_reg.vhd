library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity left_shift_reg is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        din   : in  STD_LOGIC_VECTOR(7 downto 0);  -- Parallel input
        q     : out STD_LOGIC_VECTOR(7 downto 0)   -- Parallel output
    );
end left_shift_reg;

architecture Behavioral of left_shift_reg is
    signal temp : STD_LOGIC_VECTOR(7 downto 0);
    signal load_done : std_logic := '0';
   
begin
    process(clk, reset)
    begin
         
    if rising_edge(clk) then
            if reset = '1' then
                temp <= din;  -- Load on reset
            else
                temp <= temp(6 downto 0) & '0';  -- Shift left
            end if;
        end if;
    end process;

    q <= temp;
end Behavioral;
