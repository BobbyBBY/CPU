----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:48:29 08/29/2019 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is

Port ( CLK : in  STD_LOGIC;
		PCC : in STD_LOGIC_VECTOR (1 downto 0);
       OUTPUT : inout  STD_LOGIC_VECTOR (17 downto 0)
			  );
end PC;
 
architecture Behavioral of PC is
signal REG: STD_LOGIC_VECTOR (17 downto 0);
begin
process(CLK)
	begin
	if(CLK'event and CLK = '1')then	
	case PCC is
	when "00" => REG <= "000000000000000000";
	when "01" => OUTPUT <= REG;
	when "10" => REG <= REG + 1;
	when others => OUTPUT <= (others=>'Z');
	end case;
	end if;
	end process;
end Behavioral;