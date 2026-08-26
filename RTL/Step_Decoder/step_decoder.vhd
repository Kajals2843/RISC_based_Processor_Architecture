library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity step_decoder is
    Port (
        input_dec  : in  STD_LOGIC_VECTOR (2 downto 0);
        output_dec : out STD_LOGIC_VECTOR (7 downto 0)
    );
end step_decoder;

architecture Behavioral of step_decoder is
begin
    process(input_dec)
    begin
        case input_dec is
            when "000" => 
                output_dec <= "00000001";
            when "001" => 
                output_dec <= "00000010";
            when "010" => 
                output_dec <= "00000100";
            when "011" => 
                output_dec <= "00001000";
            when "100" => 
                output_dec <= "00010000";
            when "101" => 
                output_dec <= "00100000";
            when "110" => 
                output_dec <= "01000000";
            when "111" => 
                output_dec <= "10000000";
            when others => 
                output_dec <= "00000000"; 
        end case;
    end process;
end Behavioral;
