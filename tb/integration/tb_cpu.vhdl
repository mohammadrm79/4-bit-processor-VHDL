-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_cpu.vhdl
-- Description  : Generic CPU Integration Testbench
--
-- Runs one program and prints the final CPU state.
-- Result comparison is performed by an external script.
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY tb_cpu IS

	GENERIC
	(
		PROGRAM_FILE : STRING := "tb/programs/bin/movi.mem"
	);

END ENTITY;

ARCHITECTURE sim OF tb_cpu IS

	CONSTANT CLK_PERIOD : TIME := 10 ns;

	SIGNAL clk   : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC := '1';

	SIGNAL halted : STD_LOGIC;

	SIGNAL debug_zero  : STD_LOGIC;
	SIGNAL debug_carry : STD_LOGIC;
	SIGNAL debug_pc    : address_t;
	SIGNAL debug_r0    : data_word_t;
	SIGNAL debug_r1    : data_word_t;
	SIGNAL debug_r2    : data_word_t;
	SIGNAL debug_r3    : data_word_t;

BEGIN

	---------------------------------------------------------------------------
	-- Clock
	---------------------------------------------------------------------------

	clk_process : PROCESS
	BEGIN

		LOOP

			clk <= '0';
			WAIT FOR CLK_PERIOD / 2;

			clk <= '1';
			WAIT FOR CLK_PERIOD / 2;

		END LOOP;

		END PROCESS clk_process;

		---------------------------------------------------------------------------
		-- DUT
		---------------------------------------------------------------------------

		uut : ENTITY WORK.system_top

		GENERIC MAP
		(
			PROGRAM_FILE => PROGRAM_FILE
		)

		PORT MAP
		(
			clk   => clk,
			reset => reset,

			halted => halted,

			debug_pc => debug_pc,

			debug_zero  => debug_zero,
			debug_carry => debug_carry,

			debug_r0 => debug_r0,
			debug_r1 => debug_r1,
			debug_r2 => debug_r2,
			debug_r3 => debug_r3
		);

		---------------------------------------------------------------------------
		-- Test
		---------------------------------------------------------------------------

		stimulus : PROCESS
		BEGIN

			---------------------------------------------------------------
			-- Reset
			---------------------------------------------------------------

			reset <= '1';

			WAIT FOR CLK_PERIOD * 5;

			reset <= '0';

			---------------------------------------------------------------
			-- Wait until CPU halts
			---------------------------------------------------------------

			WAIT UNTIL halted = '1';

			---------------------------------------------------------------
			-- Dump CPU state
			---------------------------------------------------------------
			REPORT "----------------------------------------";

			REPORT "HALTED=1";

			REPORT "";

			REPORT "PC=" &
			INTEGER'image(to_integer(UNSIGNED(debug_pc)));

			REPORT "";

			REPORT "REG[0]=" &
			to_hstring(debug_r0);

			REPORT "REG[1]=" &
			to_hstring(debug_r1);

			REPORT "REG[2]=" &
			to_hstring(debug_r2);

			REPORT "REG[3]=" &
			to_hstring(debug_r3);

			REPORT "";

			IF debug_zero = '1' THEN
				REPORT "FLAG[ZERO]=1";
			ELSE
				REPORT "FLAG[ZERO]=0";
			END IF;

			IF debug_carry = '1' THEN
				REPORT "FLAG[CARRY]=1";
			ELSE
				REPORT "FLAG[CARRY]=0";
			END IF;

			REPORT "----------------------------------------";

			WAIT;
		END PROCESS stimulus;

	END ARCHITECTURE;
