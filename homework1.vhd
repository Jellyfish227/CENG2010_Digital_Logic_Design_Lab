library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL; 

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
    signal first : STD_LOGIC_VECTOR(3 downto 0) := "0111";
    signal second : STD_LOGIC_VECTOR(3 downto 0) := "1000";
    signal third : STD_LOGIC_VECTOR(3 downto 0) := "1001";
    signal fourth : STD_LOGIC_VECTOR(3 downto 0) := "1010";
    signal temp : STD_LOGIC_VECTOR(3 downto 0);
    signal x : STD_LOGIC_VECTOR(1 downto 0);

    type state_type is (S0, S1, S2, S3);
    signal state, next_state : state_type;

begin

    rst <= btnC;
    displayed_number <= first & second & third & fourth;

    SYNC_PROC : process (clk, rst)
    begin
        if (reset = '1') then
            state <= S0;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;
        -- TODO: mealy fsm implementation

    OUTPUT_DECODE : process (state, x)
    begin
        case (state) is 
            when (S0) =>
                first <= "0111";
                second <= "1000";
                third <= "1001";
                fourth <= "0000";
            when (S1) is
                first <= "0000";
                second <= "0111";
                thirsd <= "1000";
                fourth <= "1001";
            when (S2) is 
                first <= "1001";
                second <= "0000";
                third <= "0111";
                fourth <= "1000";
            when (S3) is 
                first <= "1000";
                second <= "1001";
                third <= "0000";
                fourth <= "0111";
        end case;
    end process;
#if 0
    OUTPUT_CTRL : process(btnL, btnR, rst, clk)
    begin
        if (rst = '1') then
            first <= "0111";
            second <= "1000";
            third <= "1001";
            fourth <= "1010";
            refresh_counter <= (others => '0');
        end if;
        if (rising_edge(btnL) and rising_edge(clk)) then --rotate left
            temp <= first;
            first <= second;
            second <= third;
            third <= fourth;
            fourth <= temp;
        end if;
        if (rising_edge(btnR) and rising_edge(clk)) then --rotate right
            temp <= fourth;
            fourth <= third;
            third <= second;
            second <= first;
            first <= temp;
        end if;
    end process;
#end if
    -- VHDL code for BCD to 7-segment decoder
    -- Cathode patterns of the 7-segment LED display 
    SEG_MAPPING : process(LED_BCD)
    begin
        case LED_BCD is
            when "0000" => seg <= "1000000"; -- "0"     
            when "0001" => seg <= "1111001"; -- "1" 
            when "0010" => seg <= "0100100"; -- "2" 
            when "0011" => seg <= "0110000"; -- "3" 
            when "0100" => seg <= "0011001"; -- "4" 
            when "0101" => seg <= "0010010"; -- "5" 
            when "0110" => seg <= "0000010"; -- "6" 
            when "0111" => seg <= "1111000"; -- "7" 
            when "1000" => seg <= "0000000"; -- "8"     
            when "1001" => seg <= "0010000"; -- "9" 
            when "1010" => seg <= "0100000"; -- a
            when "1011" => seg <= "0000011"; -- b
            when "1100" => seg <= "1000110"; -- C
            when "1101" => seg <= "0100001"; -- d
            when "1110" => seg <= "0000110"; -- E
            when "1111" => seg <= "0001110"; -- F
        end case;
    end process;

    -- 7-segment display controller
    -- generate refresh period of 10.5ms
    REFRESH_MECH : process(rst,clk)
    begin
        if(rising_edge(clk)) then
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

end Behavioral;