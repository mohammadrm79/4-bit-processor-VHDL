-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : data_memory.vhdl
-- Description  : Data Memory
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-003 : Load/Store Architecture
--   - DD-006 : Harvard Memory Architecture
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--
-- Memory Organization:
--   Width : 4 bits
--   Access:
--       Read  : Combinational
--       Write : Synchronous
--
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY data_memory IS

	GENERIC
	(
		DEPTH : NATURAL := 256
	);

	PORT
	(
		clk   : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		address : IN address_t;

		write_enable : IN STD_LOGIC;

		write_data : IN data_word_t;

		read_data : OUT data_word_t

	);

END ENTITY data_memory;

ARCHITECTURE rtl OF data_memory IS

	TYPE memory_array_t IS ARRAY
	(
		0 TO DEPTH-1
	)
	OF data_word_t;

	SIGNAL memory : memory_array_t :=
	(
		OTHERS => (OTHERS => '0')
	);

BEGIN

	---------------------------------------------------------------------------
	-- Memory Write Logic
	---------------------------------------------------------------------------

	u_process_1 : PROCESS (clk)

	BEGIN

		IF rising_edge(clk) THEN

			IF reset = '1' THEN

				FOR i IN 0 TO DEPTH-1 LOOP

					memory(i) <= (OTHERS => '0');

				END LOOP;

				ELSIF write_enable = '1' THEN

					IF is_x(address) = false THEN

						IF to_integer(UNSIGNED(address)) < DEPTH THEN

							memory(
								to_integer(UNSIGNED(address))
							) <= write_data;

						END IF;

					END IF;
				END IF;

			END IF;

		END PROCESS u_process_1;

		---------------------------------------------------------------------------
		-- Memory Read Logic
		---------------------------------------------------------------------------

		u_process_2 : PROCESS (address, memory)

		BEGIN

			read_data <= (OTHERS => '0');

			IF is_x(address) = false THEN

				IF to_integer(UNSIGNED(address)) < DEPTH THEN

					read_data <= memory(
						to_integer(UNSIGNED(address))
					);

				END IF;

			END IF;
		END PROCESS u_process_2;

	END ARCHITECTURE rtl;
