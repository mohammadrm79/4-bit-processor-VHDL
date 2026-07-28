LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_flags_register IS
END ENTITY tb_flags_register;

ARCHITECTURE sim OF tb_flags_register IS

	SIGNAL clk    : STD_LOGIC := '0';
	SIGNAL reset  : STD_LOGIC := '0';
	SIGNAL enable : STD_LOGIC := '0';

	SIGNAL zero_in     : STD_LOGIC := '0';
	SIGNAL carry_in    : STD_LOGIC := '0';
	SIGNAL negative_in : STD_LOGIC := '0';
	SIGNAL overflow_in : STD_LOGIC := '0';

	SIGNAL zero_out     : STD_LOGIC;
	SIGNAL carry_out    : STD_LOGIC;
	SIGNAL negative_out : STD_LOGIC;
	SIGNAL overflow_out : STD_LOGIC;

	CONSTANT clk_period : TIME := 10 ns;

	PROCEDURE run_test(
		CONSTANT name : IN STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name SEVERITY NOTE;
	END PROCEDURE;

BEGIN

	uut : ENTITY WORK.flags_register
	PORT MAP
	(
		clk          => clk,
		reset        => reset,
		enable       => enable,
		zero_in      => zero_in,
		carry_in     => carry_in,
		negative_in  => negative_in,
		overflow_in  => overflow_in,
		zero_out     => zero_out,
		carry_out    => carry_out,
		negative_out => negative_out,
		overflow_out => overflow_out
	);

	clk_process : PROCESS
	BEGIN
		LOOP
			clk <= '0';
			WAIT FOR clk_period/2;
			clk <= '1';
			WAIT FOR clk_period/2;
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

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '0' REPORT "RESET Zero failed" SEVERITY ERROR;
			ASSERT carry_out = '0' REPORT "RESET Carry failed" SEVERITY ERROR;
			ASSERT negative_out = '0' REPORT "RESET Negative failed" SEVERITY ERROR;
			ASSERT overflow_out = '0' REPORT "RESET Overflow failed" SEVERITY ERROR;

			reset <= '0';

			-----------------------------------------------------------------------
			-- LOAD ZERO
			-----------------------------------------------------------------------

			run_test("LOAD ZERO");

			enable <= '1';

			zero_in <= '1';
			carry_in <= '0';
			negative_in <= '0';
			overflow_in <= '0';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '1' REPORT "ZERO failed" SEVERITY ERROR;
			ASSERT carry_out = '0' REPORT "Carry unexpected" SEVERITY ERROR;
			ASSERT negative_out = '0' REPORT "Negative unexpected" SEVERITY ERROR;
			ASSERT overflow_out = '0' REPORT "Overflow unexpected" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD CARRY
			-----------------------------------------------------------------------

			run_test("LOAD CARRY");

			zero_in <= '0';
			carry_in <= '1';
			negative_in <= '0';
			overflow_in <= '0';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '0' REPORT "Zero failed" SEVERITY ERROR;
			ASSERT carry_out = '1' REPORT "Carry failed" SEVERITY ERROR;
			ASSERT negative_out = '0' REPORT "Negative unexpected" SEVERITY ERROR;
			ASSERT overflow_out = '0' REPORT "Overflow unexpected" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD NEGATIVE
			-----------------------------------------------------------------------

			run_test("LOAD NEGATIVE");

			zero_in <= '0';
			carry_in <= '0';
			negative_in <= '1';
			overflow_in <= '0';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '0' REPORT "Zero unexpected" SEVERITY ERROR;
			ASSERT carry_out = '0' REPORT "Carry unexpected" SEVERITY ERROR;
			ASSERT negative_out = '1' REPORT "Negative failed" SEVERITY ERROR;
			ASSERT overflow_out = '0' REPORT "Overflow unexpected" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD OVERFLOW
			-----------------------------------------------------------------------

			run_test("LOAD OVERFLOW");

			zero_in <= '0';
			carry_in <= '0';
			negative_in <= '0';
			overflow_in <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '0' REPORT "Zero unexpected" SEVERITY ERROR;
			ASSERT carry_out = '0' REPORT "Carry unexpected" SEVERITY ERROR;
			ASSERT negative_out = '0' REPORT "Negative unexpected" SEVERITY ERROR;
			ASSERT overflow_out = '1' REPORT "Overflow failed" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- LOAD ALL FLAGS
			-----------------------------------------------------------------------

			run_test("LOAD ALL FLAGS");

			zero_in <= '1';
			carry_in <= '1';
			negative_in <= '1';
			overflow_in <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '1' REPORT "Zero failed" SEVERITY ERROR;
			ASSERT carry_out = '1' REPORT "Carry failed" SEVERITY ERROR;
			ASSERT negative_out = '1' REPORT "Negative failed" SEVERITY ERROR;
			ASSERT overflow_out = '1' REPORT "Overflow failed" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- ENABLE LOW
			-----------------------------------------------------------------------

			run_test("ENABLE LOW");

			enable <= '0';

			zero_in <= '0';
			carry_in <= '0';
			negative_in <= '0';
			overflow_in <= '0';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '1' REPORT "Enable failed" SEVERITY ERROR;
			ASSERT carry_out = '1' REPORT "Enable failed" SEVERITY ERROR;
			ASSERT negative_out = '1' REPORT "Enable failed" SEVERITY ERROR;
			ASSERT overflow_out = '1' REPORT "Enable failed" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- OVERWRITE FLAGS
			-----------------------------------------------------------------------

			run_test("OVERWRITE FLAGS");

			enable <= '1';

			zero_in <= '0';
			carry_in <= '1';
			negative_in <= '0';
			overflow_in <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '0' REPORT "Overwrite Zero failed" SEVERITY ERROR;
			ASSERT carry_out = '1' REPORT "Overwrite Carry failed" SEVERITY ERROR;
			ASSERT negative_out = '0' REPORT "Overwrite Negative failed" SEVERITY ERROR;
			ASSERT overflow_out = '1' REPORT "Overwrite Overflow failed" SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- RESET AFTER WRITE
			-----------------------------------------------------------------------

			run_test("RESET AFTER WRITE");

			reset <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT zero_out = '0' REPORT "Reset Zero failed" SEVERITY ERROR;
			ASSERT carry_out = '0' REPORT "Reset Carry failed" SEVERITY ERROR;
			ASSERT negative_out = '0' REPORT "Reset Negative failed" SEVERITY ERROR;
			ASSERT overflow_out = '0' REPORT "Reset Overflow failed" SEVERITY ERROR;

			REPORT "=====================================================" SEVERITY NOTE;
			REPORT "All Flags Register tests completed successfully." SEVERITY NOTE;
			REPORT "=====================================================" SEVERITY NOTE;

			WAIT;

		END PROCESS stimulus;

	END ARCHITECTURE sim;
