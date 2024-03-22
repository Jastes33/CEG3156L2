LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MEM_INST IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_ADDR		: IN	STD_LOGIC_VECTOR(7 downto 0);
		i_clock		: IN	STD_LOGIC;
		o_INTS      : OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));

END MEM_INST;

ARCHITECTURE rtl OF MEM_INST IS

SIGNAL int_memA, int_memB, int_memC, int_memD : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL int_reading : STD_LOGIC;

COMPONENT MEM_DATA IS
	PORT(
		i_ADDR , i_Data						: IN	STD_LOGIC_VECTOR(7 Downto 0);
		i_clock , i_MEMWRITE, i_MEMREAD	: IN	STD_LOGIC;
		o_data      							: OUT	STD_LOGIC_VECTOR(7 Downto 0));

END COMPONENT;

COMPONENT eightBitmux2to1 IS
	PORT(
		i_op0:IN STD_LOGIC_VECTOR(7 downto 0);
		i_op1:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;		
		
BEGIN

memA : MEM_DATA
	PORT MAP(
		i_ADDR => i_ADDR,
		i_Data => (others => '0'),
		i_clock => i_clock,
		i_MEMWRITE => '0',
		i_MEMREAD => '1',
		o_data => int_memA
		);

muxA : eightBitmux2to1
	PORT MAP(
		i_op0 => (others => '0'),
		i_op1 => int_memA,
		i_selection => int_reading,
		o_choice => o_INTS(31 downto 24)
		);	


memB : MEM_DATA
	PORT MAP(
		i_ADDR => i_ADDR,
		i_Data => (OTHERS => '1'),
		i_clock => i_clock,
		i_MEMWRITE => '0',
		i_MEMREAD => '1',
		o_data => int_memB
		);

muxB : eightBitmux2to1
	PORT MAP(
		i_op0 => (OTHERS => '0'),
		i_op1 => int_memB,
		i_selection => int_reading,
		o_choice => o_INTS(23 downto 16)
		);	


memC : MEM_DATA
	PORT MAP(
		i_ADDR => i_ADDR,
		i_Data => (others => '0'),
		i_clock => i_clock,
		i_MEMWRITE => '0',
		i_MEMREAD => '1',
		o_data => int_memC
		);

muxC : eightBitmux2to1
	PORT MAP(
		i_op0 => (others => '0'),
		i_op1 => int_memC,
		i_selection => int_reading,
		o_choice => o_INTS(15 downto 8)
		);	

memD : MEM_DATA
	PORT MAP(
		i_ADDR => i_ADDR,
		i_Data => (others => '1'),
		i_clock => i_clock,
		i_MEMWRITE => '0',
		i_MEMREAD => '1',
		o_data => int_memD
		);

muxD : eightBitmux2to1
	PORT MAP(
		i_op0 => (others => '0'),
		i_op1 => int_memD,
		i_selection => int_reading,
		o_choice => o_INTS(7 downto 0)
		);	

int_reading <= ((not i_ADDR(0)) and (not i_ADDR(1)));

END;
