Library IEEE;
USE IEEE.std_logic_1164.all;

entity decode is 
port(	CLK: in std_logic ;
	rst : in std_logic ;
	--Input Prev Stage 
	Swap : in std_logic ;
	Wb	 : in std_logic ;
	PredResult: in std_logic;
	FetchStatus: in std_logic_vector (1 downto 0);
	Instruction: in std_logic_vector (31 downto 0);
	PC: in std_logic_vector (31 downto 0);
	Interrupt : in std_logic;
	InputPort : in std_logic_vector(31 downto 0 );
	--Input Write Back 
	RegWBData0: in std_logic_vector (31 downto 0);
	RegWBData1: in std_logic_vector (31 downto 0);
	RegIndex0 :in std_logic_vector(3 downto 0 );
	RegIndex1 :in std_logic_vector(3 downto 0 );
	WBEnable0: in std_logic;
	WBEnable1: in std_logic;
	--Output Next Stage 
	SwapOut : out std_logic ;
	load_pop : out std_logic ;
	Nu_Sources: out std_logic_vector (1 downto 0);
	JZ : out std_logic ;
	PredResultOut : out std_logic ;
	EditFlag : out std_logic ;
	RET : out std_logic ;
	RTI_First : out std_logic ;
	InterruptStatus :out std_logic_vector(1 downto 0) ;
	Reg1: out std_logic_vector (31 downto 0);
	Reg2: out std_logic_vector (31 downto 0);
	Reg3: out std_logic_vector (31 downto 0);
	R1 :out std_logic_vector(3 downto 0 );
	R2 :out std_logic_vector(3 downto 0 );
	R3 :out std_logic_vector(3 downto 0 );
	R4 :out std_logic_vector(3 downto 0 );
	OpcodeOut :out std_logic_vector(4 downto 0 );
	selectors :out std_logic_vector(8 downto 0 );
	WBOUT   :out  std_logic_vector(3 downto 0);
	--OUTPUT Reg For Testing 
	R0_RegFile :out std_logic_vector(31 downto 0 );
	R1_RegFile :out std_logic_vector(31 downto 0 );
	R2_RegFile :out std_logic_vector(31 downto 0 );
	R3_RegFile :out std_logic_vector(31 downto 0 );
	R4_RegFile :out std_logic_vector(31 downto 0 );
	R5_RegFile :out std_logic_vector(31 downto 0 );
	R6_RegFile :out std_logic_vector(31 downto 0 );
	R7_RegFile :out std_logic_vector(31 downto 0 );
	SP_RegFile :out std_logic_vector(11 downto 0 );
	Flag_RegFile :out std_logic_vector(3 downto 0 )
	);
END entity ;

architecture decodeArch of decode is 


signal R0_DATA , R1_DATA , R2_DATA , R3_DATA , R4_DATA , R5_DATA , R6_DATA , R7_DATA: std_logic_vector (31 downto 0);
signal SP_DATA :std_logic_vector (11 downto 0 );
signal R0_Input,R1_Input,R2_Input,R3_Input,R4_Input,R5_Input,R6_Input,R7_Input,SP_Input : std_logic_vector(31 downto 0 );
signal R0_Enable,R1_Enable,R2_Enable,R3_Enable,R4_Enable,R5_Enable,R6_Enable,R7_Enable,SP_Enable,flag_Enable: std_logic;
signal R0_check1,R0_check2,R1_check1,R1_check2,R2_check1,R2_check2,R3_check1,R3_check2,R4_check1,R4_check2,R5_check1,R5_check2,R6_check1,R6_check2,R7_check1,R7_check2,SP_Check1,SP_Check2,flag_Check1,flag_Check2 :std_logic ;
signal Flag_Data,Flag_Input :std_logic_vector(3 downto 0 );
signal opcode : std_logic_vector (4 downto 0 );
signal AA , BB,CC,DD : std_logic_vector(1 downto 0);
signal r1signal,r2signal,r3signal,r4signal :std_logic_vector(3 downto 0 );
signal a1,a0,b1,b0,c1,c0,d1,d0,e,f1,f0,g1,g0,h1,h0,i,j,k,w0,w1,w2,writeOut :std_logic;
signal InputRegFile1,InputRegFile2 : std_logic_vector( 31 downto 0 );
signal SelectorInputRegFile2 : std_logic_vector (3 downto 0 );
signal s : std_logic; --sign of the Immediate Value for padding
begin 
--Output Signals for next Stage 
R0_RegFile <= R0_DATA;
R1_RegFile <= R1_DATA;
R2_RegFile <= R2_DATA;
R3_RegFile <= R3_DATA;
R4_RegFile <= R4_DATA;
R5_RegFile <= R5_DATA;
R6_RegFile <= R6_DATA;
R7_RegFile <= R7_DATA;
SP_RegFile <= SP_DATA;
Flag_RegFile <= Flag_Data;
process (opcode,FetchStatus,Interrupt) 
        begin
            
            a1 <= '0';
			a0 <= '0';
			b1 <= '0';
			b0 <= '0';
			c1 <= '0';
			c0 <= '0';
			d1 <= '0';
			d0 <= '0';
			e <= '0';
			f1 <= '0';
			f0 <= '0';
			g1 <= '0';
			g0 <= '0';
			h1 <= '0';
			h0 <= '0';
			i <= '0';
			j <= '0';
			k <= '0';
			w0 <= '0';
			w1 <= '0';
			w2 <= '0';
			writeOut <= '0';
			InterruptStatus <= "00";
			
			case (opcode&FetchStatus) is
                when ("0101000")  => --IADD
                     a1 <= '1';
					 b1 <= '1';
					 d1 <= '1';
					 d0 <= '1';
					 e  <= '1';
					 f0 <= '1';
					 g0 <= '1';
                when "0101001" => --IADD SEC
                    a1 <= '1';
					 b1 <= '1';
					 d1 <= '1';
					 d0 <= '1';
					 e  <= '1';
					 f0 <= '1';
					 g0 <= '1';
					 w1 <= '1';
					 w2 <= '1';
				when ("0111000"  )  =>--SHL 
                     
					 b1 <= '1';
					 d1 <= '1';
					 d0 <= '1';
					 e  <= '1';
					 f0 <= '1';
					 g0 <= '1';
				when "0111100" =>--SHR
					 
					 b1 <= '1';
					 d1 <= '1';
					 d0 <= '1';
					 e  <= '1';
					 f0 <= '1';
					 g0 <= '1';
                when ("0111001"  ) => --SHL  Sec 
                    
					 b1 <= '1';
					 d1 <= '1';
					 d0 <= '1';
					 e  <= '1';
					 f0 <= '1';
					 g0 <= '1';
					 w1 <= '1';
					 w2 <= '1';
					 
				when "0111101" =>--SHR SEC
					
					 b1 <= '1';
					 d1 <= '1';
					 d0 <= '1';
					 e  <= '1';
					 f0 <= '1';
					 g0 <= '1';
					 w1 <= '1';
					 w2 <= '1';
				when "1001000"  =>--LDM
                     d1 <= '1';
					 d0 <= '1';
					 f1 <= '1';
                when "1001001" =>--LDM Sec 
                     d1 <= '1';
					 d0 <= '1';
					 f1 <= '1';
					 w1 <= '1';
				when "1001100"  =>--LDD 
                     d0 <= '1';
					 h1 <= '1';
					 
                when "1001101" =>--LDD Sec
                   d0 <= '1';
				   h1 <= '1';
				   w1 <= '1';
				when "1010000" =>--STD
                    d0 <= '1';
					e  <= '1';
				when "1010001" =>--STD Sec
                    d0 <= '1';
					e  <= '1'; 
					w0 <= '1';
				 when ("0000100"   )  => --NOT 
                    b1 <= '1';
					d1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
				when "0001000" => --DEC
                    b1 <= '1';
					d1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
				when "0001100" => --INC
                    b1 <= '1';
					d1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
                when "0010000" => --OUT
                    f0 <= '1';
					writeOut <= '1';
				when "0010100"  =>--IN
                     c0 <= '1';
					 w1 <= '1';
                when "0100000" => --SWAP 
                    b0 <= '1';
					f1 <= '1';
					g1 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
				when "0100100"    => --ADD, 
                    a0 <= '1';
					b1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
				when "0101100" =>-- SUb 
                    a0 <= '1';
					b1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
				when "0110100" =>-- or 
                    a0 <= '1';
					b1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
				when "0110000" =>-- AND 
                    a0 <= '1';
					b1 <= '1';
					e  <= '1';
					f0 <= '1';
					g0 <= '1';
					w1 <= '1';
					w2 <= '1';
                when "1000000" =>-- PUSH 
                    i <= '1';
					w0 <= '1';
					w2 <= '1';
				when "1000100"  =>--POP
                     g1 <= '1';
					 h1 <= '1';
					 w1 <= '1';
					 w2 <= '1';
                when "1100000" =>--JZ
                    d1 <= '1';
					b1 <= '1';
				when "1100100" =>--JMP  All zeros 
                   
				 when "1101000"  => --CALL
                     c1 <= '1';
					 h0 <= '1';
					 i  <= '1';
					 k  <= '1';
					 w0 <= '1';
					 w2 <= '1';
                when "1101100" => --RET
                    g1 <= '1';
					w2 <= '1';
				when "1110000"  =>--RTI 1st 
                     g1 <= '1';
					 w2 <= '1';
                when "1110001" => --RTI 2nd
					a1 <= '1';
					a0 <= '1';
                    g1 <= '1';
					h1 <= '1';
					w2 <= '1';
					w1 <= '1';
				
               
				when others =>
					--Already All zeros 
            end case;
			case(Interrupt&FetchStatus) is 
				when ("100")  => --INT First
					 InterruptStatus <= "01";
                     a1 <= '1';
					 c1 <= '1';
					 i  <= '1';
					 w0 <= '1';
					 w2 <= '1';
                when "101" => --INT Sec
					 InterruptStatus <= "10";
					 a1 <= '1';
					 c1 <= '1';
					 h1 <= '1';
					 i  <= '1';
					 j  <= '1';
					 --w2 <= '1';  Commented Because it shouldnt write back
				when "110" =>--INT Third 
					InterruptStatus <= "11";
					a1 <= '1';
					a0 <= '1';
					f1 <= '1';
					f0 <= '1';
					i  <= '1';
					w0 <= '1';
					w2 <= '1';
					
				when others =>
				end case;
			
        end process;
WBOUT(3) <= w0;
WBOUT(2) <= w1;
WBOUT(1) <= w2;
WBOUT(0) <= writeOut;
selectors(8) <= e;
selectors(7) <= f1;
selectors(6) <= f0;
selectors(5) <= g1;
selectors(4) <= g0;
selectors(3) <= h1;
selectors(2) <= h0;
selectors(1) <= i;
selectors(0) <= j;
SwapOut <= Swap;
opcode <= Instruction (31 downto 27);
OpcodeOut <= opcode;
load_pop <= 
 '1' when opcode= "10011" else
 '1' when opcode = "10001" else
 '0';
RET <= 
 '1' when opcode = "11011" else 
 '0';
RTI_First <= 
 '1' when ( opcode = "11100" and FetchStatus = "00") else 
 '0';

EditFlag <= 
 '1' when opcode= "01010" else
 '1' when opcode = "01110" else
 '1' when opcode = "01111" else
 '1' when opcode = "00001" else
 '1' when opcode = "00010" else
 '1' when opcode = "00011" else
 '1' when opcode = "01001" else
 '1' when opcode = "01011" else
 '1' when opcode = "01101" else
 '1' when opcode = "01100" else
 '1' when (opcode = "11100" and FetchStatus = "01")  else
 '0';

JZ <= 
 '1' when opcode= "11000" else
 '0';
PredResultOut <= PredResult;
Nu_Sources <= 
  "01" when opcode = "01010" and FetchStatus = "01" else
  "01" when opcode = "01110" and FetchStatus = "01" else
  "01" when opcode = "01111" and FetchStatus = "01" else
  "01" when opcode = "00001" else
  "01" when opcode = "00010" else
  "01" when opcode = "00011" else
  "01" when opcode = "00100" else
  "01" when opcode = "10000" else
  "01" when opcode = "10100" and FetchStatus = "01" else
  "01" when opcode = "11000" else
  "01" when opcode = "11010" else
  "10" when opcode = "01000" else
  "10" when opcode = "01001" else
  "10" when opcode = "01011" else
  "10" when opcode = "01101" else
  "10" when opcode = "01100" else
  "00";
AA <= a1 & a0;
BB <= b1 & b0;
CC <= c1 & c0;
DD <= d1 & d0;
WITH (AA) SELECT 
	r1signal <= '0' & Instruction(26 downto 24) WHEN "00",
	'0' & Instruction(20 downto 18)	WHEN "01",
	'0' & Instruction(23 downto 21) WHEN "10",
	"1001" WHEN "11",
	(others => 'Z') WHEN others;
WITH (BB) SELECT 
	r2signal <= "1000" WHEN "00",
	'0' & Instruction(23 downto 21) WHEN "01",
	"1001" WHEN "10",
	(others => 'Z') WHEN others;
WITH (CC) SELECT 
	Reg1 <= InputRegFile1 WHEN "00",
	InputPort WHEN "01",
	PC WHEN "10",
	(others => 'Z') WHEN others;
s <= Instruction(15);
WITH (DD) SELECT 
	Reg2 <= InputRegFile2 WHEN "00",
	"000000000000"&Instruction(23 downto 4 ) WHEN "01",
	PC WHEN "10",
	s&s&s&s&s&s&s&s&s&s&s&s&s&s&s&s&Instruction(15 downto 0 ) WHEN "11",
	(others => 'Z') WHEN others;
WITH r2signal SELECT
	SelectorInputRegFile2 <= "1000" WHEN "1000",
	'0' & Instruction(23 downto 21) WHEN others;
WITH SelectorInputRegFile2 SELECT 
	InputRegFile2 <= R0_DATA WHEN "0000",
	R1_DATA WHEN "0001",
	R2_DATA WHEN "0010",
	R3_DATA WHEN "0011",
	R4_DATA WHEN "0100",
	R5_DATA WHEN "0101",
	R6_DATA WHEN "0110",
	R7_DATA WHEN "0111",
	"00000000000000000000" & SP_DATA WHEN "1000",
	(others => 'Z') WHEN others;
WITH Instruction(26 downto 24 ) SELECT 
	InputRegFile1 <= R0_DATA WHEN "000",
	R1_DATA WHEN "001",
	R2_DATA WHEN "010",
	R3_DATA WHEN "011",
	R4_DATA WHEN "100",
	R5_DATA WHEN "101",
	R6_DATA WHEN "110",
	R7_DATA WHEN "111",
	(others => 'Z') WHEN others;
WITH k SELECT
	Reg3 <= InputRegFile1 WHEN '1',
	"0000000000000000000000000000" & Flag_Data when '0',
	(others => 'Z') WHEN others;
R1 <= r1signal;
R2 <= r2signal;
r3signal <= '0' & Instruction(26 downto 24 ) ;
r4signal <= '0' & Instruction(23 downto 21 ) ;
R3 <= r3signal;
R4 <= r4signal;

	
--Write Back Part		    
R0_Enable <=(R0_check1 and WBEnable0) or (R0_check2 and WBEnable1);
R1_Enable <=(R1_check1 and WBEnable0) or (R1_check2 and WBEnable1);
R2_Enable <=(R2_check1 and WBEnable0) or (R2_check2 and WBEnable1);
R3_Enable <=(R3_check1 and WBEnable0) or (R3_check2 and WBEnable1);
R4_Enable <=(R4_check1 and WBEnable0) or (R4_check2 and WBEnable1);
R5_Enable <=(R5_check1 and WBEnable0) or (R5_check2 and WBEnable1);
R6_Enable <=(R6_check1 and WBEnable0) or (R6_check2 and WBEnable1);
R7_Enable <=(R7_check1 and WBEnable0) or (R7_check2 and WBEnable1);
SP_Enable <= (SP_Check1 and WBEnable0) or (SP_Check2 and WBEnable1);
flag_Enable <= (flag_Check1 and WBEnable0) or (flag_Check2 and WBEnable1);

 process (RegIndex0,RegIndex1) 
        begin
            
            R0_check1 <= '0';
			R0_check2 <= '0';
			R1_check1 <= '0';
			R1_check2 <= '0';
			R2_check1 <= '0';
			R2_check2 <= '0';
			R3_check1 <= '0';
			R3_check2 <= '0';
			R4_check1 <= '0';
			R4_check2 <= '0';
			R5_check1 <= '0';
			R5_check2 <= '0';
			R6_check1 <= '0';
			R6_check2 <= '0';
			R7_check1 <= '0';
			R7_check2 <= '0';
			sp_check1 <= '0';
			sp_check2 <= '0';
			flag_check1 <= '0';
			flag_check2 <= '0';
			
			
            case RegIndex0 is
                when "0000"  =>
                     R0_check1 <= '1';
                when "0001" =>
                    R1_check1 <= '1';
				when "0010"  =>
                     R2_check1 <= '1';
                when "0011" =>
                    R3_check1 <= '1';
				when "0100"  =>
                     R4_check1 <= '1';
                when "0101" =>
                    R5_check1 <= '1';
				when "0110"  =>
                     R6_check1 <= '1';
                when "0111" =>
                    R7_check1 <= '1';
				when "1000" =>
                    sp_check1 <= '1';
				when "1001" =>
                    flag_check1 <= '1';
				when others =>
					--Already All zeros 
            end case;
			case RegIndex1 is
                when "0000"  =>
                     R0_check2 <= '1';
                when "0001" =>
                    R1_check2 <= '1';
				when "0010"  =>
                     R2_check2 <= '1';
                when "0011" =>
                    R3_check2 <= '1';
				when "0100"  =>
                     R4_check2 <= '1';
                when "0101" =>
                    R5_check2 <= '1';
				when "0110"  =>
                     R6_check2 <= '1';
                when "0111" =>
                    R7_check2 <= '1';
				when "1000" =>
                    sp_check2 <= '1';
				when "1001" =>
                    flag_check2 <= '1';
				when others =>
					--Already All zeros 
            end case;
        end process;
R0_Input <= 
 RegWBData0 when R0_check1= '1' else
 RegWBData1 when R0_check2 = '1'else
 (others =>'Z');
R1_Input <= 
 RegWBData0 when R1_check1= '1' else
 RegWBData1 when R1_check2 = '1'else
 (others =>'Z');
R2_Input <= 
 RegWBData0 when R2_check1= '1' else
 RegWBData1 when R2_check2 = '1'else
 (others =>'Z');
R3_Input <= 
 RegWBData0 when R3_check1= '1' else
 RegWBData1 when R3_check2 = '1'else
 (others =>'Z');
R4_Input <= 
 RegWBData0 when R4_check1= '1' else
 RegWBData1 when R4_check2 = '1'else
 (others =>'Z');
R5_Input <= 
 RegWBData0 when R5_check1= '1' else
 RegWBData1 when R5_check2 = '1'else
 (others =>'Z');
R6_Input <= 
 RegWBData0 when R6_check1= '1' else
 RegWBData1 when R6_check2 = '1'else
 (others =>'Z');
R7_Input <= 
 RegWBData0 when R7_check1= '1' else
 RegWBData1 when R7_check2 = '1'else
 (others =>'Z');
sp_Input <= 
 RegWBData0 when sp_check1= '1' else
 RegWBData1 when sp_check2 = '1'else
 (others =>'Z');
flag_Input <= 
 RegWBData0(3 downto 0) when flag_check1= '1' else
 RegWBData1(3 downto 0) when flag_check2 = '1'else
 (others =>'Z');
--Registers Creation
rr0 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R0_Enable, R0_Input,R0_DATA) ;
rr1 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R1_Enable, R1_Input,R1_DATA) ;
rr2 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R2_Enable, R2_Input,R2_DATA) ;
rr3 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R3_Enable, R3_Input,R3_DATA) ;
rr4 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R4_Enable, R4_Input,R4_DATA) ;
rr5 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R5_Enable, R5_Input,R5_DATA) ;
rr6 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R6_Enable, R6_Input,R6_DATA) ;
rr7 : entity work.Reg(regarc) generic map(32)  port map ( clk , rst,'0' , R7_Enable, R7_Input,R7_DATA) ;
sp : entity work.Reg(regarc) generic map(12)  port map ( clk , '0',rst , SP_Enable, SP_Input(11 downto 0),SP_DATA(11 downto 0 ));
flag : entity work.Reg(regarc) generic map(4)  port map ( clk , rst,'0' , flag_Enable, flag_Input ,flag_DATA);


end architecture;

