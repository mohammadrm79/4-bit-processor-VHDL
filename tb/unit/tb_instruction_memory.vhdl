-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_instruction_memory.vhdl
-- Description  : Unit Testbench for Instruction Memory
--
-- Version      : 1.0.0
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_instruction_memory IS
END ENTITY tb_instruction_memory;

ARCHITECTURE sim OF tb_instruction_memory IS

	SIGNAL address : address_t := (OTHERS => '0');

	SIGNAL instruction : instruction_t;

	---------------------------------------------------------------------------
	-- Test helper
	---------------------------------------------------------------------------

	PROCEDURE run_test(
		CONSTANT name : IN STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name SEVERITY note;
	END PROCEDURE;

BEGIN

	---------------------------------------------------------------------------
	-- DUT
	---------------------------------------------------------------------------

	dut : ENTITY WORK.instruction_memory
	GENERIC MAP
	(
		DEPTH        => 256,
		PROGRAM_FILE => "tb/programs/program_test.mem"
	)
	PORT MAP
	(
		address     => address,
		instruction => instruction
	);

	---------------------------------------------------------------------------
	-- Stimulus
	---------------------------------------------------------------------------

	stimulus : PROCESS
	BEGIN

		-----------------------------------------------------------------------
		-- ADDRESS 0
		-----------------------------------------------------------------------

		run_test("READ ADDRESS 0");

		address <= STD_LOGIC_VECTOR(to_unsigned(0, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"1234"
		REPORT "Address 0 mismatch"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- ADDRESS 1
		-----------------------------------------------------------------------

		run_test("READ ADDRESS 1");

		address <= STD_LOGIC_VECTOR(to_unsigned(1, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"5678"
		REPORT "Address 1 mismatch"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- ADDRESS 2
		-----------------------------------------------------------------------

		run_test("READ ADDRESS 2");

		address <= STD_LOGIC_VECTOR(to_unsigned(2, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"9ABC"
		REPORT "Address 2 mismatch"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- ADDRESS 3
		-----------------------------------------------------------------------

		run_test("READ ADDRESS 3");

		address <= STD_LOGIC_VECTOR(to_unsigned(3, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"DEF0"
		REPORT "Address 3 mismatch"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- ADDRESS 5
		-----------------------------------------------------------------------

		run_test("READ ADDRESS 5");

		address <= STD_LOGIC_VECTOR(to_unsigned(5, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"FFFF"
		REPORT "Address 5 mismatch"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- UNUSED MEMORY
		-----------------------------------------------------------------------

		run_test("UNINITIALIZED LOCATION");

		address <= STD_LOGIC_VECTOR(to_unsigned(100, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"0000"
		REPORT "Unused memory should be zero"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- LAST VALID ADDRESS
		-----------------------------------------------------------------------

		run_test("LAST ADDRESS");

		address <= STD_LOGIC_VECTOR(to_unsigned(255, address'length));

		WAIT FOR 1 ns;

		ASSERT instruction = x"0000"
		REPORT "Last address should be zero"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FINISH
		-----------------------------------------------------------------------

		REPORT "====================================================="
		SEVERITY note;

		REPORT "All Instruction Memory tests completed successfully."
		SEVERITY note;

		REPORT "====================================================="
		SEVERITY note;

		WAIT;

	END PROCESS stimulus;

END ARCHITECTURE sim;
