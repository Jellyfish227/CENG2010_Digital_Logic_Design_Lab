----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2023 05:05:21 PM
-- Design Name: 
-- Module Name: ceng2010_lab3_q1 - Behavioral
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

entity ceng2010_lab3_q1 is
    Port ( sw: in std_logic_vector(6 downto 0);
           seg: out std_logic_vector(6 downto 0);
           an: out std_logic_vector(3 downto 0);
           dp: out std_logic;
           btnC: in std_logic
    );
end ceng2010_lab3_q1;

architecture Behavioral of ceng2010_lab3_q1 is

signal isRight: boolean := TRUE;

begin

    dp <= '1';
    process (btnC)
    begin
        if RISING_EDGE(btnC) then
            isRight <= not isRight;
        else 
            isRight <= isRight;
        end if;
        
        if (isRight) then
            an <= "1100";
        else
            an <= "0011";
        end if;
        
    end process;
    
    seg <= not sw;

end Behavioral;
