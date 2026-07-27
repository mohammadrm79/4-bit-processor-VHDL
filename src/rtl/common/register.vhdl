-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : register.vhdl
-- Description  : Generic synchronous register component
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

USE IEEE.std_logic_1164.ALL;

ENTITY register_n IS

	GENERIC
	(
		WIDTH : NATURAL := 4
	);

	PORT
	(
		clk   : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		enable : IN  STD_LOGIC;

		data_in  : IN  STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
	);

END ENTITY register_n;

ARCHITECTURE rtl OF register_n IS

	SIGNAL reg_data : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);

BEGIN

	---------------------------------------------------------------------------
	-- Synchronous Register Logic
	---------------------------------------------------------------------------

	u_process_1 : PROCESS (clk)

	BEGIN

		IF rising_edge(clk) THEN

			IF reset = '1' THEN

				reg_data <= (OTHERS => '0');

			ELSIF enable = '1' THEN

				reg_data <= data_in;

			END IF;

		END IF;

	END PROCESS u_process_1;

	---------------------------------------------------------------------------
	-- Output Assignment
	---------------------------------------------------------------------------

	data_out <= reg_data;

END ARCHITECTURE rtl;
