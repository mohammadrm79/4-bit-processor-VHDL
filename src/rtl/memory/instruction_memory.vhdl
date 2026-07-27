-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : instruction_memory.vhdl
-- Description  : Instruction Memory
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;

USE std.textio.ALL;

USE work.cpu_pkg.ALL;

ENTITY instruction_memory IS

    GENERIC (
        DEPTH : NATURAL := 256;

        PROGRAM_FILE : STRING := "tb/programs/program_add.mem"
    );

    PORT (
        address : IN address_t;

        instruction : OUT instruction_t
    );

END ENTITY instruction_memory;

ARCHITECTURE rtl OF instruction_memory IS

    ---------------------------------------------------------------------------
    -- Memory Type
    ---------------------------------------------------------------------------

    TYPE memory_array_t IS ARRAY
    (
    0 TO DEPTH - 1
    )
    OF instruction_t;

    ---------------------------------------------------------------------------
    -- Initialize Memory From File
    ---------------------------------------------------------------------------

    IMPURE FUNCTION init_memory RETURN memory_array_t IS

        FILE input_file : text OPEN read_mode IS PROGRAM_FILE;

        VARIABLE line_buffer : line;

        VARIABLE temp_memory : memory_array_t :=
                                                (OTHERS => (OTHERS => '0'));

        VARIABLE index : INTEGER := 0;

        VARIABLE temp_word : STD_LOGIC_VECTOR(15 DOWNTO 0);

    BEGIN

        WHILE NOT endfile(input_file) LOOP

            readline(input_file, line_buffer);

            hread(
            line_buffer,
            temp_word
            );

            REPORT "IMEM LOAD [" &
                INTEGER'image(index) &
                "] = " &
                INTEGER'image(to_integer(unsigned(temp_word)))
                SEVERITY NOTE;
            IF index < DEPTH THEN

                temp_memory(index) := temp_word;

            END IF;

            index := index + 1;

        END LOOP;

        RETURN temp_memory;

    END FUNCTION;

    ---------------------------------------------------------------------------
    -- Memory Storage
    ---------------------------------------------------------------------------

    SIGNAL memory : memory_array_t := init_memory;

BEGIN

    ---------------------------------------------------------------------------
    -- Instruction Memory Read
    ---------------------------------------------------------------------------

    PROCESS (address)

        VARIABLE addr_int : INTEGER;

    BEGIN

        -----------------------------------------------------------------------
        -- Protect Against Unknown Address At Startup
        -----------------------------------------------------------------------

        IF is_x(address) THEN

            instruction <= (OTHERS => '0');

        ELSE

            addr_int := to_integer(unsigned(address));

            IF addr_int < DEPTH THEN

                instruction <= memory(addr_int);

            ELSE

                instruction <= (OTHERS => '0');

            END IF;

        END IF;

    END PROCESS;

END ARCHITECTURE rtl;