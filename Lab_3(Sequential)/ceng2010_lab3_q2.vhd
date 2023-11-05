----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2023 07:27:14 PM
-- Design Name: 
-- Module Name: ceng2010_lab3_q2 - Behavioral
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

entity ceng2010_lab3_q2 is
    Port ( sw: in std_logic_vector(3 downto 0);
           btnC: in std_logic;
           led: out std_logic_vector(1 downto 0));
end ceng2010_lab3_q2;

architecture Behavioral of ceng2010_lab3_q2 is
signal QQbar: std_logic_vector(1 downto 0);
begin
    
    process(sw, btnC)
    begin    
        if sw(3 downto 2) = "11" then
            if FALLING_EDGE(btnC) then
                case sw(1 downto 0) is
                    when "00" => 
                        QQbar <= QQbar;
                    when "01" => 
                        QQbar <= "01";
                    when "10" => 
                        QQbar <= "10";
                    when "11" => 
                        QQbar <= not QQbar;
                end case;
            end if;
        elsif sw(3 downto 2) = "01" then
            QQbar <= "10";
        elsif sw(3 downto 2) = "10" then
            QQbar <= "01";
        elsif sw(3 downto 2) = "00" then
            QQbar <= "11";
        end if;
    end process;
   
   led <= QQbar;

end Behavioral;
