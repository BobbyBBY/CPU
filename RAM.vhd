----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:12 08/30/2019 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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

entity RAM is
		Port ( 
				CLK : in  STD_LOGIC;
				RAMC : in  STD_LOGIC_VECTOR (2 downto 0);
           EN : out  STD_LOGIC;
			  data : inout  STD_LOGIC_VECTOR (15 downto 0);
			  WE:out STD_LOGIC;
			  OE:out STD_LOGIC;
			  DBC:out std_logic
				);
end RAM;
architecture Behavioral of RAM is
signal state: integer range 0 to 37;
begin
process(CLK)
	begin
			if(CLK'event and CLK = '1')then	
			case RAMC is
				when "000" =>--ËÍ¿ØÖÆÐÅºÅ,µØÖ·
							data<=(others=>'Z');
				when "001" =>OE<='0';--¶Á2
				when "010" =>OE<='1';data<=(others=>'Z');--¶Á3
				when "011" => WE<='0';--Ð´1
				when "100" => WE<='1';--Ð´2
				when others => en<='0';dbc<='1';OE<='1';WE<='1';
			end case;
		end if;
	end process;
end Behavioral;

