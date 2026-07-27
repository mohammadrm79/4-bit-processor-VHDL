-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : instruction_register.vhdl
--
-- Version      : 1.1.0
-- Description  :
--   Fixed instruction stability during decode/execute
--   Added deterministic initialization
--   Preserved synchronous reset behavior
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

USE work.cpu_pkg.ALL;

ENTITY instruction_register IS

    PORT (
        clk : IN STD_LOGIC;

        reset : IN STD_LOGIC;

        enable : IN STD_LOGIC;

        instruction_in : IN instruction_t;

        instruction_out : OUT instruction_t
    );

END ENTITY instruction_register;

ARCHITECTURE rtl OF instruction_register IS

    SIGNAL instruction_reg : instruction_t :=
                                             (OTHERS => '0');

BEGIN

    PROCESS (clk)

    BEGIN

        IF rising_edge(clk) THEN

            IF reset = '1' THEN

                instruction_reg <=
                                  (OTHERS => '0');

            ELSIF enable = '1' THEN

                instruction_reg <=
                                  instruction_in;

            END IF;

        END IF;

    END PROCESS;

    instruction_out <= instruction_reg;

END ARCHITECTURE rtl;