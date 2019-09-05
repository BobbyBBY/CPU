----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:18:47 09/02/2019 
-- Design Name: 
-- Module Name:    INIT - Behavioral 
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

entity INIT is
Port ( CLK : in  STD_LOGIC;
			 RST : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (17 downto 0);
				data : out  STD_LOGIC_VECTOR (15 downto 0);
           ready : inout  STD_LOGIC;
			  ready2 : out  STD_LOGIC;
			  en : out  STD_LOGIC;
			  we : out  STD_LOGIC;
			  oe : out  STD_LOGIC;
			  dbc : out  STD_LOGIC
			  );
end INIT;

architecture Behavioral of INIT is
signal state: integer range 0 to 36;
begin
process(CLK)
begin
if(RST='0')then
READY<='0';	state<=0;OE<='1';DBC<='1';EN<='0';ready2<='0';
elsif(CLK'event and CLK = '1' and READY = '0') then
	case state is
	when 0 => DATA<=(others=>'Z');ADDR<="000000000000000000";
	when 1 => DATA<="0000110000000001";WE<='0';
	when 2 => WE<='1';
	when 3 => DATA<=(others=>'Z');ADDR<="000000000000000001";
	when 4 => DATA<="0000000000001010";WE<='0';
	when 5 => WE<='1';
	when 6 => DATA<=(others=>'Z');ADDR<="000000000000000010";
	when 7 => DATA<="0000110000000010";WE<='0';
	when 8 => WE<='1';
	when 9 => DATA<=(others=>'Z');ADDR<="000000000000000011";
	when 10 => DATA<="0000000000001001";WE<='0';
	when 11 => WE<='1';
	when 12 => DATA<=(others=>'Z');ADDR<="000000000000000100";
	when 13 => DATA<="0000110000000011";WE<='0';
	when 14 => WE<='1';
	when 15 => DATA<=(others=>'Z');ADDR<="000000000000000101";
	when 16 => DATA<="0000000000000100";WE<='0';
	when 17 => WE<='1';
	when 18 => DATA<=(others=>'Z');ADDR<="000000000000000110";
	when 19 => DATA<="0000000000100010";WE<='0';
	when 20 => WE<='1';
	when 21 => DATA<=(others=>'Z');ADDR<="000000000000000111";
	when 22 => DATA<="0010000000000000";WE<='0';
	when 23 => WE<='1';
	when 24 => DATA<=(others=>'Z');ADDR<="000000000000001000";
	when 25 => DATA<="0000000010000011";WE<='0';
	when 26 => WE<='1';
	when 27 => DATA<=(others=>'Z');ADDR<="000000000000001001";
	when 28 => DATA<="0010000000000001";WE<='0';
	when 29 => WE<='1';
	when 30 => DATA<=(others=>'Z');ADDR<="000000000000001010";
	when 31 => DATA<="0000000010000000";WE<='0';
	when 32 => WE<='1';
	when 33 => DATA<=(others=>'Z');ADDR<="000000000000001011";
	when 34 => DATA<="0010000001000010";WE<='0';
	when 35 => WE<='1';
	when 36 => READY<='1';state<=0;ready2<='1';
	end case;
	end if;
end process;

end Behavioral;

