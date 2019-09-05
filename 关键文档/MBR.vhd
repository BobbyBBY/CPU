----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:50:54 08/30/2019 
-- Design Name: 
-- Module Name:    MBR - Behavioral 
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

entity MBR is
port(
CLK : in  STD_LOGIC;
 MBRC : in  STD_LOGIC_VECTOR (2 downto 0);
           outdata : inout  STD_LOGIC_VECTOR (15 downto 0);
           indata : inout  STD_LOGIC_VECTOR (15 downto 0)
			  );
end MBR;

architecture Behavioral of MBR is
signal REG: STD_LOGIC_VECTOR (15 downto 0);
begin
process(CLK)
	begin
	if(CLK'event and CLK = '1')then	
			case MBRC is
				when "000" => REG <= outdata;indata <= (others=>'Z');
				when "001" => outdata <= REG;indata <= (others=>'Z');
				when "010" => REG <= indata;outdata <= (others=>'Z');
				when "011" => indata <= REG;outdata <= (others=>'Z');
				when others => outdata <= (others=>'Z');indata <= (others=>'Z');
			end case;
	end if;
	end process;

end Behavioral;

