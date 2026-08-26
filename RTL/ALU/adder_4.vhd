library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_4 is
    Port (
        A     : in  STD_LOGIC_VECTOR (7 downto 0);
        B     : in  STD_LOGIC_VECTOR (7 downto 0);
      --  Cin   : in  STD_LOGIC;
        Sum   : out STD_LOGIC_VECTOR (7 downto 0);
        Cout  : out STD_LOGIC
    );
end adder_4;

architecture Behavioral of adder_4 is
    signal temp : STD_LOGIC_VECTOR(8 downto 0);
begin

        temp <= ('0' & A) + ('0' & B) ;
        Sum  <= temp(7 downto 0);
        Cout <= temp(8);

    
end Behavioral;
