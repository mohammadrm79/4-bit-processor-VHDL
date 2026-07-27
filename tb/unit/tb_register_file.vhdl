LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_register_file IS
END ENTITY tb_register_file;

ARCHITECTURE sim OF tb_register_file IS

	CONSTANT clk_period : TIME := 10 ns;

	SIGNAL clk   : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC := '0';

	SIGNAL write_enable : STD_LOGIC := '0';

	SIGNAL write_address : register_index_t := (OTHERS => '0');
	SIGNAL write_data    : data_word_t := (OTHERS => '0');

	SIGNAL read_address_a : register_index_t := (OTHERS => '0');
	SIGNAL read_address_b : register_index_t := (OTHERS => '0');

	SIGNAL read_data_a : data_word_t;
	SIGNAL read_data_b : data_word_t;

	SIGNAL debug_r0 : data_word_t;
	SIGNAL debug_r1 : data_word_t;
	SIGNAL debug_r2 : data_word_t;
	SIGNAL debug_r3 : data_word_t;

BEGIN

	---------------------------------------------------------------------------
	-- DUT
	---------------------------------------------------------------------------

	uut : ENTITY WORK.register_file
	PORT MAP
	(
		clk   => clk,
		reset => reset,

		write_enable  => write_enable,
		write_address => write_address,
		write_data    => write_data,

		read_address_a => read_address_a,
		read_address_b => read_address_b,

		read_data_a => read_data_a,
		read_data_b => read_data_b,

		debug_r0 => debug_r0,
		debug_r1 => debug_r1,
		debug_r2 => debug_r2,
		debug_r3 => debug_r3
	);

	---------------------------------------------------------------------------
	-- Clock
	---------------------------------------------------------------------------

	clk <= NOT clk AFTER clk_period / 2;

	---------------------------------------------------------------------------
	-- Stimulus
	---------------------------------------------------------------------------

	stimulus : PROCESS

	PROCEDURE run_test (
		CONSTANT name : STRING
	) IS
	BEGIN
		REPORT "Running Test: " & name
		SEVERITY NOTE;
	END PROCEDURE;

BEGIN

	-----------------------------------------------------------------------
	-- RESET
	-----------------------------------------------------------------------

	run_test("RESET");

	reset <= '1';

	WAIT FOR clk_period * 2;

	reset <= '0';

	WAIT FOR clk_period;

	ASSERT debug_r0 = "0000" SEVERITY ERROR;
	ASSERT debug_r1 = "0000" SEVERITY ERROR;
	ASSERT debug_r2 = "0000" SEVERITY ERROR;
	ASSERT debug_r3 = "0000" SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- WRITE R1
	-----------------------------------------------------------------------

	run_test("WRITE R1");

	write_enable <= '1';
	write_address <= "001";
	write_data <= "0101";

	WAIT UNTIL rising_edge(clk);

	write_enable <= '0';

	WAIT FOR 1 ns;

	ASSERT debug_r1 = "0101"
	REPORT "Write R1 failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- READ R1
	-----------------------------------------------------------------------

	run_test("READ R1");

	read_address_a <= "001";

	WAIT FOR 1 ns;

	ASSERT read_data_a = "0101"
	REPORT "Read R1 failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- WRITE R2
	-----------------------------------------------------------------------

	run_test("WRITE R2");

	write_enable <= '1';
	write_address <= "010";
	write_data <= "1010";

	WAIT UNTIL rising_edge(clk);

	write_enable <= '0';

	WAIT FOR 1 ns;

	ASSERT debug_r2 = "1010"
	REPORT "Write R2 failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- DUAL READ
	-----------------------------------------------------------------------

	run_test("DUAL READ");

	read_address_a <= "001";
	read_address_b <= "010";

	WAIT FOR 1 ns;

	ASSERT read_data_a = "0101"
	REPORT "Dual Read A failed"
	SEVERITY ERROR;

	ASSERT read_data_b = "1010"
	REPORT "Dual Read B failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- OVERWRITE REGISTER
	-----------------------------------------------------------------------

	run_test("OVERWRITE R1");

	write_enable <= '1';
	write_address <= "001";
	write_data <= "1111";

	WAIT UNTIL rising_edge(clk);

	write_enable <= '0';

	WAIT FOR 1 ns;

	ASSERT debug_r1 = "1111"
	REPORT "Overwrite failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- WRITE DISABLED
	-----------------------------------------------------------------------

	run_test("WRITE DISABLED");

	write_enable <= '0';
	write_address <= "001";
	write_data <= "0000";

	WAIT UNTIL rising_edge(clk);

	WAIT FOR 1 ns;

	ASSERT debug_r1 = "1111"
	REPORT "Write Disable failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- READ R0
	-----------------------------------------------------------------------

	run_test("READ R0");

	read_address_a <= "000";

	WAIT FOR 1 ns;

	ASSERT read_data_a = "0000"
	REPORT "Read R0 failed"
	SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- RESET AFTER WRITES
	-----------------------------------------------------------------------

	run_test("RESET AFTER WRITES");

	reset <= '1';

	WAIT UNTIL rising_edge(clk);

	reset <= '0';

	WAIT FOR 1 ns;

	ASSERT debug_r0 = "0000" SEVERITY ERROR;
	ASSERT debug_r1 = "0000" SEVERITY ERROR;
	ASSERT debug_r2 = "0000" SEVERITY ERROR;
	ASSERT debug_r3 = "0000" SEVERITY ERROR;

	-----------------------------------------------------------------------
	-- DONE
	-----------------------------------------------------------------------

	REPORT "====================================================="
	SEVERITY NOTE;

	REPORT "All Register File tests completed successfully."
	SEVERITY NOTE;

	REPORT "====================================================="
	SEVERITY NOTE;

	WAIT;

END PROCESS stimulus;

END ARCHITECTURE sim;
