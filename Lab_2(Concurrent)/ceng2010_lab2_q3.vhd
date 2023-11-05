----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2023 11:08:18 AM
-- Design Name: 
-- Module Name: ceng2010_lab2_q3 - Behavioral
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

entity ceng2010_lab2_q3 is
    Port (sw: in std_logic_vector(1 downto 0);
          led: out std_logic_vector(1 downto 0));
end ceng2010_lab2_q3;

architecture Behavioral of ceng2010_lab2_q3 is

signal Q: std_logic;
signal QB: std_logic;

begin

    Q <= sw(1) nand QB;
    QB <= sw(0) nand Q;
    led(1) <= Q;
    led(0) <= QB;

end Behavioral;
