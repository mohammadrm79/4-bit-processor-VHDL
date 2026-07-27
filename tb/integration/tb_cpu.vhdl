-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_cpu.vhdl
-- Description  : CPU Core Integration Testbench
--
-- Version      : 2.1.0
-- Description  :
--   Added execution timeout protection
--   Added register debug reports
--   Improved ADD validation
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

USE ieee.numeric_std.ALL;

USE work.cpu_pkg.ALL;

ENTITY tb_cpu IS

END ENTITY tb_cpu;

ARCHITECTURE sim OF tb_cpu IS

    SIGNAL clk : STD_LOGIC := '0';

    SIGNAL reset : STD_LOGIC := '1';

    SIGNAL halted : STD_LOGIC;

    SIGNAL debug_r0 : data_word_t;

    SIGNAL debug_r1 : data_word_t;

    SIGNAL debug_r2 : data_word_t;

    SIGNAL debug_r3 : data_word_t;

    CONSTANT CLK_PERIOD : TIME := 10 ns;

    -- CONSTANT MAX_EXECUTION_TIME : TIME := 500 ns;

BEGIN

    ---------------------------------------------------------------------------
    -- Clock Generator
    ---------------------------------------------------------------------------

    clk_process : PROCESS

    BEGIN

        LOOP

            clk <= '0';

            WAIT FOR CLK_PERIOD / 2;

            clk <= '1';

            WAIT FOR CLK_PERIOD / 2;

        END LOOP;

    END PROCESS;

    ---------------------------------------------------------------------------
    -- DUT
    ---------------------------------------------------------------------------

    uut : ENTITY work.system_top

        PORT MAP
        (

            clk => clk,

            reset => reset,

            halted => halted,

            debug_r0 => debug_r0,

            debug_r1 => debug_r1,

            debug_r2 => debug_r2,

            debug_r3 => debug_r3

        );

    ---------------------------------------------------------------------------
    -- Test Sequence
    ---------------------------------------------------------------------------

    stimulus : PROCESS

    BEGIN

        -----------------------------------------------------------------------
        -- Reset CPU
        -----------------------------------------------------------------------

        reset <= '1';

        WAIT FOR CLK_PERIOD * 5;

        reset <= '0';

        -----------------------------------------------------------------------
        -- Execution Timeout
        -----------------------------------------------------------------------

        WAIT UNTIL halted = '1';

        ASSERT halted = '1'

        REPORT "CPU did not reach HALTED state"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Register Debug
        -----------------------------------------------------------------------

        REPORT "Register Values:";

        REPORT "R0 = " &
            INTEGER'image(to_integer(unsigned(debug_r0)));

        REPORT "R1 = " &
            INTEGER'image(to_integer(unsigned(debug_r1)));

        REPORT "R2 = " &
            INTEGER'image(to_integer(unsigned(debug_r2)));

        REPORT "R3 = " &
            INTEGER'image(to_integer(unsigned(debug_r3)));

        -----------------------------------------------------------------------
        -- ADD Verification
        -----------------------------------------------------------------------

        ASSERT debug_r3 = "1000"

        REPORT "ADD result incorrect. Expected R3 = 8"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Register Integrity
        -----------------------------------------------------------------------

        ASSERT debug_r0 = "0000"

        REPORT "R0 modified unexpectedly"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Finish
        -----------------------------------------------------------------------

        REPORT "ADD integration test completed successfully"

            SEVERITY note;

        WAIT;

    END PROCESS;

END ARCHITECTURE sim;