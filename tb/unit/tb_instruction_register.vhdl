LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_instruction_register IS
END ENTITY tb_instruction_register;

ARCHITECTURE sim OF tb_instruction_register IS

	SIGNAL clk    : STD_LOGIC := '0';
	SIGNAL reset  : STD_LOGIC := '0';
	SIGNAL enable : STD_LOGIC := '0';

	SIGNAL instruction_in  : instruction_t := (OTHERS => '0');
	SIGNAL instruction_out : instruction_t;

	CONSTANT clk_period : TIME := 10 ns;

	PROCEDURE run_test (
		CONSTANT name : STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name SEVERITY NOTE;
	END PROCEDURE;

BEGIN

	uut : ENTITY WORK.instruction_register
	PORT MAP
	(
		clk             => clk,
		reset           => reset,
		enable          => enable,
		instruction_in  => instruction_in,
		instruction_out => instruction_out
	);

	clk_process : PROCESS
	BEGIN
		LOOP
			clk <= '0';
			WAIT FOR clk_period / 2;
			clk <= '1';
			WAIT FOR clk_period / 2;
		END LOOP;
		END PROCESS clk_process;

		stimulus : PROCESS
		BEGIN

			-----------------------------------------------------------------------
			-- RESET
			-----------------------------------------------------------------------

			run_test("RESET");

			reset <= '1';
			enable <= '0';
			instruction_in <= (OTHERS => '1');

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT instruction_out = instruction_t'(OTHERS => '0')            		REPORT "RESET failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD INSTRUCTION
			-----------------------------------------------------------------------

			run_test("LOAD INSTRUCTION");

			reset <= '0';
			enable <= '1';
			instruction_in <= x"1234";

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT instruction_out = x"1234"
			REPORT "Instruction load failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- HOLD VALUE
			-----------------------------------------------------------------------

			run_test("ENABLE LOW");

			enable <= '0';
			instruction_in <= x"FFFF";

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT instruction_out = x"1234"
			REPORT "Register changed while enable=0"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD NEW VALUE
			-----------------------------------------------------------------------

			run_test("LOAD SECOND INSTRUCTION");

			enable <= '1';
			instruction_in <= x"ABCD";

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT instruction_out = x"ABCD"
			REPORT "Second instruction load failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- RESET AGAIN
			-----------------------------------------------------------------------

			run_test("RESET AFTER WRITE");

			reset <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT instruction_out = instruction_t'(OTHERS => '0')
			REPORT "Reset after write failed"
			SEVERITY ERROR;

			REPORT "=====================================================" SEVERITY NOTE;
			REPORT "All Instruction Register tests completed successfully." SEVERITY NOTE;
			REPORT "=====================================================" SEVERITY NOTE;

			WAIT;

		END PROCESS stimulus;

	END ARCHITECTURE sim;
