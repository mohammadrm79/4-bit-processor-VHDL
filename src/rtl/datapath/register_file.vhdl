-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : register_file.vhdl
-- Description  : General Purpose Register File
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Register Organization:
--   R0 - R7
--   Width : 4 bits
--   Read  : Combinational
--   Write : Synchronous
--
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY register_file IS

	PORT (
		clk   : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		write_enable : IN STD_LOGIC;

		write_address : IN register_index_t;

		write_data : IN data_word_t;

		read_address_a : IN register_index_t;

		read_address_b : IN register_index_t;

		read_data_a : OUT data_word_t;

		read_data_b : OUT data_word_t;

		-----------------------------------------------------------------------
		-- Debug Outputs
		-----------------------------------------------------------------------

		debug_r0 : OUT data_word_t;

		debug_r1 : OUT data_word_t;

		debug_r2 : OUT data_word_t;

		debug_r3 : OUT data_word_t

	);

END ENTITY register_file;

ARCHITECTURE rtl OF register_file IS

	TYPE register_array_t IS ARRAY
	(
		0 TO REGISTER_COUNT - 1
	)
	OF data_word_t;

	SIGNAL registers : register_array_t :=
	(
		OTHERS => (OTHERS => '0')
	);

BEGIN

	---------------------------------------------------------------------------
	-- Register Write Logic
	---------------------------------------------------------------------------

	u_process_1 : PROCESS (clk)

	BEGIN

		IF rising_edge(clk) THEN

			IF reset = '1' THEN

				FOR i IN 0 TO REGISTER_COUNT - 1 LOOP

					registers(i) <= (OTHERS => '0');

				END LOOP;

				ELSIF write_enable = '1' THEN

					IF is_x(write_address) = false THEN

						registers(
							to_integer(UNSIGNED(write_address))
						)
						<= write_data;
						-- REPORT
						-- "WRITE REG="
						-- & INTEGER'image(to_integer(UNSIGNED(write_address)))
						-- & " DATA="
						-- & INTEGER'image(to_integer(UNSIGNED(write_data)))
						-- SEVERITY NOTE;
					END IF;

				END IF;

			END IF;

		END PROCESS u_process_1;

		---------------------------------------------------------------------------
		-- Register Read Logic
		---------------------------------------------------------------------------

		u_process_2 : PROCESS (read_address_a, read_address_b, registers)

		BEGIN

			-----------------------------------------------------------------------
			-- Default values
			-----------------------------------------------------------------------

			read_data_a <= (OTHERS => '0');

			read_data_b <= (OTHERS => '0');

			-----------------------------------------------------------------------
			-- Read Port A
			-----------------------------------------------------------------------

			IF is_x(read_address_a) = false THEN

				IF to_integer(UNSIGNED(read_address_a)) < REGISTER_COUNT THEN

					read_data_a <= registers(
						to_integer(UNSIGNED(read_address_a))
					);

				END IF;

			END IF;

			-----------------------------------------------------------------------
			-- Read Port B
			-----------------------------------------------------------------------

			IF is_x(read_address_b) = false THEN

				IF to_integer(UNSIGNED(read_address_b)) < REGISTER_COUNT THEN

					read_data_b <= registers(
						to_integer(UNSIGNED(read_address_b))
					);

				END IF;

			END IF;

		END PROCESS u_process_2;

		---------------------------------------------------------------------------
		-- Debug Register Outputs
		---------------------------------------------------------------------------

		debug_r0 <= registers(0);

		debug_r1 <= registers(1);

		debug_r2 <= registers(2);

		debug_r3 <= registers(3);

	END ARCHITECTURE rtl;
