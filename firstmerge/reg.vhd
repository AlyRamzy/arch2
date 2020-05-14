
Library IEEE;
USE IEEE.std_logic_1164.all;

entity reg2 is 
generic (n:integer := 5);
port(	clk : in std_logic ; 
	reset : in std_logic ; 
	set : in std_logic;
	enable : in std_logic ; 
	d	: in std_logic_vector(n-1 downto 0);
	q	: out std_logic_vector(n-1 downto 0)
);
end entity;

architecture regarc of reg2 is
begin
process (clk,reset,enable)
begin

if rising_edge(clk)then 
if  (reset = '1') then q <= (OTHERS => '0');
elsif (set ='1') then q <= (OTHERS => '1');
elsif  enable = '1' then q <= d;
end if ;
end if;
end process;

end architecture;

