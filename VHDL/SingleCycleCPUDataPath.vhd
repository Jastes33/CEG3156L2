library ieee;
use ieee.std_logic_1164.all;

ENTITY SingleCycleCPUDataPath IS
    PORT(
        clk : IN std_logic;
        reset : IN std_logic;
        ValueSel : IN std_logic_vector(2 DOWNTO 0);
        MuxOut : OUT std_logic_vector(7 DOWNTO 0);
        Instuction : IN std_logic_vector(31 DOWNTO 0);
        Branch : OUT std_logic;
        Zero : OUT std_logic;
        MemWrite : OUT std_logic;
        RegWrite : OUT std_logic
    );
END SingleCycleCPUDataPath;

ARCHITECTURE rtl of SingleCycleCPUDataPath is


    --signals
    signal Pcout : std_logic_vector(31 DOWNTO 0);
    signal Instout : std_logic_vector(31 DOWNTO 0);
    signal adder1out, adder2out : std_logic_vector(31 DOWNTO 0);
    signal SignExtendOut : std_logic_vector(31 DOWNTO 0);
    signal ShiftLeft1Out,ShiftLeft2Out : std_logic_vector(31 DOWNTO 0);
    signal Mux1Out,Mux2Out,Mux4Out,Mux5Out : std_logic_vector(31 DOWNTO 0);
    signal Mux3Out : std_logic_vector(4 DOWNTO 0);
    signal Jumpaddr : std_logic_vector(31 DOWNTO 0);
    signal lower,higher : std_logic_vector(31 DOWNTO 0);
    signal Regfile1out,Regfile2out : std_logic_vector(31 DOWNTO 0);
    signal Zeroflag : std_logic;
    signal ALUout : std_logic_vector(31 DOWNTO 0);
    signal ALUControlOut : std_logic_vector(1 DOWNTO 0);
    signal DataOut: std_logic_vector(31 DOWNTO 0);

    --control signals(if the code does not compile, try to add control signals here)

    COMPONENT ALU is
        PORT(
            X: IN std_logic_vector(31 DOWNTO 0);
            Y: IN std_logic_vector(31 DOWNTO 0);
            opcode: IN std_logic_vector(3 DOWNTO 0);
            shamt: IN std_logic_vector(4 DOWNTO 0);
            zero: OUT std_logic;
            R: OUT std_logic_vector(31 DOWNTO 0);
            L: OUT std_logic_vector(31 DOWNTO 0);
            H: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Regfile is
        PORT(
            Clk : IN std_logic;
            Reset : IN std_logic;
            RegWrite : IN std_logic;
            RD : IN std_logic_vector(4 DOWNTO 0);
            RS : IN std_logic_vector(4 DOWNTO 0);
            RT : IN std_logic_vector(4 DOWNTO 0);
            L: OUT std_logic_vector(31 DOWNTO 0);
            H: OUT std_logic_vector(31 DOWNTO 0);
            WData : IN std_logic_vector(31 DOWNTO 0);
            RDData1 : OUT std_logic_vector(31 DOWNTO 0);
            RDData2 : OUT std_logic_vector(31 DOWNTO 0);
            RV : OUT std_logic_vector(31 DOWNTO 0)

        );
    END COMPONENT;

    COMPONENT PCounter is
        PORT(
            CLK : IN std_logic;
            RST : IN std_logic;
            ReadAddress : IN std_logic_vector(31 DOWNTO 0);
            PC : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mux2_5bit is
        PORT(
           a: IN std_logic_vector(4 DOWNTO 0);
           b: IN std_logic_vector(4 DOWNTO 0);
           sel: IN std_logic;
           y: OUT std_logic_vector(4 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mux2_32bit is
        PORT(
            a: IN std_logic_vector(31 DOWNTO 0);
            b: IN std_logic_vector(31 DOWNTO 0);
            sel: IN std_logic;
            y: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT MEM_DATA is
        PORT(
            i_ADDR : IN std_logic_vector(7 DOWNTO 0);
            i_DATA : IN std_logic_vector(7 DOWNTO 0);
            i_clock : IN std_logic;
            i_MEMREAD : IN std_logic;
            i_MEMWRITE : IN std_logic;
            o_DATA : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT SignExtend is
        PORT(
            A : IN std_logic_vector(15 DOWNTO 0);
            B : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ControlUnit is
        PORT(
            clk : IN std_logic;
            reset : IN std_logic;
            OpCode : IN std_logic_vector(7 DOWNTO 0);
            RegDst : OUT std_logic;
            Branch : OUT std_logic;
            MemRead : OUT std_logic;
            MemtoReg : OUT std_logic;
            ALUOp : OUT std_logic_vector(1 DOWNTO 0);
            MemWrite : OUT std_logic;
            ALUSrc : OUT std_logic;
            RegWrite : OUT std_logic
        );
    END COMPONENT;

    COMPONENT MEM_INST is
        PORT(
            i_ADDR : IN std_logic_vector(7 DOWNTO 0);
            i_resetBar : IN std_logic;
            i_clock : IN std_logic;
            o_INTS : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ALUControl is
        PORT(
            Funct : IN std_logic_vector(5 DOWNTO 0);
            ALUOp : IN std_logic_vector(1 DOWNTO 0);
            opcode : IN std_logic_vector(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Adder is
        PORT(
            A : IN std_logic_vector(31 DOWNTO 0);
            B : IN std_logic_vector(31 DOWNTO 0);
            Cin : IN std_logic;
            Cout : OUT std_logic;
            Sum : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ShiftLeft2 is
        PORT(
            A: IN std_logic_vector(31 DOWNTO 0);
            B: OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    BEGIN

        --program counter
        PC : PCounter PORT MAP(
            CLK => clk,
            RST => reset,
            ReadAddress => Instuction,
            PC => Pcout
        );

        --instruction memory
        instructionMemory : MEM_INST PORT MAP(
            i_ADDR => Pcout,
            i_resetBar => not reset,
            i_clock => clk,
            o_INTS => Instout
        );

        --Adder for adding 4 to the PC
        Adder1 : Adder PORT MAP(
            A => Pcout,
            B => "00000000000000000000000000000100",
            Cin => '0',
            Sum => adder1out
        );

        --Adder for adding the offset to the PC
        Adder2 : Adder PORT MAP(
            A => Pcout,
            B => ShiftLeft2Out,
            Cin => '0',
            Sum => adder2out
        );

        --Sign extend the offset
        SignExtend : SignExtend PORT MAP(
            A => Instout(15 DOWNTO 0),
            B => SignExtendOut
        );

        --Shift left 2
        ShiftLeft2 : ShiftLeft2 PORT MAP(
            A => SignExtendOut,
            B => ShiftLeft2Out
        );

        --Mux for selecting between the PC+4 and the PC+offset
        Mux2_32bit1 : Mux2_32bit PORT MAP(
            a => adder1out,
            b => adder2out,
            sel => Branch and Zeroflag,
            y => Mux1Out
        );

        --Mux for jump
        Mux2_32bit2 : Mux2_32bit PORT MAP(
            a => Mux1Out,
            b => adder1out(31 downto 28) & ShiftLeft2Out(25 downto 0),
            sel => Jump,
            y => Mux2Out
        );

        --shift left 2 for jump
        ShiftLeft2Jump : ShiftLeft2 PORT MAP(
            A => Instout(25 DOWNTO 0),
            B => shiftLeft2Out
        );

        --Mux for selecting instruction[20-16] and instruction[15-11]
        Mux2_5bit1 : Mux2_5bit PORT MAP(
            a => Instout(20 DOWNTO 16),
            b => Instout(15 DOWNTO 11),
            sel => RegDst,
            y => Mux3Out
        );

        --Register file
        RegisterFile : Regfile PORT MAP(
            Clk => clk,
            Reset => reset,
            RegWrite => RegWrite,
            RD => Instout(25 DOWNTO 21),
            RS => Instout(25 DOWNTO 21),
            RT => Instout(20 DOWNTO 16),
            L => lower,
            H => higher,
            WData => Mux5Out,
            RDData1 => Regfile1out,
            RDData2 => Regfile2out
        );

        --Mux for ALU source
        Mux2_32bit3 : Mux2_32bit PORT MAP(
            a => Regfile2out,
            b => SignExtendOut,
            sel => ALUSrc,
            y => Mux4Out
        );

        --ALU
        ALU1 : ALU PORT MAP(
            X => Regfile1out,
            Y => Mux4Out,
            opcode => ALUControlOpOut,
            shamt => Instout(10 DOWNTO 6),
            zero => Zeroflag,
            R => ALUout,
            L => lower,
            H => higher
        );
        
        --ALU control
        ALUControl : ALUControl PORT MAP(
            Funct => Instout(5 DOWNTO 0),
            ALUOp => ALUOp,
            opcode => ALUControlOut
        );

        --Data memory
        DataMemory : MEM_DATA PORT MAP(
            i_ADDR => ALUout(31 DOWNTO 24),
            i_DATA => Regfile2out(31 DOWNTO 24),
            i_clock => clk,
            i_MEMREAD => MemRead,
            i_MEMWRITE => MemWrite,
            o_DATA => DataOut
        );

        --Mux for selecting between the ALU output and the data memory output
        Mux2_32bit4 : Mux2_32bit PORT MAP(
            a => ALUout,
            b => DataOut,
            sel => MemtoReg,
            y => Mux5Out
        );

        --Control unit
        ControlUnit1 : ControlUnit PORT MAP(
            clk => clk,
            reset => reset,
            OpCode => Instout(31 DOWNTO 24),
            RegDst => sel,
            Branch => Branch,
            MemRead => i_MEMREAD,
            MemtoReg => sel,
            ALUOp => ALUOp,
            MemWrite => i_MEMWRITE,
            ALUSrc => sel,
            RegWrite => RegWrite
        );
		  
END rtl;