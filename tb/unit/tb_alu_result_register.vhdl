LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_alu_result_register IS
END ENTITY tb_alu_result_register;

ARCHITECTURE sim OF tb_alu_result_register IS

	SIGNAL clk    : STD_LOGIC := '0';
	SIGNAL reset  : STD_LOGIC := '0';
	SIGNAL enable : STD_LOGIC := '0';

	SIGNAL data_in  : data_word_t := (OTHERS => '0');
	SIGNAL data_out : data_word_t;

	CONSTANT CLK_PERIOD : TIME := 10 ns;

	PROCEDURE run_test(
		CONSTANT name : STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name
		SEVERITY NOTE;
	END PROCEDURE;

BEGIN

	uut : ENTITY WORK.alu_result_register
	PORT MAP
	(
		clk      => clk,
		reset    => reset,
		enable   => enable,
		data_in  => data_in,
		data_out => data_out
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

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT data_out = data_word_t'("0000")
			REPORT "RESET failed"
			SEVERITY ERROR;

			reset <= '0';

			-----------------------------------------------------------------------
			-- LOAD DATA
			-----------------------------------------------------------------------

			run_test("LOAD DATA");

			enable <= '1';
			data_in <= "1010";

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT data_out = "1010"
			REPORT "LOAD DATA failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- OVERWRITE DATA
			-----------------------------------------------------------------------

			run_test("OVERWRITE DATA");

			data_in <= "0101";

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT data_out = "0101"
			REPORT "OVERWRITE DATA failed"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- ENABLE LOW
			-----------------------------------------------------------------------

			run_test("ENABLE LOW");

			enable <= '0';
			data_in <= "1111";

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT data_out = "0101"
			REPORT "Register changed while enable=0"
			SEVERITY ERROR;

			-----------------------------------------------------------------------
			-- RESET AFTER WRITE
			-----------------------------------------------------------------------

			run_test("RESET AFTER WRITE");

			reset <= '1';

			WAIT UNTIL rising_edge(clk);
			WAIT FOR 1 ns;

			ASSERT data_out = data_word_t'("0000")
			REPORT "RESET AFTER WRITE failed"
			SEVERITY ERROR;

			REPORT "====================================================="
			SEVERITY NOTE;

			REPORT "All ALU Result Register tests completed successfully."
			SEVERITY NOTE;

			REPORT "====================================================="
			SEVERITY NOTE;

			WAIT;

		END PROCESS stimulus;

	END ARCHITECTURE sim;
