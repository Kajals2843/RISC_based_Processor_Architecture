library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_decoder is
    Port (
        opcode  : in  STD_LOGIC_VECTOR(7 downto 0);
        control : out STD_LOGIC_VECTOR(15 downto 0)
    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is
begin
    process(opcode)
    begin
        case opcode is
            when "00000000" => 
                control <= "0000000000000001"; -- Instruction 0.........AND
            when "00000001" => 
                control <= "0000000000000010"; -- Instruction 1.........OR
            when "00000010" => 
                control <= "0000000000000100"; -- Instruction 2.........NOT
            when "00000011" => 
                control <= "0000000000001000"; -- Instruction 3.........XOR
            when "00000100" => 
                control <= "0000000000010000"; -- Instruction 4.........NAND
            when "00000101" => 
                control <= "0000000000100000"; -- Instruction 5.........NOR
            when "00000110" => 
                control <= "0000000001000000"; -- Instruction 6.........ADD
            when "00000111" => 
                control <= "0000000010000000"; -- Instruction 7.........SUB
            when "00001000" => 
                control <= "0000000100000000"; -- Instruction 8.........INC
            when "00001001" => 
                control <= "0000001000000000"; -- Instruction 9.........DEC
             when "00001010" => 
                control <= "0000010000000000"; -- Instruction 10.........XNOR
             when "00001011" => 
                control <= "0000100000000000"; -- Instruction 11.........ALU PASS
            when others => 
                control <= "0000000000000000"; -- Default (optional)
        end case;
    end process;
end Behavioral;
