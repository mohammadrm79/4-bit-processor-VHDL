-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : pc.vhdl
-- Description  : Program Counter
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.cpu_pkg.ALL;

ENTITY pc IS

    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        enable : IN STD_LOGIC;

        load : IN STD_LOGIC;

        next_address : IN address_t;

        pc_value : OUT address_t
    );

END ENTITY pc;

ARCHITECTURE rtl OF pc IS

    ---------------------------------------------------------------------------
    -- Internal PC Register
    ---------------------------------------------------------------------------

    SIGNAL pc_reg : address_t := (OTHERS => '0');

BEGIN

    ---------------------------------------------------------------------------
    -- Program Counter Register
    ---------------------------------------------------------------------------

    PROCESS (clk)

    BEGIN

        IF rising_edge(clk) THEN

            -------------------------------------------------------------------
            -- Reset
            -------------------------------------------------------------------

            IF reset = '1' THEN

                pc_reg <= (OTHERS => '0');

                -------------------------------------------------------------------
                -- Normal Operation
                -------------------------------------------------------------------

            ELSIF enable = '1' THEN

                ---------------------------------------------------------------
                -- Jump / Branch Load
                ---------------------------------------------------------------

                IF load = '1' THEN

                    pc_reg <= next_address;

                    ---------------------------------------------------------------
                    -- Sequential Increment
                    ---------------------------------------------------------------

                ELSE

                    pc_reg <= STD_LOGIC_VECTOR(
                              unsigned(pc_reg) + 1
                              );

                END IF;

            END IF;

        END IF;

    END PROCESS;

    ---------------------------------------------------------------------------
    -- Output Assignment
    ---------------------------------------------------------------------------

    pc_value <= pc_reg;

END ARCHITECTURE rtl;