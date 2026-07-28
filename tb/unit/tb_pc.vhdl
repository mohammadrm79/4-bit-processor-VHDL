LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_pc IS
END ENTITY tb_pc;

ARCHITECTURE sim OF tb_pc IS

	SIGNAL clk   : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC := '0';

	SIGNAL enable : STD_LOGIC := '0';
	SIGNAL load   : STD_LOGIC := '0';

	SIGNAL next_address : address_t := (OTHERS => '0');

	SIGNAL pc_value : address_t;

	CONSTANT CLK_PERIOD : TIME := 10 ns;

	PROCEDURE run_test(
		CONSTANT name : STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name
		SEVERITY NOTE;
	END PROCEDURE;

BEGIN

	uut : ENTITY WORK.pc
	PORT MAP
	(
		clk          => clk,
		reset        => reset,
		enable       => enable,
		load         => load,
		next_address => next_address,
		pc_value     => pc_value
	);

	clk_process : PROCESS
	BEGIN
		LOOP
			clk <= '0';
			WAIT FOR CLK_PERIOD / 2;
			clk <= '1';
			WAIT FOR CLK_PERIOD / 2;
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
			load <= '0';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT pc_value = address_t'(OTHERS => '0')
			REPORT "RESET failed"
			SEVERITY ERROR;

			reset <= '0';

			-----------------------------------------------------------------------
			-- INCREMENT 1
			-----------------------------------------------------------------------

			run_test("INCREMENT TO 1");

			enable <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT UNSIGNED(pc_value) = 1
			REPORT "Increment to 1 failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- INCREMENT 2
			-----------------------------------------------------------------------

			run_test("INCREMENT TO 2");

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT UNSIGNED(pc_value) = 2
			REPORT "Increment to 2 failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD ADDRESS
			-----------------------------------------------------------------------

			run_test("LOAD ADDRESS");

			load <= '1';
			next_address <= STD_LOGIC_VECTOR(to_unsigned(10, ADDRESS_WIDTH));

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT UNSIGNED(pc_value) = 10
			REPORT "Load failed"
			SEVERITY ERROR;

			load <= '0';

			-----------------------------------------------------------------------
			-- INCREMENT AFTER LOAD
			-----------------------------------------------------------------------

			run_test("INCREMENT AFTER LOAD");

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT UNSIGNED(pc_value) = 11
			REPORT "Increment after load failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- ENABLE LOW
			-----------------------------------------------------------------------

			run_test("ENABLE LOW");

			enable <= '0';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT UNSIGNED(pc_value) = 11
			REPORT "PC changed while enable=0"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- RESET AGAIN
			-----------------------------------------------------------------------

			run_test("RESET AFTER OPERATION");

			reset <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT pc_value = address_t'(OTHERS => '0')
			REPORT "Second reset failed"
			SEVERITY ERROR;

			REPORT "====================================================="
			SEVERITY NOTE;

			REPORT "All PC tests completed successfully."
			SEVERITY NOTE;

			REPORT "====================================================="
			SEVERITY NOTE;

			WAIT;

		END PROCESS stimulus;

	END ARCHITECTURE sim;
