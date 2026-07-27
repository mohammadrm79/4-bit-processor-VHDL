-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : data_memory.vhdl
-- Description  : Data Memory
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-003 : Load/Store Architecture
--   - DD-006 : Harvard Memory Architecture
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--
-- Memory Organization:
--   Width : 4 bits
--   Access:
--       Read  : Combinational
--       Write : Synchronous
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cpu_pkg.all;



entity data_memory is

    generic
    (
        DEPTH : natural := 256
    );

    port
    (
        clk   : in std_logic;
        reset : in std_logic;


        address : in address_t;


        write_enable : in std_logic;

        write_data : in data_word_t;


        read_data : out data_word_t

    );

end entity data_memory;



architecture rtl of data_memory is


    type memory_array_t is array
    (
        0 to DEPTH-1
    )
    of data_word_t;



    signal memory : memory_array_t :=
    (
        others => (others => '0')
    );



begin


    ---------------------------------------------------------------------------
    -- Memory Write Logic
    ---------------------------------------------------------------------------

    process(clk)

    begin


        if rising_edge(clk) then


            if reset = '1' then


                for i in 0 to DEPTH-1 loop

                    memory(i) <= (others => '0');

                end loop;



            elsif write_enable = '1' then


                if to_integer(unsigned(address)) < DEPTH then


                    memory(
                        to_integer(unsigned(address))
                    )
                    <= write_data;


                end if;



            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Memory Read Logic
    ---------------------------------------------------------------------------

    process(address)

    begin


        if to_integer(unsigned(address)) < DEPTH then


            read_data <= memory(
                to_integer(unsigned(address))
            );


        else


            read_data <= (others => '0');


        end if;


    end process;



end architecture rtl;