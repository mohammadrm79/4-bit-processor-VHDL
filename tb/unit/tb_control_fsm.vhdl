-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_control_fsm.vhdl
-- Description  : Unit Testbench for Control FSM
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_control_fsm IS
END ENTITY;

ARCHITECTURE sim OF tb_control_fsm IS

	CONSTANT CLK_PERIOD : TIME := 10 ns;

	SIGNAL clk   : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC := '0';

	SIGNAL opcode : opcode_t := OP_NOP;

	SIGNAL zero_flag  : STD_LOGIC := '0';
	SIGNAL carry_flag : STD_LOGIC := '0';

	SIGNAL state_out : cpu_state_t;

	SIGNAL pc_enable             : STD_LOGIC;
	SIGNAL pc_load               : STD_LOGIC;
	SIGNAL ir_enable             : STD_LOGIC;
	SIGNAL register_write_enable : STD_LOGIC;
	SIGNAL flags_write_enable    : STD_LOGIC;
	SIGNAL memory_read_enable    : STD_LOGIC;
	SIGNAL memory_write_enable   : STD_LOGIC;
	SIGNAL alu_operation         : alu_operation_t;
	SIGNAL write_back_source     : write_back_source_t;
	SIGNAL halted                : STD_LOGIC;
	SIGNAL alu_result_enable     : STD_LOGIC;

	PROCEDURE run_test(
		CONSTANT name : STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name SEVERITY note;
	END PROCEDURE;

BEGIN

	---------------------------------------------------------------------------
	-- Clock
	---------------------------------------------------------------------------

	clk <= NOT clk AFTER CLK_PERIOD / 2;

	---------------------------------------------------------------------------
	-- DUT
	---------------------------------------------------------------------------

	dut : ENTITY WORK.control_fsm
	PORT MAP
	(
		clk   => clk,
		reset => reset,

		opcode => opcode,

		zero_flag  => zero_flag,
		carry_flag => carry_flag,

		state_out => state_out,

		pc_enable => pc_enable,
		pc_load   => pc_load,
		ir_enable => ir_enable,

		register_write_enable => register_write_enable,
		flags_write_enable    => flags_write_enable,

		memory_read_enable  => memory_read_enable,
		memory_write_enable => memory_write_enable,

		alu_operation     => alu_operation,
		write_back_source => write_back_source,

		halted => halted,

		alu_result_enable => alu_result_enable
	);

	---------------------------------------------------------------------------
	-- Stimulus
	---------------------------------------------------------------------------

	stimulus : PROCESS
	BEGIN

		-----------------------------------------------------------------------
		-- RESET
		-----------------------------------------------------------------------

		run_test("RESET");

		reset <= '1';

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT state_out = STATE_RESET
		REPORT "RESET failed"
		SEVERITY failure;

		reset <= '0';

		-----------------------------------------------------------------------
		-- FETCH
		-----------------------------------------------------------------------

		run_test("FETCH");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT state_out = FETCH
		SEVERITY failure;

		ASSERT pc_enable = '1'
		SEVERITY failure;

		ASSERT ir_enable = '1'
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- DECODE
		-----------------------------------------------------------------------

		run_test("DECODE");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT state_out = DECODE
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- EXECUTE ADD
		-----------------------------------------------------------------------

		opcode <= OP_ADD;

		run_test("EXECUTE ADD");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		SEVERITY failure;

		ASSERT alu_operation = ALU_ADD
		SEVERITY failure;

		ASSERT flags_write_enable = '1'
		SEVERITY failure;

		ASSERT alu_result_enable = '1'
		SEVERITY failure;
		-----------------------------------------------------------------------
		-- WRITE BACK (ADD)
		-----------------------------------------------------------------------

		run_test("WRITE BACK ADD");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT state_out = WRITE_BACK
		SEVERITY failure;

		ASSERT register_write_enable = '1'
		SEVERITY failure;

		ASSERT write_back_source = WB_ALU
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FETCH
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- DECODE
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- EXECUTE MOVI
		-----------------------------------------------------------------------

		opcode <= OP_MOVI;

		run_test("EXECUTE MOVI");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		SEVERITY failure;

		ASSERT write_back_source = WB_IMMEDIATE
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- WRITE BACK MOVI
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT register_write_enable = '1'
		SEVERITY failure;

		ASSERT write_back_source = WB_IMMEDIATE
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FETCH
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- DECODE
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- EXECUTE LOAD
		-----------------------------------------------------------------------

		opcode <= OP_LOAD;

		run_test("EXECUTE LOAD");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT memory_read_enable = '1'
		SEVERITY failure;

		ASSERT write_back_source = WB_MEMORY
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- WRITE BACK LOAD
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT register_write_enable = '1'
		SEVERITY failure;

		ASSERT write_back_source = WB_MEMORY
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FETCH
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- DECODE
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- EXECUTE STORE
		-----------------------------------------------------------------------

		opcode <= OP_STORE;

		run_test("EXECUTE STORE");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT memory_write_enable = '1'
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- WRITE BACK STORE
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT register_write_enable = '0'
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FETCH
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- DECODE
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- EXECUTE JMP
		-----------------------------------------------------------------------

		opcode <= OP_JMP;

		run_test("EXECUTE JMP");

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT pc_load = '1'
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FETCH
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- DECODE
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- EXECUTE JZ TAKEN
		-----------------------------------------------------------------------

		opcode <= OP_JZ;
		zero_flag <= '1';

		run_test("EXECUTE JZ TAKEN");

		-- FETCH
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-- DECODE -> EXECUTE
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		REPORT "FSM should be in EXECUTE state"
		SEVERITY failure;

		ASSERT pc_load = '1'
		REPORT "JZ should assert pc_load when Zero=1"
		SEVERITY failure;

		zero_flag <= '0';

		-----------------------------------------------------------------------
		-- WRITE BACK
		-----------------------------------------------------------------------

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;
		-----------------------------------------------------------------------
		-- TEST : JZ TAKEN
		-----------------------------------------------------------------------

		REPORT "Running Test: JZ TAKEN" SEVERITY note;

		reset <= '1';
		WAIT UNTIL rising_edge(clk);
		reset <= '0';

		-- FETCH
		WAIT UNTIL rising_edge(clk);

		-- DECODE
		WAIT UNTIL rising_edge(clk);

		opcode <= OP_JZ;
		zero_flag <= '1';

		-- EXECUTE
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		SEVERITY failure;

		ASSERT pc_load = '1'
		REPORT "JZ should load PC when Zero=1"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- TEST : JZ NOT TAKEN
		-----------------------------------------------------------------------

		REPORT "Running Test: JZ NOT TAKEN" SEVERITY note;

		reset <= '1';
		WAIT UNTIL rising_edge(clk);
		reset <= '0';

		WAIT UNTIL rising_edge(clk);
		WAIT UNTIL rising_edge(clk);

		opcode <= OP_JZ;
		zero_flag <= '0';

		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		SEVERITY failure;

		ASSERT pc_load = '0'
		REPORT "JZ should not load PC when Zero=0"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- TEST : JC TAKEN
		-----------------------------------------------------------------------

		REPORT "Running Test: JC TAKEN" SEVERITY note;

		reset <= '1';
		WAIT UNTIL rising_edge(clk);
		reset <= '0';

		-- FETCH
		WAIT UNTIL rising_edge(clk);

		-- DECODE
		WAIT UNTIL rising_edge(clk);

		opcode <= OP_JC;
		carry_flag <= '1';

		-- EXECUTE
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		REPORT "FSM should be in EXECUTE state"
		SEVERITY failure;

		ASSERT pc_load = '1'
		REPORT "JC should load PC when Carry=1"
		SEVERITY failure;

		carry_flag <= '0';

		-- WRITE_BACK (اختیاری ولی بهتر است)
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		-----------------------------------------------------------------------
		-- TEST : HALT
		-----------------------------------------------------------------------

		REPORT "Running Test: HALT" SEVERITY note;

		reset <= '1';
		WAIT UNTIL rising_edge(clk);
		reset <= '0';

		-- FETCH
		WAIT UNTIL rising_edge(clk);

		-- DECODE
		WAIT UNTIL rising_edge(clk);

		opcode <= OP_HALT;

		-- EXECUTE
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT state_out = EXECUTE
		REPORT "FSM should be in EXECUTE state before HALTED"
		SEVERITY failure;

		ASSERT halted = '0'
		REPORT "HALTED asserted too early"
		SEVERITY failure;

		-- STATE_HALTED
		WAIT UNTIL rising_edge(clk);
		WAIT FOR 1 ns;

		ASSERT state_out = STATE_HALTED
		REPORT "FSM did not enter STATE_HALTED"
		SEVERITY failure;

		ASSERT halted = '1'
		REPORT "HALT failed"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- DONE
		-----------------------------------------------------------------------

		REPORT "====================================================="
		SEVERITY note;

		REPORT "All Control FSM tests completed successfully."
		SEVERITY note;

		REPORT "====================================================="
		SEVERITY note;

		WAIT;

	END PROCESS stimulus;

END ARCHITECTURE sim;
