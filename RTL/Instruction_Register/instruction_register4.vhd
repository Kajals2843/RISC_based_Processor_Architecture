library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_register4 is
    Port (
        clk           : in  STD_LOGIC;
        rst           : in  STD_LOGIC;
        input_enable  : in  STD_LOGIC;
        data_in       : in  STD_LOGIC_VECTOR(7 downto 0);
        instr_out     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end instruction_register4;

architecture Behavioral of instruction_register4 is
    signal instruction : STD_LOGIC_VECTOR(7 downto 0);
begin

    -- Register loading logic (on clock edge)
    process(clk, rst)
    begin
        if rst = '1' then
            instruction <= (others => '0');
        elsif rising_edge(clk) then
            if input_enable = '1' then
                instruction <= data_in;
            end if;
        end if;
    end process;

    -- Conditional output
    process(instruction,  rst)
    begin
        if rst = '1' then
            instr_out <= (others => '0');
        else
            instr_out <= instruction;
--        else
--            instr_out <= (others => 'Z');
        end if;
    end process;

end Behavioral;
