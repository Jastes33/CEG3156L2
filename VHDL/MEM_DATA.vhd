LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

ENTITY MEM_DATA IS
	PORT(
		i_ADDR , i_Data						: IN	STD_LOGIC_VECTOR(7 Downto 0);
		i_clock , i_MEMWRITE, i_MEMREAD	: IN	STD_LOGIC;
		o_data      							: OUT	STD_LOGIC_VECTOR(7 Downto 0));

END MEM_DATA;

ARCHITECTURE rtl OF MEM_DATA IS

SIGNAL int_A, int_B 	: STD_LOGIC_VECTOR (15 DOWNTO 0);

SIGNAL int_regdata, int_data	: STD_LOGIC_VECTOR (7 DOWNTO 0);
type int_regarray IS ARRAY(0 TO 255)OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL int_regout:int_regarray;
type int_muxarray IS ARRAY(0 TO 15)OF STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL int_muxOUT:int_Muxarray;



COMPONENT eightBitmux16by2to1 IS
	PORT(
		in_op0,in_op1,in_op2,in_op3,in_op4,in_op5,in_op6,in_op7:IN STD_LOGIC_VECTOR(7 downto 0);
		in_op8,in_op9,in_op10,in_op11,in_op12,in_op13,in_op14,in_op15:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC_VECTOR(15 downto 0);
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT reg8 IS
	PORT(
		i_clear	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Enable			: IN STD_LOGIC;
		i_data: IN STD_LOGIC_VECTOR(7 downto 0);
		o_Q			: OUT	STD_LOGIC_VECTOR(7 downto 0));
		
END COMPONENT;

COMPONENT eightBitmux2to1 IS
	PORT(
		i_op0:IN STD_LOGIC_VECTOR(7 downto 0);
		i_op1:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;
		
COMPONENT decoder_4to16 is
    Port (
        i_in : in STD_LOGIC_VECTOR (3 downto 0);
        o_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end COMPONENT;		

	
BEGIN

A : decoder_4to16
    Port MAP(
        i_in => i_ADDR(3 DOWnto 0),
        o_out => int_A
    );
	 
B : decoder_4to16
    Port MAP(
        i_in => i_ADDR(7 DOWNTO 4),
        o_out => int_B
    );
	
	ROW_GENERATE :FOR i IN 0 TO 15 GENERATE
		
		in0MUX : eightBitmux16by2to1
		PORT MAP(
			in_op0 => int_regOut((i*16)+0),
			in_op1 => int_regOut((i*16)+1),
			in_op2 => int_regOut((i*16)+2),
			in_op3 => int_regOut((i*16)+3),
			in_op4 => int_regOut((i*16)+4),
			in_op5 => int_regOut((i*16)+5),
			in_op6 => int_regOut((i*16)+6),
			in_op7 => int_regOut((i*16)+7),
			in_op8 => int_regOut((i*16)+8),
			in_op9 => int_regOut((i*16)+9),
			in_op10 => int_regOut((i*16)+10),
			in_op11 => int_regOut((i*16)+11),
			in_op12 => int_regOut((i*16)+12),
			in_op13 => int_regOut((i*16)+13),
			in_op14 => int_regOut((i*16)+14),
			in_op15 => int_regOut((i*16)+15),
			i_selection => int_A,
			o_choice => int_MuxOUT(i)
			);	
		
		reg8_GENERATE :FOR j IN 0 TO 15 GENERATE
		
		REG8_BLOCK : reg8
		PORT MAP(
		i_clear => '1',
		i_clock => i_clock,
		i_Enable => (i_MEMWRITE AND(int_A(i) AND int_B(j))),
		i_data => i_data,
		o_Q => int_regOut(i*16+j)
		);
		END GENERATE;
	
	END GENERATE;

	outMUX : eightBitmux16by2to1
	PORT MAP(
		in_op0 => int_MuxouT(0), 
		in_op1 => int_Muxout(1),
		in_op2 => int_Muxout(2),
		in_op3 => int_Muxout(3),
		in_op4 => int_Muxout(4),
		in_op5 => int_Muxout(5),
		in_op6 => int_Muxout(6),
		in_op7 => int_Muxout(7),
		in_op8 => int_Muxout(8),
		in_op9 => int_Muxout(9),
		in_op10 => int_Muxout(10),
		in_op11 => int_Muxout(11),
		in_op12 => int_Muxout(12),
		in_op13 => int_Muxout(13),
		in_op14 => int_Muxout(14),
		in_op15 => int_Muxout(15),
		i_selection => int_B,
		o_choice => int_data
		);
		
finalmux : eightBitmux2to1
	PORT MAP(
		i_op0 => (others => '0'),
		i_op1 => int_data,
		i_selection => i_MEMREAD,
		o_choice => o_data
		);
	
END rtl;
