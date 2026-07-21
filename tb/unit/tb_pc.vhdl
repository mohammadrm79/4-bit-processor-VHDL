-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_pc.vhdl
-- Description  : Program Counter Unit Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity tb_pc is

end entity tb_pc;



architecture sim of tb_pc is


    ---------------------------------------------------------------------------
    -- DUT Signals
    ---------------------------------------------------------------------------

    signal clk : std_logic := '0';

    signal reset : std_logic := '0';


    signal enable : std_logic := '0';

    signal load : std_logic := '0';


    signal next_address : address_t;

    signal pc_value : address_t;



    constant CLK_PERIOD : time := 10 ns;



begin


    ---------------------------------------------------------------------------
    -- Clock Generator
    ---------------------------------------------------------------------------

    clk <= not clk after CLK_PERIOD / 2;



    ---------------------------------------------------------------------------
    -- DUT
    ---------------------------------------------------------------------------

    uut : entity work.pc

        port map
        (

            clk => clk,

            reset => reset,

            enable => enable,

            load => load,

            next_address => next_address,

            pc_value => pc_value

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

        wait for CLK_PERIOD;


        reset <= '0';



        assert pc_value = RESET_VECTOR

        report "PC reset failed"

        severity error;



        -----------------------------------------------------------------------
        -- Increment Test
        -----------------------------------------------------------------------

        enable <= '1';

        load <= '0';


        wait for CLK_PERIOD;



        assert unsigned(pc_value) =
               unsigned(RESET_VECTOR) + 1

        report "PC increment failed"

        severity error;



        -----------------------------------------------------------------------
        -- Second Increment
        -----------------------------------------------------------------------

        wait for CLK_PERIOD;



        assert unsigned(pc_value) =
               unsigned(RESET_VECTOR) + 2

        report "PC second increment failed"

        severity error;



        -----------------------------------------------------------------------
        -- Load Address Test
        -----------------------------------------------------------------------

        load <= '1';

        next_address <= "1010";


        wait for CLK_PERIOD;



        assert pc_value = "1010"

        report "PC load failed"

        severity error;



        -----------------------------------------------------------------------
        -- Finish
        -----------------------------------------------------------------------

        report "PC test completed successfully"

        severity note;



        wait;


    end process;



end architecture sim;