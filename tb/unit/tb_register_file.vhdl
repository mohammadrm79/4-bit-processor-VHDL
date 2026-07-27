-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : tb_register_file.vhdl
-- Description  : Register File Testbench
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cpu_pkg.all;



entity tb_register_file is
end entity tb_register_file;



architecture sim of tb_register_file is


    signal clk : std_logic := '0';

    signal reset : std_logic := '0';



    signal write_enable : std_logic;


    signal write_address : register_index_t;

    signal write_data : data_word_t;



    signal read_address_a : register_index_t;

    signal read_address_b : register_index_t;



    signal read_data_a : data_word_t;

    signal read_data_b : data_word_t;



    constant CLK_PERIOD : time := 10 ns;



begin


    ---------------------------------------------------------------------------
    -- Clock Generator
    ---------------------------------------------------------------------------

    clk <= not clk after CLK_PERIOD / 2;



    ---------------------------------------------------------------------------
    -- DUT
    ---------------------------------------------------------------------------

    uut : entity work.register_file


        port map

        (

            clk => clk,

            reset => reset,


            write_enable => write_enable,


            write_address => write_address,

            write_data => write_data,


            read_address_a => read_address_a,

            read_address_b => read_address_b,


            read_data_a => read_data_a,

            read_data_b => read_data_b

        );



    ---------------------------------------------------------------------------
    -- Test Sequence
    ---------------------------------------------------------------------------

    stimulus : process

    begin



        -----------------------------------------------------------------------
        -- Reset Register File
        -----------------------------------------------------------------------

        reset <= '1';

        write_enable <= '0';

        wait for CLK_PERIOD;


        reset <= '0';



        -----------------------------------------------------------------------
        -- Write R1 = 5
        -----------------------------------------------------------------------

        write_address <= "001";

        write_data <= "0101";

        write_enable <= '1';


        wait for CLK_PERIOD;


        write_enable <= '0';



        -----------------------------------------------------------------------
        -- Read R1
        -----------------------------------------------------------------------

        read_address_a <= "001";


        wait for 5 ns;



        assert read_data_a = "0101"

        report "Register R1 write/read failed"

        severity error;



        -----------------------------------------------------------------------
        -- Write R7 = F
        -----------------------------------------------------------------------

        write_address <= "111";

        write_data <= "1111";

        write_enable <= '1';


        wait for CLK_PERIOD;


        write_enable <= '0';



        -----------------------------------------------------------------------
        -- Read R7
        -----------------------------------------------------------------------

        read_address_b <= "111";


        wait for 5 ns;



        assert read_data_b = "1111"

        report "Register R7 write/read failed"

        severity error;



        -----------------------------------------------------------------------
        -- Completion
        -----------------------------------------------------------------------

        report "Register file test completed successfully"

        severity note;



        wait;



    end process;



end architecture sim;