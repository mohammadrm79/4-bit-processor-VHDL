-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_control.vhdl
-- Description  : Control FSM Unit Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

USE work.cpu_pkg.ALL;

ENTITY tb_control IS

END ENTITY tb_control;

ARCHITECTURE sim OF tb_control IS

    SIGNAL clk : STD_LOGIC := '0';

    SIGNAL reset : STD_LOGIC := '0';

    SIGNAL opcode : opcode_t := OP_NOP;

    SIGNAL zero_flag : STD_LOGIC := '0';

    SIGNAL carry_flag : STD_LOGIC := '0';

    SIGNAL state_out : cpu_state_t;

    SIGNAL pc_enable : STD_LOGIC;

    SIGNAL pc_load : STD_LOGIC;

    SIGNAL ir_enable : STD_LOGIC;

    SIGNAL register_write_enable : STD_LOGIC;

    SIGNAL flags_write_enable : STD_LOGIC;

    SIGNAL memory_read_enable : STD_LOGIC;

    SIGNAL memory_write_enable : STD_LOGIC;

    SIGNAL halted : STD_LOGIC;

    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN

    ---------------------------------------------------------------------------
    -- Clock
    ---------------------------------------------------------------------------

    clk_process : PROCESS

    BEGIN

        WHILE true LOOP

            clk <= '0';

            WAIT FOR CLK_PERIOD / 2;

            clk <= '1';

            WAIT FOR CLK_PERIOD / 2;

        END LOOP;

    END PROCESS;

    ---------------------------------------------------------------------------
    -- DUT
    ---------------------------------------------------------------------------

    uut : ENTITY work.control_fsm

        PORT MAP
        (

            clk => clk,

            reset => reset,

            opcode => opcode,

            zero_flag => zero_flag,

            carry_flag => carry_flag,

            state_out => state_out,

            pc_enable => pc_enable,

            pc_load => pc_load,

            ir_enable => ir_enable,

            register_write_enable => register_write_enable,

            flags_write_enable => flags_write_enable,

            memory_read_enable => memory_read_enable,

            memory_write_enable => memory_write_enable,

            halted => halted

        );

    ---------------------------------------------------------------------------
    -- Test Sequence
    ---------------------------------------------------------------------------

    stimulus : PROCESS

    BEGIN

        -----------------------------------------------------------------------
        -- Reset
        -----------------------------------------------------------------------

        reset <= '1';

        WAIT FOR CLK_PERIOD * 2;

        reset <= '0';

        -----------------------------------------------------------------------
        -- FETCH
        -----------------------------------------------------------------------

        WAIT UNTIL rising_edge(clk);

        ASSERT state_out = FETCH

        REPORT "FSM did not enter FETCH state"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- Normal Instruction Flow
        -----------------------------------------------------------------------

        opcode <= OP_ADD;

        WAIT UNTIL rising_edge(clk);

        WAIT UNTIL rising_edge(clk);

        WAIT UNTIL rising_edge(clk);

        ASSERT state_out = FETCH

        REPORT "FSM failed to return to FETCH"

            SEVERITY error;

        -----------------------------------------------------------------------
        -- HALT Instruction
        -----------------------------------------------------------------------

        opcode <= OP_HALT;

        WAIT UNTIL rising_edge(clk);

        WAIT UNTIL rising_edge(clk);

        ASSERT halted = '1'

        REPORT "HALT instruction failed"

            SEVERITY error;

        REPORT "Control FSM test completed successfully"

            SEVERITY note;

        WAIT;

    END PROCESS;

END ARCHITECTURE sim;