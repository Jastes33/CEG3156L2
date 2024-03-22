--Lab1 Group 3 CEG3155
--Jessica Hemstead 300214909
--Alexander Wilson 300219585

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightBitmux16by2to1 IS
	PORT(
		in_op0,in_op1,in_op2,in_op3,in_op4,in_op5,in_op6,in_op7:IN STD_LOGIC_VECTOR(7 downto 0);
		in_op8,in_op9,in_op10,in_op11,in_op12,in_op13,in_op14,in_op15:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC_VECTOR(15 downto 0);
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END eightBitmux16by2to1;

Architecture rtl OF eightBitmux16by2to1 IS

type int_arrayChoice IS ARRAY(15 DOWNTO 0)OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL int_choice:int_arrayChoice;




component eightBitmux2to1 IS
	PORT(
		i_op0:IN STD_LOGIC_VECTOR(7 downto 0);
		i_op1:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;
BEGIN
		
		AMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op0 => in_op0,
		i_op1 => in_op0,
		i_selection => i_selection(0),--1
		o_choice => int_choice(0) 
		);
		
		BMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op1,
		i_op0 => int_choice(0),
		i_selection => i_selection(1),--0
		o_choice => int_choice(1) 
		);
		CMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op2,
		i_op0 => int_choice(1),
		i_selection => i_selection(2),--0
		o_choice => int_choice(2) 
		);
		DMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op3,
		i_op0 => int_choice(2),
		i_selection => i_selection(3),
		o_choice => int_choice(3) 
		);
		EMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op4,
		i_op0 => int_choice(3),
		i_selection => i_selection(4),
		o_choice => int_choice(4) 
		);
		FMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op5,
		i_op0 => int_choice(4),
		i_selection => i_selection(5),
		o_choice => int_choice(5) 
		);
		GMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op6,
		i_op0 => int_choice(5),
		i_selection => i_selection(6),
		o_choice => int_choice(6) 
		);
		HMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op7,
		i_op0 => int_choice(6),
		i_selection => i_selection(7),
		o_choice => int_choice(7) 
		);
		IMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op8,
		i_op0 => int_choice(7),
		i_selection => i_selection(8),
		o_choice => int_choice(8) 
		);
		JMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op9,
		i_op0 => int_choice(8),
		i_selection => i_selection(9),
		o_choice => int_choice(9) 
		);
		KMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op10,
		i_op0 => int_choice(9),
		i_selection => i_selection(10),
		o_choice => int_choice(10) 
		);
		LMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op11,
		i_op0 => int_choice(10),
		i_selection => i_selection(11),
		o_choice => int_choice(11) 
		);
		MMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op12,
		i_op0 => int_choice(11),
		i_selection => i_selection(12),
		o_choice => int_choice(12) 
		);
		NMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op13,
		i_op0 => int_choice(12),
		i_selection => i_selection(13),
		o_choice => int_choice(13) 
		);
		OMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op14,
		i_op0 => int_choice(13),
		i_selection => i_selection(14),
		o_choice => int_choice(14) 
		);

		PMUX_BLOCK : eightBitmux2to1
		PORT MAP(
		i_op1 => in_op15,
		i_op0 => int_choice(14),
		i_selection => i_selection(15),
		o_choice => o_Choice 
		);
END rtl;		
		