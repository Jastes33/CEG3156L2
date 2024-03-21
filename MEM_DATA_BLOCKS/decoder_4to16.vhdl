library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_4to16 is
    Port (
        i_in : in STD_LOGIC_VECTOR (3 downto 0);
        o_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end decoder_4to16;

architecture rtl of decoder_4to16 is
		signal int_notin : STD_LOGIC_VECTOR(3 downto 0);
		
begin

int_notin <= not i_in;


--0000
o_out(0) <= ((int_notin(3) and int_notin(2)) and (int_notin(1) and int_notin(0)));
--0001
o_out(1) <= ((int_notin(3) and int_notin(2)) and (int_notin(1) and i_in(0)));
--0010
o_out(2) <= ((int_notin(3) and int_notin(2)) and (i_in(1) and int_notin(0)));
--0011
o_out(3) <= ((int_notin(3) and int_notin(2)) and (i_in(1) and i_in(0)));
--0100
o_out(4) <= ((int_notin(3) and i_in(2)) and (int_notin(1) and int_notin(0)));
--0101
o_out(5) <= ((int_notin(3) and i_in(2)) and (int_notin(1) and i_in(0)));
--0110
o_out(6) <= ((int_notin(3) and i_in(2)) and (i_in(1) and int_notin(0)));
--0111
o_out(7) <= ((int_notin(3) and i_in(2)) and (i_in(1) and i_in(0)));
--1000
o_out(8) <= ((i_in(3) and int_notin(2)) and (int_notin(1) and int_notin(0)));
--1001
o_out(9) <= ((i_in(3) and int_notin(2)) and (int_notin(1) and i_in(0)));
--1010
o_out(10) <= ((i_in(3) and int_notin(2)) and (i_in(1) and int_notin(0)));
--1011
o_out(11) <= ((i_in(3) and int_notin(2)) and (i_in(1) and i_in(0)));
--1100
o_out(12) <= ((i_in(3) and i_in(2)) and (int_notin(1) and int_notin(0)));
--1101
o_out(13) <= ((i_in(3) and i_in(2)) and (int_notin(1) and i_in(0)));
--1110
o_out(14) <= ((i_in(3) and i_in(2)) and (i_in(1) and (int_notin(0))));
--1111
o_out(15) <= ((i_in(3) and i_in(2)) and (i_in(1) and i_in(0)));

end;
