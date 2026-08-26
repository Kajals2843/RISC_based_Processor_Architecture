----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/21/2025 12:20:51 AM
-- Design Name: 
-- Module Name: xnor_8bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity xnor_8bit is
    Port ( a,b : in STD_LOGIC_VECTOR (7 downto 0);
           q : out STD_LOGIC_VECTOR (7 downto 0));
end xnor_8bit;

architecture Behavioral of xnor_8bit is

begin

q <= a xnor b;

end Behavioral;
