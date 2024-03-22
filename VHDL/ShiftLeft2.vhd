library ieee;
use ieee.std_logic_1164.all;

ENTITY ShiftLeft2 is
    PORT(
        A : IN std_logic_vector(31 DOWNTO 0);
        B : OUT std_logic_vector(31 DOWNTO 0)
    );
END ENTITY ShiftLeft2;

ARCHITECTURE Behavioral OF ShiftLeft2 IS
BEGIN
    B <= A(29 DOWNTO 0) & "00";
END ARCHITECTURE Behavioral;