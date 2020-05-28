
Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity memory_flush is
    port ( 
             int_2nd, rti_1st, ret: in std_logic;
            reset_D, reset_F, reset_E, pc_form_mem : out std_logic);
    end entity;


Architecture behavioral of  memory_flush is   
        begin   
            process (int_2nd, rti_1st, ret)
            begin
                if int_2nd = '1' or rti_1st = '1' then reset_F <= '1'; reset_D <= '1'; pc_form_mem <= '1'; 
                elsif ret= '1' then  reset_F <= '1'; reset_D <= '1';  reset_E <= '1'; pc_form_mem <= '1';
                else reset_F <= '0'; reset_D <= '0';  reset_E <= '0'; pc_form_mem <= '0';
                end if;
            end process;

end Architecture;