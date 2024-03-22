--Lab2 CEG3155 Group 3
--add i_operation =0
--sub i_operation =1
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY addSUB IS
	PORT(
	i_xx, i_yy : IN STD_logic_vector(0 to 7);
	--i_cinBit :IN STD_logic;
	i_operation: IN STD_logic;
	o_s:OUT STD_logic_vector(0 to 7);
	o_c:OUT STD_logic);
	
END addSUB;

Architecture rtl of addSUB IS

	SIGNAL int_c :STD_logic_vector(0 to 7);

	component fullADD
		PORT(
		i_x, i_y, i_cin : IN STD_logic;
		o_sum, o_cout :OUT STD_logic);
	END component;

BEGIN
	aFulladd : fullADD
	PORT MAP(
	i_x => i_xx(7),
	i_y => (i_yy(7) xor i_operation),
	i_cin => i_operation,
	o_sum => o_s(7),
	o_cout => int_c(0)
	);
	
	bFulladd : fullADD
	PORT MAP(
	i_x => i_xx(6),
	i_y => (i_yy(6) xor i_operation),
	i_cin => int_c(0),
	o_sum => o_s(6),
	o_cout => int_c(1)
	);
	
	cFulladd : fullADD
	PORT MAP(
	i_x => i_xx(5),
	i_y => (i_yy(5) xor i_operation),
	i_cin => int_c(1),
	o_sum => o_s(5),
	o_cout => int_c(2)
	);
	
	dFulladd : fullADD
	PORT MAP(
	i_x => i_xx(4),
	i_y => (i_yy(4) xor i_operation),
	i_cin => int_c(2),
	o_sum => o_s(4),
	o_cout => int_c(3)
	);
	
	eFulladd : fullADD
	PORT MAP(
	i_x => i_xx(3),
	i_y => (i_yy(3) xor i_operation),
	i_cin => int_c(3),
	o_sum => o_s(3),
	o_cout => int_c(4)
	);
	
	fFulladd : fullADD
	PORT MAP(
	i_x => i_xx(2),
	i_y => (i_yy(2) xor i_operation),
	i_cin => int_c(4),
	o_sum => o_s(2),
	o_cout => int_c(5)
	);
	
	gFulladd : fullADD
	PORT MAP(
	i_x => i_xx(1),
	i_y => (i_yy(1) xor i_operation),
	i_cin => int_c(5),
	o_sum => o_s(1),
	o_cout => int_c(6)
	);
	
	hFulladd : fullADD
	PORT MAP(
	i_x => i_xx(0),
	i_y =>(i_yy(0) xor i_operation),
	i_cin => int_c(6),
	o_sum => o_s(0),
	o_cout => o_c
	);
	
END rtl;
	