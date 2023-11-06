library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity q1 is
    Port ( clk : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           btnC : in STD_LOGIC; -- reset
           btnL : in STD_LOGIC; -- rotate left
           btnR : in STD_LOGIC; -- rotate right
           an : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           seg : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end q1;

architecture Behavioral of q1 is

signal displayed_number: STD_LOGIC_VECTOR (15 downto 0);
-- counting decimal number to be displayed on 4-digit 7-segment display
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(1 downto 0);
-- the other 2-bit for creating 4 LED-activating signals
-- count         0    ->  1  ->  2  ->  3
-- activates    LED1    LED2   LED3   LED4
-- and repeat
signal rst : STD_LOGIC;
signal seg_display : STD_LOGIC_VECTOR(6 downto 0);
signal first_digit : STD_LOGIC_VECTOR(3 downto 0) := "0111";
signal second_digit : STD_LOGIC_VECTOR(3 downto 0) := "1000";
signal third_digit : STD_LOGIC_VECTOR(3 downto 0) := "1001";
signal fourth_digit : STD_LOGIC_VECTOR(3 downto 0) := "1010";

begin

rst <= btnC;
seg_display <= seg;
-- VHDL code for BCD to 7-segment decoder
-- Cathode patterns of the 7-segment LED display 
process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => seg_display <= "0000001"; -- "0"     
    when "0001" => seg_display <= "1001111"; -- "1" 
    when "0010" => seg_display <= "0010010"; -- "2" 
    when "0011" => seg_display <= "0000110"; -- "3" 
    when "0100" => seg_display <= "1001100"; -- "4" 
    when "0101" => seg_display <= "0100100"; -- "5" 
    when "0110" => seg_display <= "0100000"; -- "6" 
    when "0111" => seg_display <= "0001111"; -- "7" 
    when "1000" => seg_display <= "0000000"; -- "8"     
    when "1001" => seg_display <= "0000100"; -- "9" 
    when "1010" => seg_display <= "0000010"; -- a
    when "1011" => seg_display <= "1100000"; -- b
    when "1100" => seg_display <= "0110001"; -- C
    when "1101" => seg_display <= "1000010"; -- d
    when "1110" => seg_display <= "0110000"; -- E
    when "1111" => seg_display <= "0111000"; -- F
    end case;
end process;

-- 7-segment display controller
-- generate refresh period of 10.5ms
process(clk,reset)
begin 
    if(reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clk)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;

 LED_activating_counter <= refresh_counter(19 downto 18);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        an <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= displayed_number(15 downto 12);
        -- the first hex digit of the 16-bit number
    when "01" =>
        an <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= displayed_number(11 downto 8);
        -- the second hex digit of the 16-bit number
    when "10" =>
        an <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= displayed_number(7 downto 4);
        -- the third hex digit of the 16-bit number
    when "11" =>
        an <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= displayed_number(3 downto 0);
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;

displayed_number <= first_digit & second_digit & third_digit & third_digit;


end Behavioral;