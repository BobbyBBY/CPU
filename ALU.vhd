----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:33 12/18/2018 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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


entity ALU is
    Port ( CLK : in  STD_LOGIC;
	 ALUC : in  STD_LOGIC_VECTOR (2 downto 0);
           INPUTa : in  STD_LOGIC_VECTOR (15 downto 0);
		   INPUTb : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end ALU;

architecture ALUArc of ALU is
begin
process(CLK )
	begin
	if(CLK'event and CLK = '1')then	
			case ALUC is
				when "000" => OUTPUT <= INPUTa + INPUTb;
				when "001" => OUTPUT <= INPUTa - INPUTb;
				--when "010" => OUTPUT <= INPUT;
				when "011" => OUTPUT <= to_stdlogicvector(to_bitvector(INPUTb) sll conv_integer(INPUTa(10 downto 6)));
				when "100" => OUTPUT <= to_stdlogicvector(to_bitvector(INPUTb) sll conv_integer(INPUTa));
				when "101" => OUTPUT <= not INPUTb;
				when "110" => null;
				when others => OUTPUT <= (others => 'Z');
			end case;
			end if;
	end process;
end ALUArc;

