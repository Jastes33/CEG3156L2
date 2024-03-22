library ieee;
use ieee.std_logic_1164.all;

ENTITY PCounter is
    PORT(
        CLK, RST: in std_logic;
        ReadAddress: in std_logic_vector(31 downto 0);
        PC: out std_logic_vector(31 downto 0));
END PCounter;

Architecture rtl of PCounter is
		
    begin
        process(CLK, RST)
        begin
            if RST = '1' then
                PC <= X"00000000";
            elsif falling_edge(CLK) then
                PC <= ReadAddress;
            end if;
        end process;
    end rtl;