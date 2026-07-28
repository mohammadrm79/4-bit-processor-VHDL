-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_instruction_decoder.vhdl
-- Description  : Unit Testbench for Instruction Decoder
--
-- Version      : 1.0.0
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_instruction_decoder IS
END ENTITY;

ARCHITECTURE sim OF tb_instruction_decoder IS

	---------------------------------------------------------------------------
	-- DUT Signals
	---------------------------------------------------------------------------

	SIGNAL instruction : instruction_t := (OTHERS => '0');

	SIGNAL opcode : opcode_t;
	SIGNAL format : instruction_format_t;

	SIGNAL register_a : register_index_t;
	SIGNAL source_a   : register_index_t;
	SIGNAL source_b   : register_index_t;

	SIGNAL immediate : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL address   : address_t;

	---------------------------------------------------------------------------
	-- Test helper
	---------------------------------------------------------------------------

	PROCEDURE run_test(
		CONSTANT name : IN STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name SEVERITY NOTE;
	END PROCEDURE;

BEGIN

	---------------------------------------------------------------------------
	-- DUT
	---------------------------------------------------------------------------

	dut : ENTITY WORK.instruction_decoder
	PORT MAP (
		instruction => instruction,

		opcode => opcode,
		format => format,

		register_a => register_a,
		source_a   => source_a,
		source_b   => source_b,

		immediate => immediate,
		address   => address
	);

	---------------------------------------------------------------------------
	-- Stimulus
	---------------------------------------------------------------------------

	stimulus : PROCESS
	BEGIN

		-----------------------------------------------------------------------
		-- R TYPE (ADD)
		-----------------------------------------------------------------------

		run_test("R-TYPE ADD");

		instruction <=
		OP_ADD &
		"001" &
		"010" &
		"011" &
		"00";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_ADD
		REPORT "Opcode decode failed"
		SEVERITY FAILURE;

		ASSERT format = R_TYPE
		REPORT "Format decode failed"
		SEVERITY FAILURE;

		ASSERT register_a = "001"
		REPORT "Destination register failed"
		SEVERITY FAILURE;

		ASSERT source_a = "010"
		REPORT "Source A failed"
		SEVERITY FAILURE;

		ASSERT source_b = "011"
		REPORT "Source B failed"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- MOVI
		-----------------------------------------------------------------------

		run_test("MOVI");

		instruction <=
		OP_MOVI &
		"101" &
		x"5A";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_MOVI
		SEVERITY FAILURE;

		ASSERT format = I_TYPE
		SEVERITY FAILURE;

		ASSERT register_a = "101"
		SEVERITY FAILURE;

		ASSERT immediate = x"5A"
		REPORT "Immediate decode failed"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- LOAD
		-----------------------------------------------------------------------

		run_test("LOAD");

		instruction <=
		OP_LOAD &
		"010" &
		x"33";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_LOAD
		SEVERITY FAILURE;

		ASSERT format = I_TYPE
		SEVERITY FAILURE;

		ASSERT register_a = "010"
		SEVERITY FAILURE;

		ASSERT immediate = x"33"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- STORE
		-----------------------------------------------------------------------

		run_test("STORE");

		instruction <=
		OP_STORE &
		"111" &
		x"AA";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_STORE
		SEVERITY FAILURE;

		ASSERT format = I_TYPE
		SEVERITY FAILURE;

		ASSERT register_a = "111"
		SEVERITY FAILURE;

		ASSERT immediate = x"AA"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- JMP
		-----------------------------------------------------------------------

		run_test("JMP");

		instruction <=
		OP_JMP &
		"10101010101";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_JMP
		SEVERITY FAILURE;

		ASSERT format = J_TYPE
		SEVERITY FAILURE;

		ASSERT address = "10101010101"
		REPORT "Jump address decode failed"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- JZ
		-----------------------------------------------------------------------

		run_test("JZ");

		instruction <=
		OP_JZ &
		"00011110000";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_JZ
		SEVERITY FAILURE;

		ASSERT format = J_TYPE
		SEVERITY FAILURE;

		ASSERT address = "00011110000"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- JC
		-----------------------------------------------------------------------

		run_test("JC");

		instruction <=
		OP_JC &
		"11100011100";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_JC
		SEVERITY FAILURE;

		ASSERT format = J_TYPE
		SEVERITY FAILURE;

		ASSERT address = "11100011100"
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- HALT
		-----------------------------------------------------------------------

		run_test("HALT");

		instruction <=
		OP_HALT &
		"00000000000";

		WAIT FOR 1 ns;

		ASSERT opcode = OP_HALT
		SEVERITY FAILURE;

		ASSERT format = S_TYPE
		SEVERITY FAILURE;

		-----------------------------------------------------------------------
		-- FINISH
		-----------------------------------------------------------------------

		REPORT "====================================================="
		SEVERITY NOTE;

		REPORT "All Instruction Decoder tests completed successfully."
		SEVERITY NOTE;

		REPORT "====================================================="
		SEVERITY NOTE;

		WAIT;

	END PROCESS stimulus;

END ARCHITECTURE sim;
