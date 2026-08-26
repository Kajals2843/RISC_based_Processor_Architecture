----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/21/2025 12:12:50 AM
-- Design Name: 
-- Module Name: pass - Behavioral
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


entity pass is
  Port ( alu_in : in std_logic_vector(7 downto 0);
         alu_out : out std_logic_vector(7 downto 0));
end pass;

architecture Behavioral of pass is

begin
 
alu_out <= alu_in;

end Behavioral;
