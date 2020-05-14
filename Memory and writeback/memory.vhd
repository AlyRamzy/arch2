LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity mux2 is
port(
    input1, input2: in std_logic_vector(31 downto 0);
    sel: in std_logic;
    output: out std_logic_vector(31 downto 0)
);
end entity mux2;

architecture bahvioure of mux2 is
begin

    output <=   input1 when sel = '0' else
                input2 when sel = '1';

end;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity mux4 is
port(
    input1, input2, input3, input4: in std_logic_vector(31 downto 0);
    sel: in std_logic_vector(1 downto 0);
    output: out std_logic_vector(31 downto 0)
);

end entity mux4;

architecture bahvioure of mux4 is
begin

    output <=   input1 when sel = "00" else
                input2 when sel = "01" else
                input3 when sel = "10" else
                input4 when sel = "11";

end;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity memory is
port (
    input: in std_logic_vector(156 downto 0);
    clk: in std_logic;
    output: out std_logic_vector(77 downto 0)
);
end entity memory;


architecture bahvioure of memory is
    signal opcode: std_logic_vector(4 downto 0);
    signal editFlag, LoadPop, swap, RetRti, RTIfirst, reset: std_logic;
    signal Reg1, Reg2, Reg3, Reg4: std_logic_vector(31 downto 0);
    signal R1, R2: std_logic_vector(3 downto 0);
    signal selectors: std_logic_vector(3 downto 0);
    signal wb: std_logic_vector(3 downto 0);
    signal Interrupt: std_logic_vector(1 downto 0);

    signal memoryAddress, memoryOutput: std_logic_vector(31 downto 0);
    signal sel: std_logic_vector(1 downto 0);
    signal load: std_logic;

    signal Reg1output, Reg2output: std_logic_vector(31 downto 0);
    
begin
    opcode <= input(156 downto 152);
    reset <= input(151);
    editFlag <= input(150);
    loadPop <= input(149);
    swap <= input(148);
    RetRti <= input(147);
    RTIfirst <= input(146);
    Interrupt <= input(145 downto 144);
    Reg1 <= input(143 downto 112);
    Reg2 <= input(111 downto 80);
    Reg3 <= input(79 downto 48);
    Reg4 <= input(47 downto 16);
    R1 <= input(15 downto 12);
    R2 <= input(11 downto 8);
    selectors<= input(7 downto 4);      --j h0 h1 i
    WB <= input(3 downto 0);

    sel <= reset & selectors(3);
    MJ: entity work.mux4 port map (Reg2, "00000000000000000000000000000010", "00000000000000000000000000000000", "00000000000000000000000000000000", sel, memoryAddress);

    load <= '1' when opcode = "10001" or opcode = "10011" or opcode = "11011" or opcode = "11100"; --pop load ret rti
    memory: entity work.ram2 port map (clk, wb(3), load, memoryAddress, Reg1, memoryOutput);

    MH: entity work.mux4 port map (Reg1, memoryOutput, Reg4, "00000000000000000000000000000000", selectors(2 downto 1), Reg1output);

    MI: entity work.mux2 port map (Reg2, Reg3, selectors(0), Reg2output);

    output <= editFlag & swap & Reg1output & Reg2output & R1 & R2 & wb;

end;