Library ieee;
use ieee.std_logic_1164.all;

entity fetch_decode is
    port ( clk : in std_logic;
            opcode :  in std_logic_vector(4 downto 0);
            interrupt : in std_logic;
            swap, wb: out std_logic;
            mem_rti_int_others: out  std_logic_vector(1 downto 0));
    end entity;


Architecture behavioral of fetch_decode is
    signal a,b,c,d,e,f : std_logic;
begin 
    a <= interrupt;
    b <= opcode(4);
    c <= opcode(3);
    d <= opcode(2);
    e <= opcode(1);
    f <= opcode(0);
    mem_rti_int_others(1) <= (a and clk ) or ( b and c and d and (not e) and (not f));
    mem_rti_int_others(0) <= (a and clk )or ( (not b) and c and e and (not f) ) or
                            ( (not b) and c and d and e ) or
                            (b and (not c) and (not d) and e ) or
                            (b and (not c) and d and (not e) and (not f )) ;


    process(opcode) 
    begin
        if opcode = "01000" then swap <= '1'; else swap <= '0'; end if;
    end process;

   
    process(opcode)
    begin
        if opcode = "00001" or opcode = "00010"  or opcode = "00011" or opcode = "00101"  
          or opcode = "01000" or opcode <= "01001"  or opcode = "01010"  or opcode = "01011"
          or opcode <= "01100" or opcode <= "01101" or opcode = "01110"  or opcode = "01111"
          or opcode <= "10001" or opcode <= "10010" or opcode = "10011" 
          then wb <= '1' ; else wb  <= '0';
          end if;
    end process;     
 end Architecture;