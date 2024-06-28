----------------------------------------------------------------------------------
-- Engineer: Ezra Santos
-- 
-- Create Date: 06/20/2024 07:31:04 PM
-- Design Name: Comparator
-- Module Name: comparator_fsm - Behavioral
-- Project Name: Sequence Peak Generator
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Stores the highest value in a sequence, outputs the stored value when terminated
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

entity comparator_fsm is
  Port ( data_in : in std_logic_vector(12 downto 0);
         clk : in std_logic;
         rst : in std_logic;
         zero : out std_logic;
         data_out : out std_logic_vector(12 downto 0) := (others => '0')
         );
end comparator_fsm;

architecture Behavioral of comparator_fsm is

type state is (A, B, C, D, E);
signal pr_state, nx_state : state;

begin

process(clk, rst)
begin
    if rst = '1' then
        pr_state <= A;
    elsif rising_edge(clk) then
        pr_state <= nx_state;
    end if;
end process;

process(pr_state, data_in)
variable stored : std_logic_vector(12 downto 0) := (others => '0');
begin
    case pr_state is
        when A =>
            zero <= '0';
            stored := (others => '0');
            if data_in = "0000000000000" then
                nx_state <= A;
            else
                nx_state <= B;
            end if;
        when B =>
            if data_in > stored then
                stored := data_in;
            end if;
            
            if data_in = "0000000000000" then
                nx_state <= D;
            else
                nx_state <= C;
            end if;
        when C =>
            if data_in > stored then
                stored := data_in;
            end if;
            
            if data_in = "0000000000000" then
                nx_state <= D;
            else
                nx_state <= C;
            end if;
        when D =>
            data_out <= stored;
            nx_state <= E;
        when E =>
            zero <= '1';
            nx_state <= A;
    end case;
end process;

end Behavioral;


