----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2023 10:42:54 AM
-- Design Name: 
-- Module Name: ceng2010_lab2_q1 - Behavioral
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

entity ceng2010_lab2_q1 is
    Port (sw : in STD_LOGIC_VECTOR (5 downto 0);
          led : out STD_LOGIC_VECTOR (0 downto 0));
end ceng2010_lab2_q1;

architecture Behavioral of ceng2010_lab2_q1 is

begin

    with sw(5 downto 4) select
    led(0) <= sw(0) when "00",
              sw(1) when "01",
              sw(2) when "10",
              sw(3) when "11";

end Behavioral;
