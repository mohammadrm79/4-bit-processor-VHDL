-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : counter.vhdl
-- Description  : Generic synchronous counter component
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY counter IS

	GENERIC
	(
		WIDTH : NATURAL := 4
	);

	PORT
	(
		clk   : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		enable : IN STD_LOGIC;

		count_in  : IN  STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
		count_out : OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
	);

END ENTITY counter;

ARCHITECTURE rtl OF counter IS

	SIGNAL counter_reg : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);

BEGIN

	---------------------------------------------------------------------------
	-- Counter Register Logic
	---------------------------------------------------------------------------

	u_process_1 : PROCESS (clk)

	BEGIN

		IF rising_edge(clk) THEN

			IF reset = '1' THEN

				counter_reg <= (OTHERS => '0');

			ELSIF enable = '1' THEN

				counter_reg <= count_in;

			END IF;

		END IF;

	END PROCESS u_process_1;

	---------------------------------------------------------------------------
	-- Output Assignment
	---------------------------------------------------------------------------

	count_out <= counter_reg;

END ARCHITECTURE rtl;
