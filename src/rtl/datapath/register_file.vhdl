-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : register_file.vhdl
-- Description  : General Purpose Register File
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Register Organization:
--   R0 - R7
--   Width : 4 bits
--   Read  : Combinational
--   Write : Synchronous
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cpu_pkg.all;



entity register_file is

    port
    (
        clk   : in std_logic;
        reset : in std_logic;


        write_enable : in std_logic;

        write_address : in register_index_t;

        write_data : in data_word_t;



        read_address_a : in register_index_t;

        read_address_b : in register_index_t;


        read_data_a : out data_word_t;

        read_data_b : out data_word_t

    );

end entity register_file;



architecture rtl of register_file is


    type register_array_t is array
    (
        0 to REGISTER_COUNT-1
    )
    of data_word_t;



    signal registers : register_array_t :=
    (
        others => (others => '0')
    );



begin


    ---------------------------------------------------------------------------
    -- Register Write Logic
    ---------------------------------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then


                for i in 0 to REGISTER_COUNT-1 loop

                    registers(i) <= (others => '0');

                end loop;



            elsif write_enable = '1' then


                if is_x(write_address) = false then

                    registers(
                        to_integer(unsigned(write_address))
                    )
                    <= write_data;

                end if;


            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Register Read Logic
    ---------------------------------------------------------------------------

    process(read_address_a, read_address_b, registers)

    begin


        -----------------------------------------------------------------------
        -- Default values
        -----------------------------------------------------------------------

        read_data_a <= (others => '0');

        read_data_b <= (others => '0');



        -----------------------------------------------------------------------
        -- Read Port A
        -----------------------------------------------------------------------

        if is_x(read_address_a) = false then


            if to_integer(unsigned(read_address_a)) < REGISTER_COUNT then


                read_data_a <= registers(
                    to_integer(unsigned(read_address_a))
                );


            end if;


        end if;



        -----------------------------------------------------------------------
        -- Read Port B
        -----------------------------------------------------------------------

        if is_x(read_address_b) = false then


            if to_integer(unsigned(read_address_b)) < REGISTER_COUNT then


                read_data_b <= registers(
                    to_integer(unsigned(read_address_b))
                );


            end if;


        end if;



    end process;



end architecture rtl;