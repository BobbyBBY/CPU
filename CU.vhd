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

entity CU is
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
end CU;

architecture Behavioral of CU is
signal stateTerm: integer range 0 to 5;
signal stateIns: integer range 0 to 11;
signal state: integer range 0 to 19;
begin

process(CLOCK,RST)
	begin
	if (RST = '0')then
	pcc <= "00";
	ALUC<="111";
	RAMC<="111";
	REGOC<="11";
	REGAC<="11";
	REGSC<="11111";
	MARC<="11";
	MBRC<="111";
	IRC<="111";
	led1<="0111111";
	led2<="0111111";
	clk <= '0';
	stateTerm <= 0;
	state <= 0;
	stateIns <= 0;
	elsif(CLOCK'event and CLOCK = '1' )then
	
	case stateTerm is
	when 0 => led1<="0111111";
	when 1 => led1<="0000110";
	when 2 => led1<="1011011";
	when 3 => led1<="1001111";
	when 4 => led1<="1100110";
	when 5 => led1<="1101101";
	end case;
	case state is
	when 0 => led2<="0111111";
	when 1 => led2<="0000110";
	when 2 => led2<="1011011";
	when 3 => led2<="1001111";
	when 4 => led2<="1100110";
	when 5 => led2<="1101101";
	when 6 => led2<="1111101";
	when 7 => led2<="0000111";
	when 8 => led2<="1111111";
	when 9 => led2<="1101111";
	when 10 => led2<="0111111";
	when 11 => led2<="0000110";
	when 12 => led2<="1011011";
	when 13 => led2<="1001111";
	when 14 => led2<="1100110";
	when 15 => led2<="1101101";
	when 16 => led2<="1111101";
	when 17 => led2<="0000111";
	when 18 => led2<="1111111";
	when 19 => led2<="1101111";
	end case;
	
	if(stateTerm = 0) then --rst
	--pc->mar
	case state is
	when 0 => state <= 1; clk <= '1';
	when 1 => state <= 2; clk <= '0';pcc <= "01";
	when 2 => state <= 3; clk <= '1';
	when 3 => state <= 4; clk <= '0';MARC<="00";
	when 4 => state <= 5; clk <= '1';
	when 5 => state <= 6; clk <= '0';MARC<="10";pcc <= "11";
	when 6 => stateTerm <= 1;state <= 0; clk <= '1';
	when others => null;
	end case;
	elsif(stateTerm = 1) then --ft
	case state is
	when 0 => state <= 1; clk <= '0';MARC<="10";pcc <= "10";
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';RAMC<="000";pcc <= "11";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';RAMC<="001";-----------------------------------------------------------------------------------------------------
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';IRC<="000";--M->ir1
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';pcc <= "01";IRC<="111";RAMC<="010";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';MARC<="00";pcc <= "10";
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';MARC<="10";pcc <= "11";
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';RAMC<="001";-----------------------------------------------------------------------------------------------------
	when 15 => state <= 16; clk <= '1';
	when 16 => state <= 17; clk <= '0';IRC<="001";
	when 17 => state <= 18; clk <= '1';
	when 18 => state <= 19; clk <= '0';IRC<="010";RAMC<="010";--M->ir2
	when 19 => stateTerm <= 2;state <= 0; clk <= '1';
	when others => null;
	end case;
	elsif(stateTerm = 2) then --dt
	case INPUTIR(31 downto 26) is
	when "000000" =>  
	case INPUTIR(5 downto 0) is
	when "000000" => stateIns<=1;stateTerm <= 3;state <= 0;--addu1
	when "000001" => stateIns<=2;stateTerm <= 3;state <= 0;--subu1
	when "000010" => stateIns<=3;stateTerm <= 3;state <= 0;--sll1
	when "000011" => stateIns<=4;stateTerm <= 3;state <= 0;--not
	when "000100" => stateIns<=5;stateTerm <= 3;state <= 0;--lw
	when "000101" => stateIns<=6;stateTerm <= 3;state <= 0;--sw
	when "000110" => stateIns<=7;stateTerm <= 3;state <= 0;--sll2
	when others => stateTerm <= 0;
	end case;
	when "000001" => stateIns<=8;stateTerm <= 3;state <= 0;--addu2
	when "000010" => stateIns<=9;stateTerm <= 3;state <= 0;--subu2
	when "000011" => stateIns<=10;stateTerm <= 3;state <= 0;--subu3
	when "000100" => stateIns<=11;stateTerm <= 3;state <= 0;--li
	when others => stateTerm <= 0;
	end case;
	elsif(stateTerm = 3) then --pt
	case stateIns is
	when 1 => --addu1--addu1--
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';REGSC<="01"&INPUTIR(18 downto 16);REGAC<="01";--rega+r1->rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="000";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGOC<="00";REGSC<="11111";REGAC<="11";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r2
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(13 downto 11);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 2 => --subu1
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';REGSC<="01"&INPUTIR(18 downto 16);REGAC<="01";--rega-r1->rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="001";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGSC<="11111";REGOC<="00";REGAC<="11";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r2
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(13 downto 11);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 3 => --sll1
	case state is
	when 0 => state <= 1; clk <= '0';IRC<="100";--绔嬪嵆鏁>rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";IRC<="101";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';IRC<="111";REGSC<="01"&INPUTIR(23 downto 21);REGAC<="01";--r1<<(rega)->rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="011";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGSC<="11111";REGOC<="00";REGAC<="11";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r2
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(13 downto 11);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 4 => --not
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--not r0->rego
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';ALUC<="101";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';REGSC<="11111";REGOC<="00";ALUC<="110";
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';REGOC<="01";ALUC<="111";--rego->r2
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGSC<="00"&INPUTIR(13 downto 11);
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="11";REGSC<="11111";
	when 11 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 5 => --lw
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->mar1
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';MARC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';REGSC<="01"&INPUTIR(18 downto 16);MARC<="11";--r2->mar2
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';MARC<="01";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGSC<="11111";MARC<="11";
	when 9 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 6 => --sw
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(13 downto 11);--r2->mbr
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';MBRC<="010";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';MBRC<="001";
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->mar1
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';MARC<="00";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGSC<="01"&INPUTIR(18 downto 16);MARC<="11";--r2->mar2
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';MARC<="01";
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGSC<="11111";MARC<="11";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 7 => --sll2
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';REGSC<="01"&INPUTIR(18 downto 16);REGAC<="01";--r1<<(rega)->rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="100";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGSC<="11111";REGOC<="00";REGAC<="11";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r2
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(13 downto 11);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 8 => --addu2
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';IRC<="100";REGAC<="01";REGSC<="11111";--rega+绔嬪嵆鏁>rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="000";IRC<="101";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGOC<="00";REGAC<="11";IRC<="111";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r1
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(18 downto 16);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 9 => --subu2
	case state is
	when 0 => state <= 1; clk <= '0';REGSC<="01"&INPUTIR(23 downto 21);--r0->rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';IRC<="100";REGAC<="01";REGSC<="11111";--rega-绔嬪嵆鏁>rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="001";IRC<="101";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGOC<="00";REGAC<="11";IRC<="111";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r1
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(18 downto 16);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 10 => --subu3
	case state is
	when 0 => state <= 1; clk <= '0';IRC<="100";--绔嬪嵆鏁>rega
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGAC<="00";IRC<="101";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';IRC<="111";REGAC<="01";REGSC<="01"&INPUTIR(23 downto 21);--rega-r0->rego
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';ALUC<="001";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';REGOC<="00";REGAC<="11";REGSC<="11111";ALUC<="110";
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGOC<="01";ALUC<="111";--rego->r1
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';REGSC<="00"&INPUTIR(18 downto 16);
	when 13 => state <= 14; clk <= '1';
	when 14 => state <= 15; clk <= '0';REGOC<="11";REGSC<="11111";
	when 15 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when 11 => --li
	case state is
	when 0 => state <= 1; clk <= '0';IRC<="100";--绔嬪嵆鏁>r1
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';REGSC<="00"&INPUTIR(18 downto 16);IRC<="101";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';IRC<="111";REGSC<="11111";
	when 5 => state <= 0; stateTerm <= 4; clk <= '1';
	when others => null;
	end case;
	when others => null;
	end case;
	elsif(stateTerm = 4) then --mt
	case stateIns is
	when 5 => 
	case state is
	when 0 => state <= 1; clk <= '0';MARC<="10";--M->mbr
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';RAMC<="000";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';RAMC<="001";-----------------------------------------------------------------------------------------------------
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';MBRC<="000";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';MBRC<="011";RAMC<="010";--mbr->r2
	when 9 => state <= 10; clk <= '1';
	when 10 => state <= 11; clk <= '0';REGSC<="00"&INPUTIR(13 downto 11);
	when 11 => state <= 12; clk <= '1';
	when 12 => state <= 13; clk <= '0';MBRC<="111";REGSC<="11111";
	when 13 => stateTerm <= 5;state <= 0; clk <= '1';
	when others => null;
	end case;
	when others => state <= 0; stateTerm <= 5;
	end case;
	elsif(stateTerm = 5) then --rt
	case stateIns is
	when 6 => 
	case state is
	when 0 => state <= 1; clk <= '0';MARC<="10";--mbr->m
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';RAMC<="011";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';RAMC<="100";MBRC<="111";pcc <= "01";--pc->mar
	when 5 => state <= 6; clk <= '1';
	when 6 => state <= 7; clk <= '0';MARC<="00";
	when 7 => state <= 8; clk <= '1';
	when 8 => state <= 9; clk <= '0';MARC<="10";pcc <= "11";
	when 9 => stateTerm <= 1;state <= 0; clk <= '1';
	when others => null;
	end case;
	when others =>
	case state is
	when 0 => state <= 1; clk <= '0';pcc <= "01";--pc->mar
	when 1 => state <= 2; clk <= '1';
	when 2 => state <= 3; clk <= '0';MARC<="00";
	when 3 => state <= 4; clk <= '1';
	when 4 => state <= 5; clk <= '0';MARC<="10";pcc <= "11";
	when 5 => stateTerm <= 1;state <= 0; clk <= '1';
	when others => null;
	end case;
	end case;
	else null;
	end if;
	end if;
	end process;
end Behavioral;

