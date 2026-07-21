-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : instruction_memory.vhdl
-- Description  : Instruction Memory
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

use std.textio.all;

use work.cpu_pkg.all;



entity instruction_memory is

    generic
    (
        DEPTH : natural := 256;

        PROGRAM_FILE : string := "tb/programs/program_add.mem"
    );

    port
    (
        address : in address_t;

        instruction : out instruction_t
    );

end entity instruction_memory;



architecture rtl of instruction_memory is


    ---------------------------------------------------------------------------
    -- Memory Type
    ---------------------------------------------------------------------------

    type memory_array_t is array
    (
        0 to DEPTH-1
    )
    of instruction_t;



    ---------------------------------------------------------------------------
    -- Initialize Memory From File
    ---------------------------------------------------------------------------

    impure function init_memory return memory_array_t is


        file input_file : text open read_mode is PROGRAM_FILE;


        variable line_buffer : line;


        variable temp_memory : memory_array_t :=
            (others => (others => '0'));


        variable index : integer := 0;


        variable temp_word : std_logic_vector(15 downto 0);



    begin


        while not endfile(input_file) loop


            readline(input_file, line_buffer);


            hread(
                line_buffer,
                temp_word
            );


            if index < DEPTH then

                temp_memory(index) := temp_word;

            end if;


            index := index + 1;


        end loop;



        return temp_memory;



    end function;



    ---------------------------------------------------------------------------
    -- Memory Storage
    ---------------------------------------------------------------------------

    signal memory : memory_array_t := init_memory;



begin



    ---------------------------------------------------------------------------
    -- Instruction Memory Read
    ---------------------------------------------------------------------------

    process(address)

        variable addr_int : integer;


    begin


        -----------------------------------------------------------------------
        -- Protect Against Unknown Address At Startup
        -----------------------------------------------------------------------

        if is_x(address) then


            instruction <= (others => '0');



        else


            addr_int := to_integer(unsigned(address));



            if addr_int < DEPTH then


                instruction <= memory(addr_int);



            else


                instruction <= (others => '0');



            end if;


        end if;



    end process;



end architecture rtl;