library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOT_4bit is
    Port(A : in STD_LOGIC_VECTOR(7 downto 0);
         Y : out STD_LOGIC_VECTOR(7 downto 0));
end NOT_4bit;

architecture Struct of NOT_4bit is
begin

        Y <= not A;

end Struct;