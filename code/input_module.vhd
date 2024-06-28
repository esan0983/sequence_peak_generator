----------------------------------------------------------------------------------
-- Engineer: Ezra Santos
-- 
-- Create Date: 06/18/2024 08:09:01 PM
-- Design Name: Input Module
-- Module Name: input_module - Behavioral
-- Project Name: Sequence Peak Generator
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Basic input functionality with switches, LEDs, and one button
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity input_module is
    Port ( sw : in STD_LOGIC_VECTOR (12 downto 0);
           clk : in std_logic;
           led : out STD_LOGIC_VECTOR (12 downto 0);
           data_out : out STD_LOGIC_VECTOR (12 downto 0);
           enter : in STD_LOGIC);
end input_module;

architecture Behavioral of input_module is

signal flag : std_logic;

begin

process(sw)
begin
    led <= sw;
end process;

process(clk, enter)
begin
    if rising_edge(clk) then
        if enter = '1' then
            flag <= '0';
        else
            flag <= '1';
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if enter = '1' and flag = '1' then
            data_out <= sw;
        end if;
    end if;
end process;

end Behavioral;
