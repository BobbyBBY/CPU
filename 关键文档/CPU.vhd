----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:46 08/30/2019 
-- Design Name: 
-- Module Name:    CU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity CPU is
port(
		ADDRCPU : out  STD_LOGIC_VECTOR (17 downto 0);
		DATACPU : inout  STD_LOGIC_VECTOR (15 downto 0);
		INDATACPU : out  STD_LOGIC_VECTOR (15 downto 0);
		ENCPU : inout  STD_LOGIC;
		WECPU : inout  STD_LOGIC;
		OECPU : inout  STD_LOGIC;
		DBCCPU : inout  STD_LOGIC;
		CLOCKCPU : in  STD_LOGIC;
		RSTCPU : in  STD_LOGIC;
		LEDCPU1:out  STD_LOGIC_VECTOR (6 downto 0);
		LEDCPU2:out  STD_LOGIC_VECTOR (6 downto 0);
		LEDCPU3: out STD_LOGIC_VECTOR (15 downto 0);
		READYCPU : in STD_LOGIC
);
end CPU;

architecture Behavioral of CPU is
component CU
port(
		ALUC : out  STD_LOGIC_VECTOR (2 downto 0);
		RAMC : out  STD_LOGIC_VECTOR (2 downto 0);
		REGOC : out  STD_LOGIC_VECTOR (1 downto 0);
		REGAC : out  STD_LOGIC_VECTOR (1 downto 0);
		PCC : out STD_LOGIC_VECTOR (1 downto 0);
		REGSC : out STD_LOGIC_VECTOR (4 downto 0);
		MARC : out  STD_LOGIC_VECTOR (1 downto 0);
		MBRC : out  STD_LOGIC_VECTOR (2 downto 0);
		IRC : out  STD_LOGIC_VECTOR (2 downto 0);
		INPUTIR : in  STD_LOGIC_VECTOR (31 downto 0);
		led1: out STD_LOGIC_VECTOR (6 downto 0);
		led2: out STD_LOGIC_VECTOR (6 downto 0);
		CLK : out  STD_LOGIC;
		CLOCK : in  STD_LOGIC;
		RST : in  STD_LOGIC
);
end component;

component IR
port(
CLK : in  STD_LOGIC;
 IRC : in  STD_LOGIC_VECTOR (2 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUTCU : out  STD_LOGIC_VECTOR (31 downto 0);
			OUTPUTIN : out  STD_LOGIC_VECTOR (15 downto 0);
			READY:in STD_LOGIC
			  );
end component;

component MAR
Port ( CLK : in  STD_LOGIC;
 MARC : in  STD_LOGIC_VECTOR (1 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (17 downto 0);
			  OUTPUT : out  STD_LOGIC_VECTOR (17 downto 0)
			  );
end component;

component MBR
port(
CLK : in  STD_LOGIC;
 MBRC : in  STD_LOGIC_VECTOR (2 downto 0);
           outdata : inout  STD_LOGIC_VECTOR (15 downto 0);
           indata : inout  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;

component PC
Port ( CLK : in  STD_LOGIC;
		PCC : in STD_LOGIC_VECTOR (1 downto 0);
       OUTPUT : inout  STD_LOGIC_VECTOR (17 downto 0)
			  );
end component;

component RAM
		Port ( 
				CLK : in  STD_LOGIC;
				RAMC : in  STD_LOGIC_VECTOR (2 downto 0);
           EN : out  STD_LOGIC;
			  WE:out STD_LOGIC;
			  OE:out STD_LOGIC;
			  DBC:out std_logic
				);
end component;

component REGA 
Port ( CLK : in  STD_LOGIC;
 REGAC : in  STD_LOGIC_VECTOR (1 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;

component REGO
Port ( CLK : in  STD_LOGIC;
 REGOC : in  STD_LOGIC_VECTOR (1 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;

component REGS
Port ( CLK : in  STD_LOGIC;
		REGSC : in STD_LOGIC_VECTOR (4 downto 0);
       DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
           led : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;

component ALU
    Port ( CLK : in  STD_LOGIC;
	 ALUC : in  STD_LOGIC_VECTOR (2 downto 0);
           INPUTa : in  STD_LOGIC_VECTOR (15 downto 0);
		   INPUTb : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;


--signal carry_out1 : STD_LOGIC_VECTOR (15 downto 0);--DBOUT
signal carry_out2 : STD_LOGIC_VECTOR (17 downto 0);--DBIN
--signal carry_out3 : STD_LOGIC_VECTOR (17 downto 0);--AB
signal carry_out4 : STD_LOGIC_VECTOR (15 downto 0);--REGA_ALU
signal carry_out5 : STD_LOGIC_VECTOR (31 downto 0);--IR_CU

signal carry_out6 : STD_LOGIC_VECTOR (2 downto 0);--IRC
signal carry_out7 : STD_LOGIC_VECTOR (2 downto 0);--RAMC
signal carry_out8 : STD_LOGIC_VECTOR (2 downto 0);--MBRC
signal carry_out9 : STD_LOGIC_VECTOR (1 downto 0);--REGAC
signal carry_out10 : STD_LOGIC_VECTOR (2 downto 0);--ALUC

signal carry_out11 : STD_LOGIC_VECTOR (1 downto 0);--REGOC
signal carry_out12 : STD_LOGIC_VECTOR (4 downto 0);--REGSC
signal carry_out13 : STD_LOGIC_VECTOR (1 downto 0);--PCC
signal carry_out14 : STD_LOGIC_VECTOR (1 downto 0);--MARC
signal carry_out15 : STD_LOGIC;--OE

signal carry_out16 : STD_LOGIC;--EN
signal carry_out17 : STD_LOGIC;--DBC
signal carry_out18 : STD_LOGIC;--WE
signal carry_out19 : STD_LOGIC;--CLK
signal carry_out20 : STD_LOGIC_VECTOR (15 downto 0);--ALU_REGO

begin
U0:CU port map(
ALUC=>carry_out10,
RAMC=>carry_out7,
REGOC=>carry_out11,
REGAC=>carry_out9,
PCC=>carry_out13,
REGSC=>carry_out12,
MARC=>carry_out14,
MBRC=>carry_out8,
IRC=>carry_out6,
INPUTIR=>carry_out5,
LED1=>LEDCPU1,
LED2=>LEDCPU2,
CLK=>carry_out19,
CLOCK=>CLOCKCPU,
RST=>RSTCPU
);

U1:IR port map(
CLK=>carry_out19,
IRC=>carry_out6,
INPUT=>DATACPU,
OUTPUTCU=>carry_out5,
OUTPUTIN=>carry_out2(15 downto 0),
READY=>READYCPU
);

U2:MAR port map(
CLK=>carry_out19,
MARC=>carry_out14,
INPUT=>carry_out2,
OUTPUT=>ADDRCPU
);

U3:MBR port map(
CLK=>carry_out19,
MBRC=>carry_out8,
OUTDATA=>DATACPU,
INDATA=>carry_out2(15 downto 0)
);

U4:PC port map(
CLK=>carry_out19,
PCC=>carry_out13,
OUTPUT=>carry_out2
);

U5:RAM port map(
CLK=>carry_out19,
RAMC=>carry_out7,
EN=>ENCPU,
WE=>WECPU,
OE=>OECPU,
DBC=>DBCCPU
);

U6:REGA port map(
CLK=>carry_out19,
REGAC=>carry_out9,
INPUT=>carry_out2(15 downto 0),
OUTPUT=>carry_out4
);

U7:REGO port map(
CLK=>carry_out19,
REGOC=>carry_out11,
INPUT=>carry_out20,
OUTPUT=>carry_out2(15 downto 0)
);

U8:REGS port map(
CLK=>carry_out19,
REGSC=>carry_out12,
DATA=>carry_out2(15 downto 0),
led=>LEDCPU3
);

U9:ALU port map(
CLK=>carry_out19,
ALUC=>carry_out10,
INPUTa=>carry_out4,
INPUTb=>carry_out2(15 downto 0),
OUTPUT=>carry_out20
);





end Behavioral;
