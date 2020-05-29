library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity execute is
port(
	---- forwarding unit in
	reg_1_forwarding_in : in std_logic_vector(31 downto 0);
	reg_2_forwarding_in : in std_logic_vector(31 downto 0);
	flag_forwarding_in : in std_logic_vector(31 downto 0);

	---- forwarding unit selectors
	reg_1_forwarding_selector :in std_logic ;
	reg_2_forwarding_selector :in std_logic;
	flag_forwarding_selector :in std_logic;
	

	opcode : in std_logic_vector(4 downto 0);
	--- e->8 ff->76 gg->54 hh->32 i->1 j->0 
	in_selectors : in std_logic_vector(8 downto 0);
	in_reg_1 : in std_logic_vector(31 downto 0);
	in_reg_2 : in std_logic_vector(31 downto 0);
	in_reg_3 : in std_logic_vector(31 downto 0);
	edit_flag :in std_logic;
	inturrupt: in std_logic_vector(1 downto 0);

	out_reg_1 : out std_logic_vector(31 downto 0);
	out_reg_2 : out std_logic_vector(31 downto 0);
	out_reg_3 : out std_logic_vector(31 downto 0);
	out_reg_4 : out std_logic_vector(31 downto 0);
	out_selectors :out std_logic_vector(3 downto 0);
	out_port:out std_logic_vector(31 downto 0);
	
	-- for execute flush
	Jz, Jmp, Call, Zeroflage: out std_logic
	);




end execute;

architecture execute_arch of execute is
component ALU 
port(
	
	---no inturrupt>00  first>01  second>10 third>11
	inturrupt :in std_logic_vector(1 downto 0);
	opcode : in std_logic_vector(4 downto 0);
	in_1 : in std_logic_vector(31 downto 0);
	in_2 : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0);
	--- carry->2 negative->1 zero->0
	flags : out std_logic_vector(2 downto 0));
	--temp2: out unsigned(31 downto 0));
end component;

	----alu signals
	signal alu_inturrupt :std_logic_vector(1 downto 0);
	signal alu_opcode : std_logic_vector(4 downto 0);
	signal alu_in_1 : std_logic_vector(31 downto 0);
	signal alu_in_2 : std_logic_vector(31 downto 0);
	signal alu_output : std_logic_vector(31 downto 0);
	--- carry->2 negative->1 zero->0
	signal alu_flags : std_logic_vector(2 downto 0);
	signal temp2:unsigned (31 downto 0);

	
	---- forwarding unit out
	signal reg_1_forwarding_out : std_logic_vector(31 downto 0);
	signal reg_2_forwarding_out : std_logic_vector(31 downto 0);
	signal flag_forwarding_out : std_logic_vector(31 downto 0);


	---- output edit flag mux
	signal edit_flag_mux_out : std_logic_vector(31 downto 0);
begin
	-- and2 component instance 
	alu_comp: ALU port map(alu_inturrupt,alu_opcode,alu_in_1,alu_in_2,alu_output,alu_flags);

	----assigned without muxes
	out_reg_3 <=alu_output;
	out_reg_4 <=in_reg_3;
	out_selectors<=in_selectors(3 downto 0);
	alu_in_2<=reg_2_forwarding_out;
	alu_opcode<=opcode;
	alu_inturrupt<=inturrupt;


	-----assign output port----
	out_port <=reg_1_forwarding_out  when (opcode="00100") else
         "00000000000000000000000000000000"  ;

	----M1 forwarding for reg 1
	reg_1_forwarding_out <=in_reg_1  when (reg_1_forwarding_selector='0') else
         reg_1_forwarding_in ;


	----M2 forwarding for reg 2
	reg_2_forwarding_out <=in_reg_2  when (reg_2_forwarding_selector='0') else
         reg_2_forwarding_in ;


	----M3 forwarding for flags
	flag_forwarding_out <=  in_reg_3 when (flag_forwarding_selector='0') else
         flag_forwarding_in ;



	----edit flag mux
	edit_flag_mux_out <=    --- instruction edit in carry flag
				 flag_forwarding_out(31 downto 3)&alu_flags(2)&flag_forwarding_out(1 downto 0) when (edit_flag='1' and (opcode="01110" or opcode="01111") and alu_in_2/="00000000000000000000000000000000" ) else 
				---flag_forwarding_out when (edit_flag='1' and (opcode="01110" or opcode="01111") and alu_in_2 ="00000000000000000000000000000000" ) else   
				--- instruction edit in negative and zero flag
				flag_forwarding_out(31 downto 2)&alu_flags(1 downto 0) when (edit_flag='1' and (opcode="00001" or opcode="00010" or opcode="00011" or opcode="01001" or opcode="01010" or opcode="01011" or opcode="01100" or opcode="01101") ) else
                                flag_forwarding_out;

	--edit_flag_mux_out<="00000000000000000000000000000010";


	----ME by selector e
	alu_in_1 <= "00000000000000000000000000000010" when (in_selectors(8)='0') else
         reg_1_forwarding_out ;


	----MG by selectors gg 
	out_reg_2 <=    reg_2_forwarding_out  when (in_selectors(5 downto 4)="00") else
			edit_flag_mux_out	when (in_selectors(5 downto 4)="01") else
			reg_1_forwarding_out when (in_selectors(5 downto 4)="11") else
         		alu_output ;

	----MF by selectors ff 
	out_reg_1 <=    reg_1_forwarding_out  when (in_selectors(7 downto 6)="00") else
			alu_output	when (in_selectors(7 downto 6)="01") else
			reg_2_forwarding_out when (in_selectors(7 downto 6)="10") else
         		edit_flag_mux_out ;

	Jz <= '1' when opcode = "11000" else
			'0';

	Jmp <= '1' when opcode = "11001" else
			'0';

	Call <= '1' when opcode = "11010" else
			'0';

	Zeroflage <= alu_flags(0);

end execute_arch;

