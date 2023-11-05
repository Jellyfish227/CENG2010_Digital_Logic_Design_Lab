----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2023 07:30:57 PM
-- Design Name: 
-- Module Name: div2_tb - Behavioral
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

entity div2_tb is
end div2_tb;

architecture Behavioral of div2_tb is
    component div2
        Port(btnC: in std_logic;
            led: out std_logic_vector(0 downto 0));
    end component;
    signal ext_input : std_logic;
    signal ext_output : std_logic;
    constant clock_period : time := 100ns;
begin
    uut : div2
    port map (btnC => ext_input,
    led(0) => ext_output);
    
    clock_process:process
    begin
        ext_input <= '0';
        wait for clock_period/2;
        ext_input <= '1';
        wait for clock_period/2;
    end process;
    
    stimuli : process
    begin
        wait for 100ns;
        wait for clock_period*10;
        wait;
    end process;
end Behavioral;

