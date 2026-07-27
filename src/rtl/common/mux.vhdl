-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : mux.vhdl
-- Description  : Generic Multiplexer Component
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-013 : Hierarchical RTL Organization
--
-- ============================================================================

LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY mux IS

	GENERIC
	(
		WIDTH : NATURAL := 4
	);

	PORT
	(
		input_a : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);

		input_b : IN STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);

		select_i : IN STD_LOGIC;

		output_o : OUT STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0)
	);

END ENTITY mux;

ARCHITECTURE rtl OF mux IS

BEGIN

	---------------------------------------------------------------------------
	-- Combinational Multiplexer Logic
	---------------------------------------------------------------------------

	u_process_1 : PROCESS (input_a, input_b, select_i)
	BEGIN

		output_o <= (OTHERS => '0');
		CASE select_i IS

			WHEN '0' =>

				output_o <= input_a;

			WHEN '1' =>

				output_o <= input_b;

			WHEN OTHERS =>

				output_o <= (OTHERS => '0');

		END CASE;

	END PROCESS u_process_1;

END ARCHITECTURE rtl;
