library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_4bit is
    Port(A, B : in STD_LOGIC_VECTOR(7 downto 0);
         Y    : out STD_LOGIC_VECTOR(7 downto 0));
end AND_4bit;

architecture Struct of AND_4bit is
begin

        Y <= A and B;

end Struct;