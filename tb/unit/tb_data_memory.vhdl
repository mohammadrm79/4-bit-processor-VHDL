-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_data_memory.vhdl
-- Description  : Unit Testbench for Data Memory
--
-- Version      : 1.0.0
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_data_memory IS
END ENTITY tb_data_memory;

ARCHITECTURE sim OF tb_data_memory IS

	CONSTANT CLK_PERIOD : TIME := 10 ns;

	SIGNAL clk   : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC := '0';

	SIGNAL address : address_t := (OTHERS => '0');

	SIGNAL write_enable : STD_LOGIC := '0';

	SIGNAL write_data : data_word_t := (OTHERS => '0');

	SIGNAL read_data : data_word_t;

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
	-- Clock
	---------------------------------------------------------------------------

	clk <= NOT clk AFTER CLK_PERIOD/2;

	---------------------------------------------------------------------------
	-- DUT
	---------------------------------------------------------------------------

	dut : ENTITY WORK.data_memory
	PORT MAP
	(
		clk          => clk,
		reset        => reset,
		address      => address,
		write_enable => write_enable,
		write_data   => write_data,
		read_data    => read_data
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

		reset <= '0';

		address <= (OTHERS => '0');

		WAIT FOR 1 ns;

		ASSERT read_data = "0000"
		REPORT "Reset failed"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- WRITE ADDRESS 0
		-----------------------------------------------------------------------

		run_test("WRITE ADDRESS 0");

		address <= STD_LOGIC_VECTOR(to_unsigned(0, address'length));
		write_data <= "1010";
		write_enable <= '1';

		WAIT UNTIL rising_edge(clk);

		write_enable <= '0';

		WAIT FOR 1 ns;

		ASSERT read_data = "1010"
		REPORT "Write/read address 0 failed"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- WRITE ADDRESS 5
		-----------------------------------------------------------------------

		run_test("WRITE ADDRESS 5");

		address <= STD_LOGIC_VECTOR(to_unsigned(5, address'length));
		write_data <= "0101";
		write_enable <= '1';

		WAIT UNTIL rising_edge(clk);

		write_enable <= '0';

		WAIT FOR 1 ns;

		ASSERT read_data = "0101"
		REPORT "Write/read address 5 failed"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- VERIFY ADDRESS 0
		-----------------------------------------------------------------------

		run_test("VERIFY ADDRESS 0");

		address <= STD_LOGIC_VECTOR(to_unsigned(0, address'length));

		WAIT FOR 1 ns;

		ASSERT read_data = "1010"
		REPORT "Address 0 corrupted"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- WRITE DISABLED
		-----------------------------------------------------------------------

		run_test("WRITE DISABLED");

		address <= STD_LOGIC_VECTOR(to_unsigned(1, address'length));
		write_data <= "1111";
		write_enable <= '0';

		WAIT UNTIL rising_edge(clk);

		WAIT FOR 1 ns;

		ASSERT read_data = "0000"
		REPORT "Memory changed while write disabled"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- LAST ADDRESS
		-----------------------------------------------------------------------

		run_test("LAST ADDRESS");

		address <= STD_LOGIC_VECTOR(
			to_unsigned(255, address'length)
		);

		write_data <= "0011";
		write_enable <= '1';

		WAIT UNTIL rising_edge(clk);

		write_enable <= '0';

		WAIT FOR 1 ns;

		ASSERT read_data = "0011"
		REPORT "Last address failed"
		SEVERITY failure;

		-----------------------------------------------------------------------
		-- FINISH
		-----------------------------------------------------------------------

		REPORT "====================================================="
		SEVERITY note;

		REPORT "All Data Memory tests completed successfully."
		SEVERITY note;

		REPORT "====================================================="
		SEVERITY note;

		WAIT;

	END PROCESS stimulus;

END ARCHITECTURE sim;
