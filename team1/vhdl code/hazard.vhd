LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity hazard is
port (
    Reg1Index: in std_logic_vector(3 downto 0);
    loadPop: in std_logic;
    IndexSrc1, IndexSrc2: in std_logic_vector(3 downto 0);
    NumOfSrcs: in std_logic_vector(1 downto 0);
    Disable: out std_logic
);
end entity;


architecture behavioure of hazard is
begin

    Disable <=  '1' when loadPop = '1' and ((NumOfSrcs = "01" and Reg1Index = IndexSrc1) or (NumOfSrcs = "10" and (Reg1Index = IndexSrc1 or Reg1Index = IndexSrc2))) else
                '0';

end;