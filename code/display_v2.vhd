---------------------------------------------------------------------------------- 
-- Engineer: Ezra Santos
-- 
-- Create Date: 06/08/2024 01:52:33 PM
-- Design Name: Display
-- Module Name: display - Behavioral
-- Project Name: Sequence Peak Generator
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Displays highest value of sequence from BCD input
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_v2 is
    Port ( clk : in STD_LOGIC;
           data_in : in std_logic_vector(15 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end display_v2;

architecture Behavioral of display_v2 is
    signal ref_signal : std_logic_vector(16 downto 0) := (others => '0');
    signal new_clk : std_logic := '0';
    signal current_digit : std_logic_vector(1 downto 0) := "00";

begin

process(clk)
variable temp1 : integer := 0;
begin
    if rising_edge(clk) then 
        temp1 := to_integer(unsigned(ref_signal)) + 1;
        ref_signal <= std_logic_vector(to_unsigned(temp1, 17));
    end if;
end process;

new_clk <= ref_signal(16);

process(new_clk)
variable temp2 : integer := 0;
begin
    if rising_edge(new_clk) then
        temp2 := to_integer(unsigned(current_digit)) + 1;
        current_digit <= std_logic_vector(to_unsigned(temp2, 2));
    end if;
end process;

process(current_digit, data_in)
variable digit : integer := 0;
begin
    case current_digit is
        when "00" =>
            digit := to_integer(unsigned(data_in(3 downto 0)));
            an <= "1110";
        when "01" =>
            digit := to_integer(unsigned(data_in(7 downto 4)));
            an <= "1101";
        when "10" =>
            digit := to_integer(unsigned(data_in(11 downto 8)));
            an <= "1011";
        when "11" =>
            digit := to_integer(unsigned(data_in(15 downto 12)));
            an <= "0111";
        when others =>
            digit := 0;
            an <= "1111";
    end case;
    
    case digit is
        when 0 =>
            seg <= "1000000";
        when 1 =>
            seg <= "1111001";
        when 2 =>
            seg <= "0100100";
        when 3 =>
            seg <= "0110000";
        when 4 =>
            seg <= "0011001";
        when 5 =>
            seg <= "0010010";
        when 6 =>
            seg <= "0000010";
        when 7 =>
            seg <= "1111000";
        when 8 =>
            seg <= "0000000";
        when 9 =>
            seg <= "0010000";
        when others =>
            seg <= "0000000";
    end case;
end process;

end Behavioral;
