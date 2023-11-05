----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2023 07:27:43 PM
-- Design Name: 
-- Module Name: div2 - Behavioral
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

entity div2 is
    Port (btnC : in std_logic;
        led : out std_logic_vector(0 downto 0));
end div2;

architecture Behavioral of div2 is
component ceng2010_lab5_q1
    Port(sw: in std_logic_vector(0 downto 0);
        btnC: in std_logic;
        led: out std_logic_vector(1 downto 0));
end component;
signal QBar2D: std_logic := '0';
begin
    D1: ceng2010_lab5_q1 port map(
        sw(0) => QBar2D, btnC => btnC, led(0) => led(0), led(1) => QBar2D);

end Behavioral;
