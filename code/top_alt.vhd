----------------------------------------------------------------------------------
-- Engineer: Ezra Santos
-- 
-- Create Date: 06/19/2024 12:35:45 AM
-- Design Name: Top
-- Module Name: top - Behavioral
-- Project Name: Sequence Peak Generator
-- Target Devices: Basys3
-- Tool Versions: 
-- Description: Top module for the sequence peak generator
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

entity top_alt is
    Port ( sw : in STD_LOGIC_VECTOR (12 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enter : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           led : out STD_LOGIC_VECTOR (12 downto 0));
end top_alt;

architecture Behavioral of top_alt is

component input_module
    Port ( sw : in STD_LOGIC_VECTOR (12 downto 0);
           clk : in std_logic;
           led : out STD_LOGIC_VECTOR (12 downto 0);
           data_out : out STD_LOGIC_VECTOR (12 downto 0);
           enter : in STD_LOGIC);
end component;

component comparator_fsm
  Port ( data_in : in std_logic_vector(12 downto 0);
         clk : in std_logic;
         rst : in std_logic;
         zero : out std_logic;
         data_out : out std_logic_vector(12 downto 0)
         );
end component;

component double_dabble
    Port ( CLK 	: in  	STD_LOGIC;
			 RESET 	: in		STD_LOGIC;
           BIN 	: in  	UNSIGNED (15 downto 0);
           BCD 	: out  	STD_LOGIC_VECTOR (15 downto 0)
			  );
end component;

component display_v2
    Port ( clk : in STD_LOGIC;
           data_in : in std_logic_vector(15 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal data_temp1 : std_logic_vector(12 downto 0);
signal data_temp2 : std_logic_vector(12 downto 0);
signal data_temp3 : std_logic_vector(15 downto 0);

signal zero_sig : std_logic;

begin

in_mod : input_module
port map (
    sw => sw,
    clk => clk,
    led => led,
    data_out => data_temp1,
    enter => enter);

comp : comparator_fsm
port map (
    data_in => data_temp1,
    clk => clk,
    rst => rst,
    zero => zero_sig,
    data_out => data_temp2);
    
dd : double_dabble
port map (
    CLK => clk,
    RESET => zero_sig,
    BIN => unsigned("000" & data_temp2),
    BCD => data_temp3);
    
disp : display_v2
port map (
    clk => clk,
    data_in => data_temp3,
    seg => seg,
    an => an);

end Behavioral;
