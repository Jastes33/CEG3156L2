library ieee;
use ieee.std_logic_1164.all;

ENTITY SignExtend is
    PORT (
        A: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        B: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END SignExtend;

ARCHITECTURE RTL OF SignExtend IS
BEGIN
    B <= (others => A(15));
END RTL;
