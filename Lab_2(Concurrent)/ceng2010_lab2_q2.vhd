----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2023 10:57:57 AM
-- Design Name: 
-- Module Name: ceng2010_lab2_q2 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ceng2010_lab2_q2 is
    Port (sw: in std_logic_vector(3 downto 0);
          seg: out std_logic_vector(6 downto 0);
          an: out std_logic_vector(3 downto 0);
          dp: out std_logic);
end ceng2010_lab2_q2;

architecture Behavioral of ceng2010_lab2_q2 is

begin

    an <= "1110";
    dp <= '1';

    with sw select
    seg <= "1000000" when "0000", --0
           "1111001" when "0001", --1
           "0100100" when "0010", --2
           "0110000" when "0011", --3
           "0011001" when "0100", --4
           "0010010" when "0101", --5
           "0000010" when "0110", --6
           "1111000" when "0111", --7
           "0000000" when "1000", --8
           "0010000" when "1001", --9
           "0000110" when others;


end Behavioral;
