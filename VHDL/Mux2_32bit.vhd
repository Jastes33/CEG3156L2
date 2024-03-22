library ieee;
use ieee.std_logic_1164.all;

Entity Mux2_32bit is
    Port ( signal sel : in std_logic;
           signal a : in std_logic_vector(31 downto 0);
           signal b : in std_logic_vector(31 downto 0);
           signal y : out std_logic_vector(31 downto 0));
End Mux2_32bit;

Architecture Behavioral of Mux2_32bit is
Begin
    process(sel, a, b)
    begin
        if sel = '0' then
            y <= a;
        elsif sel = '1' then
            y <= b;
        end if;
    end process;
End Behavioral;