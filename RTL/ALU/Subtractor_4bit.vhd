library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- or use numeric_std

entity Subtractor_4bit is
    Port (
        A      : in  STD_LOGIC_VECTOR (7 downto 0);
        B      : in  STD_LOGIC_VECTOR (7 downto 0);
    --    Bin    : in std_logic;
        Diff   : out STD_LOGIC_VECTOR (7 downto 0);
        Borrow : out STD_LOGIC
    );
end Subtractor_4bit;

architecture Behavioral of Subtractor_4bit is
    signal temp : STD_LOGIC_VECTOR (8 downto 0); -- for result including borrow
begin
  
        temp <= ('0' & A) - ('0' & B); -- extend to 5 bits to catch borrow
        Diff <= temp(7 downto 0);
        Borrow <= not temp(8); -- borrow occurs when MSB is 0

end Behavioral;
