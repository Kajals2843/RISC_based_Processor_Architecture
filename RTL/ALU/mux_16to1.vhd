library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16to1 is
    Port (
        mux_sel : in STD_LOGIC_VECTOR(3 downto 0);   -- 4-bit select input
        I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15   : in STD_LOGIC_VECTOR(7 downto 0);  
        Y   : out STD_LOGIC_VECTOR(7 downto 0)                    -- Output
    );
end mux_16to1;

architecture Behavioral of mux_16to1 is
begin
    process(mux_sel, I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15)
    begin
        case mux_sel is
            when "0000" => Y <= I0;
            when "0001" => Y <= I1;
            when "0010" => Y <= I2;
            when "0011" => Y <= I3;
            when "0100" => Y <= I4;
            when "0101" => Y <= I5;
            when "0110" => Y <= I6;
            when "0111" => Y <= I7;
            when "1000" => Y <= I8;
            when "1001" => Y <= I9;
            when "1010" => Y <= I10;
            when "1011" => Y <= I11;
--            when "1100" => Y <= I12;
--            when "1101" => Y <= I13;
--            when "1110" => Y <= I14;
--            when "1111" => Y <= I15;
            when others => Y <= "00000000";
        end case;
    end process;
end Behavioral;
