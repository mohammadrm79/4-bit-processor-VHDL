-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_cpu.vhdl
-- Description  : CPU Core Integration Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;



entity tb_cpu is

end entity tb_cpu;



architecture sim of tb_cpu is


    ---------------------------------------------------------------------------
    -- DUT Signals
    ---------------------------------------------------------------------------

    signal clk : std_logic := '0';

    signal reset : std_logic := '0';

    signal halted : std_logic;



    constant CLK_PERIOD : time := 10 ns;



begin


    ---------------------------------------------------------------------------
    -- Clock Generator
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

    uut : entity work.system_top

    port map
    (

        clk => clk,

        reset => reset,

        halted => halted

    );



    ---------------------------------------------------------------------------
    -- Test Sequence
    ---------------------------------------------------------------------------

    stimulus : process

    begin



        -----------------------------------------------------------------------
        -- Reset CPU
        -----------------------------------------------------------------------

        reset <= '1';

        wait for CLK_PERIOD * 2;


        reset <= '0';



        -----------------------------------------------------------------------
        -- Execute Program
        -----------------------------------------------------------------------

        wait for CLK_PERIOD * 20;



        -----------------------------------------------------------------------
        -- Check CPU State
        -----------------------------------------------------------------------

        assert halted = '1'

        report "CPU did not reach HALTED state"

        severity error;



        -----------------------------------------------------------------------
        -- Finish
        -----------------------------------------------------------------------

        report "CPU integration test completed successfully"

        severity note;



        wait;


    end process;



end architecture sim;