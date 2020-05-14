Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity fetch is
    port ( 
            clk, rst, int: in std_logic;
            instruction, pcOutput: out std_logic_vector (31 downto 0);
            output_state : out std_logic_vector(1 downto 0);
            swap, wb, perdiction_result : out std_logic);
    end entity;


Architecture behavioral of fetch is
   
        component ram IS
        PORT(
            clk : IN std_logic;
            wr  : IN std_logic;
            rd	: IN std_logic;
            address : IN  std_logic_vector(31 DOWNTO 0);
            datain  : IN  std_logic_vector(15 DOWNTO 0);
            dataout : OUT std_logic_vector(15 DOWNTO 0));
        END component ;

        component fetch_decode is
        port ( clk : in std_logic;
                opcode :  in std_logic_vector(4 downto 0);
                interrupt : in std_logic;
                swap, wb: out std_logic;
                mem_rti_int_others: out  std_logic_vector(1 downto 0));
        end component;
        component fetch_status is
            port ( input: in std_logic_vector(1 downto 0);
                    clk,rst: in std_logic;
                    output: out std_logic_vector (3 downto 0));
        end component;
    
        signal inp   :  std_logic_vector(15 downto 0);
        signal pc, inst  :  std_logic_vector(31 downto 0) := (others => '0');
        signal sw, w, key :  std_logic;
        signal mrio   :  std_logic_vector(1 downto 0);
        signal opt,opt_temp, temp1, temp2     :  std_logic_vector(15 downto 0);
        signal fs_opt   :  std_logic_vector(3 downto 0);
        signal s0,s1 : std_logic;
        signal halt : std_logic  := '0';
       
        begin
            
            process (clk, rst)
            begin
                if rst = '1' then pc <=  (others => '0'); 
                elsif clk'event and clk = '1' then 
                        key <= int;
                       if (s0 = '0') and (halt ='0')  then pc <=  pc + '1' ; end if;  
                       --if s1= '0' then inst(31 downto 16) <= opt; inst(15 downto 0) <= (others => '0');
                        --else inst(15 downto 0) <= opt; end if;
             
                end if;
            end process;
            

            a1: ram PORT MAP(clk, '0', '1', pc, inp, opt);
            a2: fetch_decode PORT MAP(key, opt(15 downto 11), int ,sw,w, mrio);
            a3: fetch_status PORT MAP(mrio, clk ,rst, fs_opt);
            swap <= sw;
            opt_temp <= opt;
            wb <= w;
            s0 <= fs_opt (1);
            s1 <= fs_opt (0);
            halt <= '1' when opt(15 downto 11) = "11111" else '0';
            output_state <= fs_opt(3 downto 2);
            process(clk)
            
            begin
                 if clk'event and clk = '1' then temp2 <= temp1; end if;
            end process;
            inst(31 downto 16) <= opt when s1 = '0'else temp2 ;
            inst(15 downto 0) <= opt when s1 = '1' else (others => '0');
            instruction <= inst;  
            temp1 <= inst(31 downto 16);
            pcOutput <= pc + '1';

end Architecture;