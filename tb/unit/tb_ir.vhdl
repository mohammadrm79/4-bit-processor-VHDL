-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_ir.vhdl
-- Description  : Instruction Register Unit Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

USE work.cpu_pkg.ALL;

ENTITY tb_ir IS

END ENTITY tb_ir;

ARCHITECTURE behavior OF tb_ir IS

    ---------------------------------------------------------------------------
    -- DUT Signals
    ---------------------------------------------------------------------------

    SIGNAL clk : STD_LOGIC := '0';

    SIGNAL reset : STD_LOGIC := '0';

    SIGNAL enable : STD_LOGIC := '0';

    SIGNAL instruction_in : instruction_t;

    SIGNAL instruction_out : instruction_t;

    CONSTANT CLOCK_PERIOD : TIME := 10 ns;

BEGIN

    ---------------------------------------------------------------------------
    -- Clock Generator
    ---------------------------------------------------------------------------

    clk_process : PROCESS

    BEGIN

        WHILE true LOOP

            clk <= '0';

            WAIT FOR CLOCK_PERIOD / 2;

            clk <= '1';

            WAIT FOR CLOCK_PERIOD / 2;

        END LOOP;

    END PROCESS;

    ---------------------------------------------------------------------------
    -- DUT Instance
    ---------------------------------------------------------------------------

    uut : ENTITY work.instruction_register

        PORT MAP
        (

            clk => clk,

            reset => reset,

            enable => enable,

            instruction_in => instruction_in,

            instruction_out => instruction_out

        );

    ---------------------------------------------------------------------------
    -- Test Sequence
    ---------------------------------------------------------------------------

    stimulus : PROCESS

    BEGIN

        -----------------------------------------------------------------------
        -- Reset Test
        -----------------------------------------------------------------------

        reset <= '1';

        WAIT FOR CLOCK_PERIOD;

        reset <= '0';

        ASSERT instruction_out = (OTHERS => '0')

        REPORT "Instruction register reset failed"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Load Instruction Test
        -----------------------------------------------------------------------

        instruction_in <= x"1234";

        enable <= '1';

        WAIT FOR CLOCK_PERIOD;

        enable <= '0';

        ASSERT instruction_out = x"1234"

        REPORT "Instruction load failed"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Hold Test
        -----------------------------------------------------------------------

        instruction_in <= x"ABCD";

        WAIT FOR CLOCK_PERIOD;

        ASSERT instruction_out = x"1234"

        REPORT "Instruction register hold failed"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Finish Simulation
        -----------------------------------------------------------------------

        REPORT "tb_ir completed successfully"

            SEVERITY note;

        WAIT;

    END PROCESS;

END ARCHITECTURE behavior;