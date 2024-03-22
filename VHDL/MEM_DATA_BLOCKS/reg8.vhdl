LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg8 IS
	PORT(
		i_clear	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Enable			: IN STD_LOGIC;
		i_data: IN STD_LOGIC_VECTOR(7 downto 0);
		o_Q			: OUT	STD_LOGIC_VECTOR(7 downto 0));
		
END reg8;

ARCHITECTURE rtl OF reg8 IS
	SIGNAL int_Q : STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

Pa: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(0),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(0));	

Pb: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(1),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(1));		  

Pc: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(2),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(2));	

Pd: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(3),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(3));	

Pe: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(4),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(4));	

Pf: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(5),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(5));				  
			  
Pg: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(6),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(6));	

Ph: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data(7),
			  i_enable => i_Enable, 
			  i_clock => i_clock,
			  o_q => o_Q(7));	

	
END rtl;