
Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity execute_flush is
    port ( 
             call, jmp, jz, zero_flag: in std_logic;
           pc_from_reg, reset_D, reset_F : out std_logic);
    end entity;


Architecture behavioral of  execute_flush is   
        begin   
            process (call, jmp, jz, zero_flag)
            begin
                if call = '1' or jmp = '1'  or (jz = '1'  and  zero_flag = '1') then
                     reset_F <= '1'; reset_D <= '1'; pc_from_reg <= '1'; 
                else reset_F <= '0'; reset_D <= '0'; pc_from_reg <= '0'; 
                end if;
            end process;
end Architecture;