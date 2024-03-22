library ieee;
use ieee.std_logic_1164.all;

Entity Mux2_5bit is
    Port ( a : in  STD_LOGIC_VECTOR (4 downto 0);
           b : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (4 downto 0));
End Mux2_5bit;

Architecture Behavioral of Mux2_5bit is
Begin
    process(a, b, sel)
    begin
        if sel = '0' then
            y <= a;
        elsif sel = '1' then
            y <= b;
        end if;
    end process;
End Behavioral;
