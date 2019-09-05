----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:38 08/29/2019 
-- Design Name: 
-- Module Name:    REGO - Behavioral 
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
----------------------------------------------------------------??------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGO is
Port ( CLK : in  STD_LOGIC;
 REGOC : in  STD_LOGIC_VECTOR (1 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end REGO;

architecture REGOArc of REGO is
signal REG: STD_LOGIC_VECTOR (15 downto 0);
begin
process(CLK)
	begin
	if(CLK'event and CLK = '1')then	
			case REGOC is
				when "00" => REG <= INPUT;
				when "01" => OUTPUT <= REG;
				when others => OUTPUT <= (others=>'Z');
			end case;
	end if;
	end process;
end REGOArc;

