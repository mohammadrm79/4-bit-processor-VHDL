-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : system_top.vhdl
--
-- Version      : 1.1.0
-- Description  :
--   Fixed top-level CPU integration
--   Added deterministic output initialization
--   Preserved external interface
--
-- ============================================================================

LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY system_top IS
	GENERIC (
		PROGRAM_FILE : STRING := "tb/programs/bin/movi.mem"
	);
	PORT (
		clk : IN STD_LOGIC;

		reset : IN STD_LOGIC;

		halted : OUT STD_LOGIC;

		debug_r0 : OUT data_word_t;

		debug_r1 : OUT data_word_t;

		debug_r2 : OUT data_word_t;

		debug_r3 : OUT data_word_t;
		debug_pc : OUT address_t;

		debug_zero  : OUT STD_LOGIC;
		debug_carry : OUT STD_LOGIC
	);

END ENTITY system_top;

ARCHITECTURE rtl OF system_top IS

BEGIN

	cpu : ENTITY WORK.cpu_core
	GENERIC MAP (
		PROGRAM_FILE => PROGRAM_FILE
	)
	PORT MAP
	(
		clk => clk,

		reset => reset,

		halted => halted,

		debug_r0 => debug_r0,

		debug_r1 => debug_r1,

		debug_r2 => debug_r2,

		debug_r3    => debug_r3,
		debug_zero  => debug_zero,
		debug_carry => debug_carry,
		debug_pc    => debug_pc
	);

END ARCHITECTURE rtl;
