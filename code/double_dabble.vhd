----------------------------------------------------------------------------------
-- Engineer: Ezra Santos (slightly modified from https://github.com/joulsen/16BitDoubleDabbler/blob/master/DoubleDabbler16Bit.vhd)
-- 
-- Create Date:    22:11:45 04/28/2020 
-- Design Name: Double Dabbler
-- Module Name: double_dabble - Behavioral
-- Project Name: Sequence Peak Generator
-- Target Devices: Basys3
-- Tool versions: 
-- Description: Converts binary to BCD using the double dabble algorithm
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity double_dabble is
    Port ( CLK 	: in  	STD_LOGIC;
			 RESET 	: in		STD_LOGIC;
           BIN 	: in  	UNSIGNED (15 downto 0);
           BCD 	: out  	STD_LOGIC_VECTOR (15 downto 0)
			  );
end double_dabble;

architecture Behavioral of double_dabble is


begin

process(clk)
variable scratch : UNSIGNED(35 downto 0) := (others => '0');
variable cntr : UNSIGNED(7 downto 0) := (others => '0');

begin
	if rising_edge(clk) then
		if reset = '1' then
			cntr := (others => '0');
			scratch(35 downto 16) := (others => '0');
			scratch(15 downto 0) := BIN;
		else
			if cntr <= 15 then
				if scratch(34 downto 31) > 4 then
					scratch(35 downto 31) := scratch(35 downto 31) + 3;
				end if;
				if scratch(31 downto 28) > 4 then
					scratch(32 downto 28) := scratch(32 downto 28) + 3;
				end if;
				if scratch(27 downto 24) > 4 then
					scratch(28 downto 24) := scratch(28 downto 24) + 3;
				end if;
				if scratch(23 downto 20) > 4 then
					scratch(24 downto 20) := scratch(24 downto 20) + 3;
				end if;
				if scratch(19 downto 16) > 4 then
					scratch(20 downto 16) := scratch(20 downto 16) + 3;
				end if;
				scratch := scratch sll 1;
				cntr := cntr + 1;
			end if;
		end if;
		
		BCD <= STD_LOGIC_VECTOR(scratch(31 downto 16));
	end if;
end process;


end Behavioral;