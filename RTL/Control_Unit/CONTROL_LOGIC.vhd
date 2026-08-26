library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL_LOGIC is
    Port (
        read      : in  STD_LOGIC;
        write     : in  STD_LOGIC;
        wmfc      : in  STD_LOGIC;
        sel4      : in  STD_LOGIC;
        sely      : in  STD_LOGIC;
        op_and, op_or, op_not, op_nand, op_xor, op_nor, op_add, op_sub, op_inc, op_dec, op_xnor, op_alupass : in std_logic;
        alu_sel : out STD_LOGIC_VECTOR(3 downto 0);
        mux_sel    : out STD_LOGIC;
        mem_flag   : out STD_LOGIC;
        mem_fun    : out STD_LOGIC
    );
end CONTROL_LOGIC;

architecture Behavioral of CONTROL_LOGIC is
begin

    -- ALU select logic
    process(op_and, op_or, op_not, op_xor, op_nand, op_nor, op_add, op_sub, op_inc, op_dec)
begin
    if    op_and = '1' then alu_sel <= "0000";
    elsif op_or  = '1' then alu_sel <= "0001";
    elsif op_not = '1' then alu_sel <= "0010";
    elsif op_xor = '1' then alu_sel <= "0011";
    elsif op_nand= '1' then alu_sel <= "0100";
    elsif op_nor = '1' then alu_sel <= "0101";
    elsif op_add = '1' then alu_sel <= "0110";
    elsif op_sub = '1' then alu_sel <= "0111";
    elsif op_inc = '1' then alu_sel <= "1000";
    elsif op_dec = '1' then alu_sel <= "1001";
    elsif op_xnor = '1' then alu_sel <= "1010";
    elsif op_alupass = '1' then alu_sel <= "1011";
    else                     alu_sel <= "1111";  -- default or invalid
    end if;
end process;

    

    -- Mux select logic
    mux_sel <= '0' when sel4 = '1' else
               '1' when sely = '1' ;

    -- Memory flag control
    mem_flag <= wmfc;

    -- Memory function: read and write combined into 2-bit output
    mem_fun <= write;

end Behavioral;

