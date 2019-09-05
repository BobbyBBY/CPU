----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:12:13 08/30/2019 
-- Design Name: 
-- Module Name:    IR - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IR is
port(
CLK : in  STD_LOGIC;
 IRC : in  STD_LOGIC_VECTOR (2 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUTCU : out  STD_LOGIC_VECTOR (31 downto 0);
			  OUTPUTIN : out  STD_LOGIC_VECTOR (15 downto 0);
			  READY:in STD_LOGIC
			  );
end IR;

architecture Behavioral of IR is
signal REG: STD_LOGIC_VECTOR (31 downto 0);
type romarray is array (0 to 17) of STD_LOGIC_VECTOR(15 downto 0);
signal romdata : romarray;
signal i : integer range 0 to 17;
begin
process(CLK)
	begin
	if(CLK'event and CLK = '1')then	
		if (READY = '0') then
		--li r1 10
		romdata(0)<="0001000000000001";
		romdata(1)<="0000000000001010";
		--li r2 9
		romdata(2)<="0001000000000010";
		romdata(3)<="0000000000001001";
		--li r3 4
		romdata(4)<="0001000000000011";
		romdata(5)<="0000000000000100";
		--addu r1 r2 r4
		romdata(6)<="0000000000100010";
		romdata(7)<="0010000000000000";
		--sw r1 r2 r4 
		romdata(8)<="0000000000100010";
		romdata(9)<="0010000000000101";
		--subu r4 r3 r4
		romdata(10)<="0000000010000011";
		romdata(11)<="0010000000000001";
		--sll r4 r4 1
		romdata(12)<="0000000010000000";
		romdata(13)<="0010000001000010";
		--not r4 r4
		romdata(14)<="0000000010000000";
		romdata(15)<="0010000000000011";
		--lw r1 r2 r5
		romdata(16)<="0000000000100010";
		romdata(17)<="0010100000000100";
	case IRC is
				when "000" => REG(31 downto 16) <= romdata(i);i<=i+1;
				when "001" => REG(15 downto 0) <= romdata(i);i<=i+1;
				when "010" => OUTPUTCU <= REG(31 downto 0);OUTPUTIN <= (others=>'Z');
				when "011" => OUTPUTIN <= REG(31 downto 16);
				when "100" => OUTPUTIN <= REG(15 downto 0);
				when "101" => null;
				when others => OUTPUTIN <= (others=>'Z');
			end case;
	elsif (READY = '1') then	
			case IRC is
				when "000" => REG(31 downto 16) <= INPUT;OUTPUTIN <= (others=>'Z');
				when "001" => REG(15 downto 0) <= INPUT;OUTPUTIN <= (others=>'Z');
				when "010" => OUTPUTCU <= REG(31 downto 0);OUTPUTIN <= (others=>'Z');
				when "011" => OUTPUTIN <= REG(31 downto 16);
				when "100" => OUTPUTIN <= REG(15 downto 0);
				when "101" => null;
				when others => OUTPUTIN <= (others=>'Z');i<=0;
			end case;
	end if;
	end if;
	end process;

end Behavioral;

