-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_ir.vhdl
-- Description  : Instruction Register Unit Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity tb_ir is

end entity tb_ir;



architecture behavior of tb_ir is


    ---------------------------------------------------------------------------
    -- DUT Signals
    ---------------------------------------------------------------------------

    signal clk : std_logic := '0';

    signal reset : std_logic := '0';

    signal enable : std_logic := '0';



    signal instruction_in  : instruction_t;

    signal instruction_out : instruction_t;



    constant CLOCK_PERIOD : time := 10 ns;



begin


    ---------------------------------------------------------------------------
    -- Clock Generator
    ---------------------------------------------------------------------------

    clk_process : process

    begin

        while true loop

            clk <= '0';

            wait for CLOCK_PERIOD / 2;


            clk <= '1';

            wait for CLOCK_PERIOD / 2;


        end loop;


    end process;



    ---------------------------------------------------------------------------
    -- DUT Instance
    ---------------------------------------------------------------------------

    uut : entity work.instruction_register

        port map
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

    stimulus : process

    begin


        -----------------------------------------------------------------------
        -- Reset Test
        -----------------------------------------------------------------------

        reset <= '1';

        wait for CLOCK_PERIOD;


        reset <= '0';


        assert instruction_out = (others => '0')

        report "Instruction register reset failed"

        severity error;



        -----------------------------------------------------------------------
        -- Load Instruction Test
        -----------------------------------------------------------------------

        instruction_in <= x"1234";

        enable <= '1';


        wait for CLOCK_PERIOD;


        enable <= '0';



        assert instruction_out = x"1234"

        report "Instruction load failed"

        severity error;



        -----------------------------------------------------------------------
        -- Hold Test
        -----------------------------------------------------------------------

        instruction_in <= x"ABCD";


        wait for CLOCK_PERIOD;



        assert instruction_out = x"1234"

        report "Instruction register hold failed"

        severity error;



        -----------------------------------------------------------------------
        -- Finish Simulation
        -----------------------------------------------------------------------

        report "tb_ir completed successfully"

        severity note;



        wait;


    end process;



end architecture behavior;