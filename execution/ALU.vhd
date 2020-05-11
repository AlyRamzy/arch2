library ieee;
use ieee.std_logic_1164.all;

use IEEE.NUMERIC_STD.ALL;

entity ALU is
port(
	---no inturrupt>00  first>01  second>10 third>11
	inturrupt :in std_logic_vector(1 downto 0);
	opcode : in std_logic_vector(4 downto 0);
	in_1 : in std_logic_vector(31 downto 0);
	in_2 : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0);
	--- carry->2 negative->1 zero->0
	flags : out std_logic_vector(2 downto 0));
end ALU;


architecture ALU_arch of ALU is
	constant one : std_logic_vector(31 downto 0) :="00000000000000000000000000000001" ;
	
	signal out_temp :  std_logic_vector(31 downto 0);

begin 

	out_temp <=   not in_1  when (opcode="00001") else   --not
		  std_logic_vector(signed(in_1)+signed(one)) when (opcode="00010") else   --inc
		std_logic_vector(signed(in_1)-signed(one)) when (opcode="00011") else   --dec
		std_logic_vector(signed(in_1)+signed(in_2)) when (opcode="01001") else   --add
		std_logic_vector(signed(in_1)+signed(in_2)) when (opcode="01010") else   --Iadd
		std_logic_vector(signed(in_1)-signed(in_2)) when (opcode="01011") else   --sub
		in_1 and in_2	when (opcode="01100") else   --and
		in_1 or in_2	when (opcode="01101") else   --or
		std_logic_vector(shift_left(unsigned(in_1),to_integer(unsigned(in_2)))) when (opcode="01110") else   --shift left 
		std_logic_vector(shift_right(unsigned(in_1),to_integer(unsigned(in_2)))) when (opcode="01111") else   --shift right
		std_logic_vector(signed(in_2)-signed(in_1)) when (opcode="10000" or opcode="11010" or inturrupt="01" or inturrupt="11") else   --push --call --int_1st --int_3rd
		std_logic_vector(signed(in_2)+signed(in_1)) when (opcode="10001" or opcode="11011" or opcode="11100") else    --pop --ret --rti 
         		"00000000000000000000000000000000" ;
	

	



	output<=out_temp;

	---zero flag 
	flags(0)<=  '1' when (out_temp="00000000000000000000000000000000") else
         		'0' ;

	--- negative flag 
	flags(1)<=  '1' when (out_temp(31)='1') else
         		'0' ;

	----carry flag 
	flags(2)<=  in_1(32-to_integer(unsigned(in_2))) when (opcode="01110") else
			in_1(to_integer(unsigned(in_2))-1) when (opcode="01111") else
			'0';

end ALU_arch;
