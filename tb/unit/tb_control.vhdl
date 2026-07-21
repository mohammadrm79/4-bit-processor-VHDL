-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_control.vhdl
-- Description  : Control FSM Unit Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity tb_control is

end entity tb_control;



architecture sim of tb_control is


    signal clk : std_logic := '0';

    signal reset : std_logic := '0';


    signal opcode : opcode_t := OP_NOP;


    signal zero_flag : std_logic := '0';

    signal carry_flag : std_logic := '0';



    signal state_out : cpu_state_t;


    signal pc_enable : std_logic;

    signal pc_load : std_logic;

    signal ir_enable : std_logic;


    signal register_write_enable : std_logic;

    signal flags_write_enable : std_logic;


    signal memory_read_enable : std_logic;

    signal memory_write_enable : std_logic;


    signal halted : std_logic;



    constant CLK_PERIOD : time := 10 ns;



begin


    ---------------------------------------------------------------------------
    -- Clock
    ---------------------------------------------------------------------------

    clk_process : process

    begin

        while true loop

            clk <= '0';

            wait for CLK_PERIOD / 2;


            clk <= '1';

            wait for CLK_PERIOD / 2;


        end loop;

    end process;



    ---------------------------------------------------------------------------
    -- DUT
    ---------------------------------------------------------------------------

    uut : entity work.control_fsm

    port map
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

    stimulus : process

    begin



        -----------------------------------------------------------------------
        -- Reset
        -----------------------------------------------------------------------

        reset <= '1';

        wait for CLK_PERIOD * 2;


        reset <= '0';



        -----------------------------------------------------------------------
        -- FETCH
        -----------------------------------------------------------------------

        wait until rising_edge(clk);


        assert state_out = FETCH

        report "FSM did not enter FETCH state"

        severity error;



        -----------------------------------------------------------------------
        -- Normal Instruction Flow
        -----------------------------------------------------------------------

        opcode <= OP_ADD;


        wait until rising_edge(clk);

        wait until rising_edge(clk);

        wait until rising_edge(clk);



        assert state_out = FETCH

        report "FSM failed to return to FETCH"

        severity error;



        -----------------------------------------------------------------------
        -- HALT Instruction
        -----------------------------------------------------------------------

        opcode <= OP_HALT;


        wait until rising_edge(clk);

        wait until rising_edge(clk);



        assert halted = '1'

        report "HALT instruction failed"

        severity error;



        report "Control FSM test completed successfully"

        severity note;



        wait;


    end process;



end architecture sim;