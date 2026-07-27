LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_alu IS
END ENTITY tb_alu;

ARCHITECTURE sim OF tb_alu IS

	---------------------------------------------------------------------------
	-- DUT Signals
	---------------------------------------------------------------------------

	SIGNAL operand_a : data_word_t := (OTHERS => '0');
	SIGNAL operand_b : data_word_t := (OTHERS => '0');

	SIGNAL operation : alu_operation_t := ALU_PASS;

	SIGNAL result : data_word_t;

	SIGNAL zero     : STD_LOGIC;
	SIGNAL carry    : STD_LOGIC;
	SIGNAL negative : STD_LOGIC;
	SIGNAL overflow : STD_LOGIC;

BEGIN

	---------------------------------------------------------------------------
	-- Unit Under Test
	---------------------------------------------------------------------------

	uut : ENTITY WORK.alu

	PORT MAP
	(
		operand_a => operand_a,
		operand_b => operand_b,

		operation => operation,

		result => result,

		zero     => zero,
		carry    => carry,
		negative => negative,
		overflow => overflow
	);

	---------------------------------------------------------------------------
	-- Test Process
	---------------------------------------------------------------------------

	stimulus : PROCESS

	-----------------------------------------------------------------------
	-- Generic Test Procedure
	-----------------------------------------------------------------------

	PROCEDURE run_test
	(
		CONSTANT test_name : IN STRING;

		CONSTANT a : IN data_word_t;
		CONSTANT b : IN data_word_t;

		CONSTANT op : IN alu_operation_t;

		CONSTANT expected_result : IN data_word_t;

		CONSTANT expected_zero     : IN STD_LOGIC;
		CONSTANT expected_carry    : IN STD_LOGIC;
		CONSTANT expected_negative : IN STD_LOGIC;
		CONSTANT expected_overflow : IN STD_LOGIC
	) IS

	BEGIN

		operand_a <= a;
		operand_b <= b;
		operation <= op;

		WAIT FOR 10 ns;

		REPORT
		"Running Test: "
		& test_name
		SEVERITY NOTE;

		ASSERT result = expected_result
		REPORT test_name & " : Result mismatch"
		SEVERITY ERROR;

		ASSERT zero = expected_zero
		REPORT test_name & " : Zero flag mismatch"
		SEVERITY ERROR;

		ASSERT carry = expected_carry
		REPORT test_name & " : Carry flag mismatch"
		SEVERITY ERROR;

		ASSERT negative = expected_negative
		REPORT test_name & " : Negative flag mismatch"
		SEVERITY ERROR;

		ASSERT overflow = expected_overflow
		REPORT test_name & " : Overflow flag mismatch"
		SEVERITY ERROR;

	END PROCEDURE;

BEGIN

	-----------------------------------------------------------------------
	-- ADD
	-----------------------------------------------------------------------

	run_test(
		"ADD 3 + 1",
		"0011",
		"0001",
		ALU_ADD,
		"0100",
		'0',
		'0',
		'0',
		'0'
	);

	run_test(
		"ADD 7 + 1",
		"0111",
		"0001",
		ALU_ADD,
		"1000",
		'0',
		'0',
		'1',
		'1'
	);

	run_test(
		"ADD 15 + 1",
		"1111",
		"0001",
		ALU_ADD,
		"0000",
		'1',
		'1',
		'0',
		'0'
	);

	run_test(
		"ADD 7 + 7",
		"0111",
		"0111",
		ALU_ADD,
		"1110",
		'0',
		'0',
		'1',
		'1'
	);

	-----------------------------------------------------------------------
	-- SUB
	-----------------------------------------------------------------------
	run_test(
		"SUB 4 - 1",
		"0100",
		"0001",
		ALU_SUB,
		"0011",
		'0',
		'0',
		'0',
		'0'
	);

	run_test(
		"SUB 0 - 1",
		"0000",
		"0001",
		ALU_SUB,
		"1111",
		'0',
		'1',
		'1',
		'0'
	);

	run_test(
		"SUB 7 - 7",
		"0111",
		"0111",
		ALU_SUB,
		"0000",
		'1',
		'0',
		'0',
		'0'
	);

	run_test(
		"SUB -8 - 1",
		"1000",
		"0001",
		ALU_SUB,
		"0111",
		'0',
		'0',
		'0',
		'1'
	);

	-----------------------------------------------------------------------
	-- INC
	-----------------------------------------------------------------------

	run_test(
		"INC 0",
		"0000",
		"0000",
		ALU_INC,
		"0001",
		'0',
		'0',
		'0',
		'0'
	);

	run_test(
		"INC 15",
		"1111",
		"0000",
		ALU_INC,
		"0000",
		'1',
		'1',
		'0',
		'0'
	);

	-----------------------------------------------------------------------
	-- DEC
	-----------------------------------------------------------------------

	run_test(
		"DEC 1",
		"0001",
		"0000",
		ALU_DEC,
		"0000",
		'1',
		'0',
		'0',
		'0'
	);

	run_test(
		"DEC 0",
		"0000",
		"0000",
		ALU_DEC,
		"1111",
		'0',
		'1',
		'1',
		'0'
	);

	-----------------------------------------------------------------------
	-- AND
	-----------------------------------------------------------------------

	run_test(
		"AND",
		"1111",
		"0011",
		ALU_AND,
		"0011",
		'0',
		'0',
		'0',
		'0'
	);

	-----------------------------------------------------------------------
	-- OR
	-----------------------------------------------------------------------

	run_test(
		"OR",
		"1000",
		"0011",
		ALU_OR,
		"1011",
		'0',
		'0',
		'1',
		'0'
	);

	-----------------------------------------------------------------------
	-- XOR
	-----------------------------------------------------------------------

	run_test(
		"XOR",
		"1111",
		"0011",
		ALU_XOR,
		"1100",
		'0',
		'0',
		'1',
		'0'
	);

	-----------------------------------------------------------------------
	-- NOT
	-----------------------------------------------------------------------

	run_test(
		"NOT",
		"1010",
		"0000",
		ALU_NOT,
		"0101",
		'0',
		'0',
		'0',
		'0'
	);

	-----------------------------------------------------------------------
	-- SHL
	-----------------------------------------------------------------------

	run_test(
		"SHL 1001",
		"1001",
		"0000",
		ALU_SHL,
		"0010",
		'0',
		'1',
		'0',
		'0'
	);

	run_test(
		"SHL 0100",
		"0100",
		"0000",
		ALU_SHL,
		"1000",
		'0',
		'0',
		'1',
		'0'
	);

	-----------------------------------------------------------------------
	-- SHR
	-----------------------------------------------------------------------

	run_test(
		"SHR 1001",
		"1001",
		"0000",
		ALU_SHR,
		"0100",
		'0',
		'1',
		'0',
		'0'
	);

	run_test(
		"SHR 0001",
		"0001",
		"0000",
		ALU_SHR,
		"0000",
		'1',
		'1',
		'0',
		'0'
	);

	-----------------------------------------------------------------------
	-- PASS
	-----------------------------------------------------------------------

	run_test(
		"PASS",
		"1010",
		"0000",
		ALU_PASS,
		"1010",
		'0',
		'0',
		'1',
		'0'
	);
	-----------------------------------------------------------------------
	-- Additional Flag Tests
	-----------------------------------------------------------------------

	run_test(
		"ZERO FLAG",
		"0000",
		"0000",
		ALU_ADD,
		"0000",
		'1',
		'0',
		'0',
		'0'
	);

	run_test(
		"NEGATIVE FLAG",
		"1000",
		"0000",
		ALU_PASS,
		"1000",
		'0',
		'0',
		'1',
		'0'
	);

	run_test(
		"CARRY FLAG",
		"1111",
		"0001",
		ALU_ADD,
		"0000",
		'1',
		'1',
		'0',
		'0'
	);

	run_test(
		"OVERFLOW FLAG",
		"0111",
		"0001",
		ALU_ADD,
		"1000",
		'0',
		'0',
		'1',
		'1'
	);

	-----------------------------------------------------------------------
	-- End of Simulation
	-----------------------------------------------------------------------

	REPORT
	"====================================================="
	SEVERITY NOTE;

	REPORT
	"All ALU tests completed successfully."
	SEVERITY NOTE;

	REPORT
	"====================================================="
	SEVERITY NOTE;

	WAIT;

END PROCESS stimulus;

END ARCHITECTURE sim;
