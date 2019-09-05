----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:28 08/30/2019 
-- Design Name: 
-- Module Name:    REGS - Behavioral 
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

entity REGS is
Port ( CLK : in  STD_LOGIC;
		REGSC : in STD_LOGIC_VECTOR (4 downto 0);
       DATA : inout  STD_LOGIC_VECTOR (15 downto 0);
			  led : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end REGS;

architecture Behavioral of REGS is
type regarray is array (0 to 7) of bit_vector(15 downto 0);
signal ramdata : regarray;
begin
process(CLK)
	begin 
	if(CLK'event and CLK = '1')then	
	case REGSC(4 downto 3) is
	when "00" => ramdata(conv_integer(REGSC(2 downto 0))) <= to_bitvector(DATA);led<=DATA;
	when "01" => DATA <= to_stdlogicvector(ramdata(conv_integer(REGSC(2 downto 0))));led<="1000000000000100";
	when others => DATA <= (others=>'Z');led<="1110000000000111";
	end case;
	end if;
	end process;
end Behavioral;

