--Lab1 Group 3 CEG3155
--Jessica Hemstead 300214909
--Alexander Wilson 300219585

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightBitmux2to1 IS
	PORT(
		i_op0:IN STD_LOGIC_VECTOR(7 downto 0);
		i_op1:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END eightBitmux2to1;

Architecture eightBitmux2to1_a OF eightBitmux2to1 IS

BEGIN

	o_choice(0) <= (( i_op0(0) and (not i_selection)) or (i_op1(0) and (i_selection)) );
	o_choice(1) <= (( i_op0(1) and (not i_selection)) or (i_op1(1) and (i_selection)) );
	o_choice(2) <= (( i_op0(2) and (not i_selection)) or (i_op1(2) and (i_selection)) );
	o_choice(3) <= (( i_op0(3) and (not i_selection)) or (i_op1(3) and (i_selection)) );
	o_choice(4) <= (( i_op0(4) and (not i_selection)) or (i_op1(4) and (i_selection)) );
	o_choice(5) <= (( i_op0(5) and (not i_selection)) or (i_op1(5) and (i_selection)) );
	o_choice(6) <= (( i_op0(6) and (not i_selection)) or (i_op1(6) and (i_selection)) );
	o_choice(7) <= (( i_op0(7) and (not i_selection)) or (i_op1(7) and (i_selection)) );

END eightBitmux2to1_a;