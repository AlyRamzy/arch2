Library ieee;
use ieee.std_logic_1164.all;

entity fetch_status is
    port ( input: in std_logic_vector(1 downto 0);
            clk,rst: in std_logic;
            output: out std_logic_vector (3 downto 0));
    end entity;


Architecture fsm of fetch_status is
        
            type states is (State_Zero,State_One,State_Two);
            signal current_state : states := State_Zero;
            signal next_state : states := State_Zero;
        
        begin
        
            --calculate state --> Combinational or sequential ? Why
            --Output calculation
            process (current_state,input) 
                begin
                    
                    case current_state is
                        when State_Zero =>
                            if input = "00" then next_state <= State_Zero; output <= "0000"; --others
                            elsif input = "01" then next_state <= State_One; output <= "0000"; --memory (1st)
                            else next_state <= State_One; output <= "0010"; --rti, int
                            end if;
                        when State_One =>
                            if input = "11" then next_state <= State_Two; output <= "0110"; --others
                            elsif input = "10" then next_state <= State_Zero; output <= "0100"; --rti
                            else  next_state <= State_Zero; output <= "0101";  --memory
                            end if;
                        when State_Two =>
                            next_state <= State_Zero; output <= "1000"; --others
                            
                    end case;
                end process;
            
            --store new state --> Combinational or sequential ? Why
            process (clk,rst)
            begin
              if rst = '1' then
                    current_state <= State_Zero;
              elsif rising_edge(clk) then 
                     current_state <= next_state;
              end if;
            end process;
        
               
end Architecture;