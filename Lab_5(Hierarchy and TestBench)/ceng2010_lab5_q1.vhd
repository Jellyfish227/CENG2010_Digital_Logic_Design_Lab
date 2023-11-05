----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2023 04:56:47 PM
-- Design Name: 
-- Module Name: ceng2010_lab5_q1 - Behavioral
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

entity ceng2010_lab5_q1 is
    Port (sw: in std_logic_vector(0 downto 0);
        btnC: in std_logic;
        led: out std_logic_vector(1 downto 0));
end ceng2010_lab5_q1;

architecture Behavioral of ceng2010_lab5_q1 is
    signal Q : std_logic := '1';
    signal QBar : std_logic := '0';
    signal D : std_logic;
begin
    
process (btnC)
begin
    if (rising_edge(btnC)) then
        q <= sw(0);
        QBar <= not q;
    end if;
end process;
    led(0) <= q;
    led(1) <= QBar;

end Behavioral;
