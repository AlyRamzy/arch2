LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


entity writeBack is
port(
    input: in std_logic_vector(77 downto 0);
    Reg1out, Reg2out: out std_logic_vector(31 downto 0);
    R1out, R2out: out std_logic_vector(3 downto 0);
    w1,w2: out std_logic
);
end entity writeBack;


architecture arch of writeBack is

    signal editFlage, swap: std_logic;
    signal Reg1, Reg2: std_logic_vector(31 downto 0);
    signal R1, R2, wb: std_logic_vector(3 downto 0);

begin

    editFlage <= input(77);
    swap <= input(76);
    Reg1 <= input(75 downto 44);
    Reg2 <= input(43 downto 12);
    R1 <= input(11 downto 8);
    R2 <= input(7 downto 4);
    wb <= input(3 downto 0);

    Reg1out <= Reg1;
    Reg2out <= Reg2;

    R1out <= R1;
    R2out <= R2;

    w1 <= wb(2);
    w2 <= wb(1);

end arch ; -- arch