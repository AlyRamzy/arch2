LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


entity main is
port(
    clk, reset, interrupt: in std_logic;
    inport: in std_logic_vector(31 downto 0);
    outport: out std_logic_vector(31 downto 0);
    R0_RegFile, R1_RegFile, R2_RegFile, R3_RegFile, R4_RegFile, R5_RegFile, R6_RegFile, R7_RegFile :out std_logic_vector(31 downto 0 );
	SP_RegFile :out std_logic_vector(11 downto 0 );
	Flag_RegFile :out std_logic_vector(3 downto 0 )
);
end entity;

architecture behavioure of main is

-------------------fetch----------------------
signal instruction, pc: std_logic_vector(31 downto 0);
signal output_state: std_logic_vector(1 downto 0);
signal swap, wb, perdiction_result: std_logic;
-------------------fetch-----------------------

-------------------for write back-----------------------
signal RegWBData0: std_logic_vector (31 downto 0);
signal RegWBData1: std_logic_vector (31 downto 0);
signal RegIndex0: std_logic_vector(3 downto 0 );
signal RegIndex1: std_logic_vector(3 downto 0 );
signal WBEnable0:  std_logic;
signal WBEnable1:  std_logic;
-------------------for write back-----------------------

signal R1,R2,R3,R4: std_logic := '1';
signal D1: std_logic_vector(69 downto 0);
signal D2: std_logic_vector(140 downto 0);
signal D3: std_logic_vector(156 downto 0);
signal D4: std_logic_vector(77 downto 0);

signal Q1: std_logic_vector(69 downto 0);
signal Q2: std_logic_vector(140 downto 0);
signal Q3: std_logic_vector(156 downto 0);
signal Q4: std_logic_vector(77 downto 0);

begin
    
    fetchStage: entity work.fetch port map (clk, reset, interrupt, instruction, pc, output_state, swap, wb, perdiction_result);
    D1 <= interrupt & swap & wb & perdiction_result & output_state & instruction & pc;

    stage1: entity work.reg2 generic map(70) port map (clk, reset, '0', R1, D1, Q1);


    decodeStage: entity work.decode port map (clk, reset, Q1(68), Q1(67), Q1(66), Q1(65 downto 64), Q1(63 downto 32), Q1(31 downto 0), Q1(69), inport, RegWBData0, RegWBData1, RegIndex0, RegIndex1, WBEnable0, WBEnable1, D2(140), D2(139), D2(138 downto 137), D2(136), D2(135), D2(134), D2(133), D2(132), D2(131 downto 130), D2(129 downto 98), D2(97 downto 66), D2(65 downto 34), D2(33 downto 30), D2(29 downto 26), D2(25 downto 22), D2(21 downto 18), D2(17 downto 13), D2(12 downto 4), D2(3 downto 0), R0_RegFile, R1_RegFile, R2_RegFile, R3_RegFile, R4_RegFile, R5_RegFile, R6_RegFile, R7_RegFile, SP_RegFile, Flag_RegFile);


    stage2: entity work.reg2 generic map(141) port map (clk, reset, '0', R2, D2, Q2);


    executeStage: entity work.execute port map (Q2(17 downto 13), Q2(12 downto 4), Q2(129 downto 98), Q2(97 downto 66), Q2(65 downto 34), Q2(134), Q2(131 downto 130), D3(143 downto 112), D3(111 downto 80), D3(79 downto 48), D3(47 downto 16), D3(7 downto 4));

    D3(156 downto 144) <= Q2(17 downto 13) & reset & Q2(134) & Q2(139) & Q2(140) & Q2(133) & Q2(132) & Q2(131 downto 130);
    D3(15 downto 8) <= Q2(33 downto 30) & Q2(29 downto 26);
    D3(3 downto 0) <= Q2(3 downto 0);

    satge3: entity work.reg2 generic map(157) port map (clk, reset, '0', R3, D3, Q3);

    memoryStage: entity work.memory port map (Q3, clk, D4);

    satge4: entity work.reg2 generic map(78) port map (clk, reset, '0', R3, D4, Q4);

    writeBackStage: entity work.writeBack port map (Q4, RegWBData0, RegWBData1, RegIndex0, RegIndex1, WBEnable0, WBEnable1);

end;