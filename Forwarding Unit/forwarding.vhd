
Library IEEE;
USE IEEE.std_logic_1164.all;

entity forwarding is 

port(
    -------------Inputs From Exec Stage ----------------
	R1_Exec : in std_logic_vector (3 downto 0 );
	R2_Exec : in std_logic_vector (3 downto 0 );
	R3_Exec : in std_logic_vector (3 downto 0 );
	R4_Exec : in std_logic_vector (3 downto 0 );
	OpCode_Exec : in std_logic_vector (4 downto 0 );
	InterruptStatus_Exec:in std_logic_vector(1 downto 0 );
	WB_Exec : in std_logic_vector (3 downto 0 ); --This is writeback signals and will be used with the opcode to check for rti first or second 
	-----------Inputs From Memory Stage --------------
	R1_Mem : in std_logic_vector (3 downto 0 );
	R2_Mem : in std_logic_vector (3 downto 0 );
	Reg1_Mem: in std_logic_vector(31 downto 0 );
	Reg2_Mem: in std_logic_vector(31 downto 0 );
	Reg3_Mem: in std_logic_vector(31 downto 0 );
	Reg4_Mem: in std_logic_vector(31 downto 0 );
	OpCode_Mem : in std_logic_vector (4 downto 0 );
	InterruptStatus_Mem:in std_logic_vector(1 downto 0 );
	WB_Mem : in std_logic_vector (3 downto 0 ); --This is writeback signals and will be used with the opcode to check for rti first or second 
	------------Inputs From WriteBack Stage -----------------
	R1_WB : in std_logic_vector (3 downto 0 );
	R2_WB : in std_logic_vector (3 downto 0 );
	Reg1_WB: in std_logic_vector(31 downto 0 );
	Reg2_WB: in std_logic_vector(31 downto 0 );
	OpCode_WB : in std_logic_vector (4 downto 0 );
	InterruptStatus_WB:in std_logic_vector(1 downto 0 );
	WB_WB : in std_logic_vector (3 downto 0 ); --This is writeback signals and will be used with the opcode to check for rti first or second 
	---------Outputs From The Forwarding unit to The Exec Stage--------------------------------
	Reg1_FW : out std_logic_vector(31 downto 0 );
	Reg2_FW : out std_logic_vector(31 downto 0 );
	Reg3_FW : out std_logic_vector(31 downto 0 );
	Reg1_Selector : out std_logic ;
	Reg2_Selector : out std_logic ;
	Reg3_Selector : out std_logic 
);
end entity;

architecture forwardingArch of forwarding is

signal group1_Exec ,group2_Exec,group3_Exec,group4_Exec,group5_Exec: std_logic;

signal group1_Mem,group2_Mem,group3_Mem: std_logic;

signal group1_WB, group2_WB:std_logic;


begin



group1_Exec <=  '1' when (OpCode_Exec="01010" or OpCode_Exec= "01110" or OpCode_Exec = "01111" or 

 OpCode_Exec ="10100" or OpCode_Exec="00001" or OpCode_Exec= "00011" or OpCode_Exec = "00010" or OpCode_Exec = "00100" or 
OpCode_Exec = "01000" or OpCode_Exec = "01100" or OpCode_Exec = "01101" or 
OpCode_Exec = "01001" or OpCode_Exec = "01011" or OpCode_Exec = "10000" or 
OpCode_Exec = "11000" or OpCode_Exec = "11001") else
         '0' ;

group2_Exec <= '1' when (OpCode_Exec = "01000" or OpCode_Exec = "01100" or OpCode_Exec = "01101" or 
OpCode_Exec = "01001" or OpCode_Exec = "01011") else 
'0';


group3_Exec <= '1' when ( OpCode_Exec = "10000" or OpCode_Exec = "10001" or OpCode_Exec="11010" or 
OpCode_Exec = "11011" or OpCode_Exec = "11100" or InterruptStatus_Exec = "01" or InterruptStatus_Exec = "11") else 
'0';

group4_Exec <= '1' when( OpCode_Exec = "11000" or OpCode_Exec = "00001" or OpCode_Exec="01100" or OpCode_Exec="01101" ) else '0';


group5_Exec <= '1' when ( OpCode_Exec = "11010" or InterruptStatus_Exec ="11") else '0';


group1_Mem <= '1' 	 when (OpCode_Mem="01010" or OpCode_Mem= "01110" or OpCode_Mem = "01111" or
OpCode_Mem = "10010" or OpCode_Mem = "10011" or OpCode_Mem ="00001" or 
OpCode_Mem = "00010" or OpCode_Mem = "00011" or OpCode_Mem  = "00101" or
OpCode_Mem = "01100" or OpCode_Mem = "01101" or OpCode_Mem = "01001" or
OpCode_Mem = "01000" or OpCode_Mem = "01011" or OpCode_Mem = "10001") else '0';

-- not inc dec OpCode_Mem="00001" or OpCode_Mem= "00011" or OpCode_Mem = "00010"
--and or add sub OpCode_Mem = "01100" or OpCode_Mem = "01101" or OpCode_Mem = "01001" or OpCode_Mem = "01011")
group2_Mem <= '1' when (OpCode_Mem = "10001" or OpCode_Mem = "01000" or OpCode_Mem ="11011" or 
(OpCode_Mem = "11100" and WB_Mem = "0010") or OpCode_Mem = "01010" or
OpCode_Mem = "01110" or OpCode_Mem = "01111" or 
OpCode_Mem="00001" or OpCode_Mem= "00011" or OpCode_Mem = "00010"or
OpCode_Mem = "01100" or OpCode_Mem = "01101" or OpCode_Mem = "01001" or OpCode_Mem = "01011")
else '0' ;


group3_Mem <= '1' when (OpCode_Mem = "10000" or OpCode_Mem = "11010" or 
InterruptStatus_Mem = "01" or InterruptStatus_Mem="11") else '0';


group1_WB <= '1' 	 when (OpCode_WB="01010" or OpCode_WB= "01110" or OpCode_WB = "01111" or
OpCode_WB = "10010" or OpCode_WB = "10011" or OpCode_WB ="00001" or 
OpCode_WB = "00010" or OpCode_WB = "00011" or OpCode_WB  = "00101" or
OpCode_WB = "01100" or OpCode_WB = "01101" or OpCode_WB = "01001" or
OpCode_WB = "01000" or OpCode_WB = "01011" or OpCode_WB = "10001") else '0';

group2_WB <= '1' when (OpCode_WB = "10001" or OpCode_WB = "01000" or OpCode_WB ="11011" or 
(OpCode_WB = "11100" and WB_WB = "0010") or OpCode_WB = "01010" or
OpCode_WB = "01110" or OpCode_WB = "01111" or 
OpCode_WB="00001" or OpCode_WB= "00011" or OpCode_WB = "00010"or
OpCode_WB = "01100" or OpCode_WB = "01101" or OpCode_WB = "01001" or OpCode_WB = "01011" or OpCode_WB="10000" or
OpCode_WB = "11010" or InterruptStatus_WB="01" or InterruptStatus_WB = "11" )
else '0' ;


Reg1_FW <= Reg1_Mem when ( group1_Exec = '1' and group1_Mem='1' and (R3_Exec=R1_Mem) ) else 
		  Reg2_Mem when ( group1_Exec = '1' and group2_Mem = '1' and (R3_Exec=R2_Mem)  ) else 
		  Reg3_Mem when ( group1_Exec = '1'and group3_Mem = '1' and (R3_Exec=R2_Mem)  ) else 
		  Reg1_WB when ( group1_Exec = '1' and group1_WB = '1' and (R3_Exec = R1_WB)  ) else 
		  Reg2_WB when ( group1_Exec = '1' and group2_WB='1' and (R3_Exec = R2_WB) ) else
		  (others => 'Z') ;
Reg1_Selector <= '1' when (  ( group1_Exec= '1' and group1_Mem= '1' and (R3_Exec=R1_Mem) ) or ( group1_Exec= '1' and group2_Mem= '1' and (R3_Exec=R2_Mem)  ) or ( group1_Exec= '1' and group3_Mem= '1' and (R3_Exec=R2_Mem)  )

or ( group1_Exec = '1' and group1_WB = '1' and (R3_Exec = R1_WB)  ) or( group1_Exec ='1' and group2_WB='1' and (R3_Exec = R2_WB) ) ) 
				else '0' ;


Reg2_FW <= Reg1_Mem when ( group2_Exec = '1' and group1_Mem='1' and (R4_Exec=R1_Mem) ) else 
		  Reg2_Mem when ( group2_Exec = '1' and group2_Mem = '1' and (R4_Exec=R2_Mem)  ) else 
		  Reg3_Mem when ( group2_Exec = '1'and group3_Mem = '1' and (R4_Exec=R2_Mem)  ) else 
		  Reg1_WB when ( group2_Exec = '1' and group1_WB = '1' and (R4_Exec = R1_WB)  ) else 
		  Reg2_WB when ( group2_Exec = '1' and group2_WB='1' and (R4_Exec = R2_WB) ) else
		  Reg1_Mem when ( group3_Exec = '1' and group1_Mem='1' and (R2_Exec=R1_Mem) ) else 
		  Reg2_Mem when ( group3_Exec = '1' and group2_Mem = '1' and (R2_Exec=R2_Mem)  ) else 
		  Reg3_Mem when ( group3_Exec = '1'and group3_Mem = '1' and (R2_Exec=R2_Mem)  ) else 
		  Reg1_WB when ( group3_Exec = '1' and group1_WB = '1' and (R2_Exec = R1_WB)  ) else 
		  Reg2_WB when ( group3_Exec ='1' and group2_WB='1' and (R2_Exec = R2_WB) ) else
		  (others => 'Z') ;
		  
Reg2_Selector <= '1' when ( ( group2_Exec = '1' and group1_Mem='1' and (R4_Exec=R1_Mem) ) or ( group2_Exec = '1' and group2_Mem = '1' and (R4_Exec=R2_Mem)  )
or ( group2_Exec = '1'and group3_Mem = '1' and (R4_Exec=R2_Mem)  ) or ( group2_Exec = '1' and group1_WB = '1' and (R4_Exec = R1_WB)  )
or ( group2_Exec ='1' and group2_WB='1' and (R4_Exec = R2_WB) ) or  ( group3_Exec = '1' and group1_Mem='1' and (R2_Exec=R1_Mem) ) 
or ( group3_Exec = '1' and group2_Mem = '1' and (R2_Exec=R2_Mem)  ) or ( group3_Exec = '1'and group3_Mem = '1' and (R2_Exec=R2_Mem)  )
or ( group3_Exec = '1' and group1_WB = '1' and (R2_Exec = R1_WB)  ) or ( group3_Exec = '1' and group2_WB='1' and (R2_Exec = R2_WB) )) else '0';



Reg3_FW <=  Reg1_Mem when ( group4_Exec = '1' and group1_Mem='1' and (R2_Exec=R1_Mem) ) else 
		  Reg2_Mem when ( group4_Exec = '1' and group2_Mem = '1' and (R2_Exec=R2_Mem)  ) else 
		  Reg3_Mem when ( group4_Exec = '1'and group3_Mem = '1' and (R2_Exec=R2_Mem)  ) else 
		  Reg1_WB when ( group4_Exec = '1' and group1_WB = '1' and (R2_Exec = R1_WB)  ) else 
		  Reg2_WB when ( group4_Exec ='1' and group2_WB='1' and (R2_Exec = R2_WB) ) else
		  Reg1_Mem when ( group5_Exec = '1' and group1_Mem='1' and (R1_Exec=R1_Mem) ) else 
		  Reg2_Mem when ( group5_Exec = '1' and group2_Mem = '1' and (R1_Exec=R2_Mem)  ) else 
		  Reg3_Mem when ( group5_Exec = '1'and group3_Mem = '1' and (R1_Exec=R2_Mem)  ) else 
		  Reg1_WB when ( group5_Exec = '1' and group1_WB = '1' and (R1_Exec = R1_WB)  ) else 
		  Reg2_WB when ( group5_Exec = '1' and group2_WB='1' and (R1_Exec = R2_WB) ) else
		  (others => 'Z') ;
		  
Reg3_Selector <= '1' when ( ( group4_Exec = '1' and group1_Mem='1' and (R2_Exec=R1_Mem) ) or ( group4_Exec = '1' and group2_Mem = '1' and (R2_Exec=R2_Mem)  )
or ( group4_Exec = '1'and group3_Mem = '1' and (R2_Exec=R2_Mem)  ) or ( group4_Exec = '1' and group1_WB = '1' and (R2_Exec = R1_WB)  )
or ( group4_Exec ='1' and group2_WB='1' and (R2_Exec = R2_WB) ) or  ( group5_Exec = '1' and group1_Mem='1' and (R1_Exec=R1_Mem) ) 
or ( group5_Exec = '1' and group2_Mem = '1' and (R1_Exec=R2_Mem)  ) or ( group5_Exec = '1'and group3_Mem = '1' and (R1_Exec=R2_Mem)  )
or ( group5_Exec = '1' and group1_WB = '1' and (R1_Exec = R1_WB)  ) or ( group5_Exec =  '1' and group2_WB='1' and (R1_Exec = R2_WB) )) else '0';




end architecture;

