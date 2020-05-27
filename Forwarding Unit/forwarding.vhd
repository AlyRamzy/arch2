
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
	WB_Exec : in std_logic_vector (2 downto 0 ); --This is writeback signals and will be used with the opcode to check for rti first or second 
	-----------Inputs From Memory Stage --------------
	R1_Mem : in std_logic_vector (3 downto 0 );
	R2_Mem : in std_logic_vector (3 downto 0 );
	Reg1_Mem: in std_logic_vector(31 downto 0 );
	Reg2_Mem: in std_logic_vector(31 downto 0 );
	Reg3_Mem: in std_logic_vector(31 downto 0 );
	Reg4_Mem: in std_logic_vector(31 downto 0 );
	OpCode_Mem : in std_logic_vector (4 downto 0 );
	InterruptStatus_Mem:in std_logic_vector(1 downto 0 );
	WB_Mem : in std_logic_vector (2 downto 0 ); --This is writeback signals and will be used with the opcode to check for rti first or second 
	------------Inputs From WriteBack Stage -----------------
	R1_WB : in std_logic_vector (3 downto 0 );
	R2_WB : in std_logic_vector (3 downto 0 );
	Reg1_WB: in std_logic_vector(31 downto 0 );
	Reg2_WB: in std_logic_vector(31 downto 0 );
	OpCode_WB : in std_logic_vector (4 downto 0 );
	InterruptStatus_WB:in std_logic_vector(1 downto 0 );
	WB_WB : in std_logic_vector (2 downto 0 ); --This is writeback signals and will be used with the opcode to check for rti first or second 
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
begin
Reg1_FW <=  Reg2_Mem when (OpCode_Exec="01010" and OpCode_Exec= "1234124" and OpCode_Exec = "!42124"  ) else
         flag_forwarding_in ;
		 
		 
Reg2_FW <=  in_reg_3 when (flag_forwarding_selector='0') else
         flag_forwarding_in ;
		 
		 
Reg3_FW <=  in_reg_3 when (flag_forwarding_selector='0') else
         flag_forwarding_in ;
		 
		 
		 
Reg1_Selector <=  in_reg_3 when (flag_forwarding_selector='0') else
         flag_forwarding_in ;
		 
		 
Reg2_Selector <=  in_reg_3 when (flag_forwarding_selector='0') else
         flag_forwarding_in ;
		 
		 
Reg3_Selector <=  in_reg_3 when (flag_forwarding_selector='0') else
         flag_forwarding_in ;
		 

end architecture;

