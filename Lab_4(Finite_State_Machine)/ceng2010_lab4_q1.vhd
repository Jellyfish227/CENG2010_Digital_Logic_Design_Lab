----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2023 05:03:50 PM
-- Design Name: 
-- Module Name: ceng2010_lab4_q1 - Behavioral
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

entity ceng2010_lab4_q1 is
    Port (sw: in std_logic_vector(0 downto 0);
        btnC: in std_logic;
        btnD: in std_logic;
        led: out std_logic_vector(7 downto 0)
    );
end ceng2010_lab4_q1;

architecture Behavioral of ceng2010_lab4_q1 is
    type state_type is (S0, S1, S2);
    signal previous_state, state, next_state : state_type;
    signal temp: std_logic;
begin
    SYNC_PROC : process (btnC, btnD)
    begin
	   if (btnD = '1') then
	       state <= S0;
	   elsif rising_edge(btnC) then
	       previous_state <= state;
	       state <= next_state;
	       temp <= sw(0);
	   end if;
    end process; 
    
	OUTPUT_DECODE : process (state, sw)
    begin
        led(0) <= '0';
        led(7 downto 5) <= "000";
        case (state) is
                when S0 =>
                    led(5) <= '1';
                    if (temp = '0') then
                        led(0) <= '0';
                    end if; 
                    
                    when S1 =>
                        led(6) <= '1';
				        if (temp = '1' and previous_state = S0) then
				            led(0) <= '0';
				        elsif (temp = '1' and previous_state = S1) then
				            led(0) <= '1';
                        end if;
                        
                    when S2 =>
                        led(7) <= '1';
                        if (temp = '0' and previous_state = S1) then
                            led(0) <= '1';
                        elsif (temp = '0' and previous_state = S2) then
                            led(0) <= '0';
                        end if;
                        
                    when others =>
                        led(0) <= '0';
		        end case;
	end process;
	
	NEXT_STATE_DECODE : process (state, sw)
	begin
		next_state <= state;
		case (state) is
			when S0 =>
				if (sw(0) = '1') then
					next_state <= S1;
				else
					next_state <= S0;
				end if;
			when S1 =>
			    if (sw(0) = '0') then
					next_state <= S2;
				else
					next_state <= S1;
				end if;
			when S2 => 
			    if (sw(0) = '1') then
			        next_state <= S1;
			    else
			        next_state <= S2;
			    end if;
			when others =>
				next_state <= S0;
		end case;
	end process; 

end Behavioral;
