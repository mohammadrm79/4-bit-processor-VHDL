-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : pc.vhdl
-- Description  : Program Counter
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cpu_pkg.all;



entity pc is

    port
    (
        clk     : in std_logic;
        reset   : in std_logic;

        enable  : in std_logic;

        load    : in std_logic;

        next_address : in address_t;

        pc_value : out address_t
    );

end entity pc;



architecture rtl of pc is


    ---------------------------------------------------------------------------
    -- Internal PC Register
    ---------------------------------------------------------------------------

    signal pc_reg : address_t := (others => '0');



begin


    ---------------------------------------------------------------------------
    -- Program Counter Register
    ---------------------------------------------------------------------------

    process(clk)

    begin


        if rising_edge(clk) then


            -------------------------------------------------------------------
            -- Reset
            -------------------------------------------------------------------

            if reset = '1' then


                pc_reg <= (others => '0');



            -------------------------------------------------------------------
            -- Normal Operation
            -------------------------------------------------------------------

            elsif enable = '1' then


                ---------------------------------------------------------------
                -- Jump / Branch Load
                ---------------------------------------------------------------

                if load = '1' then


                    pc_reg <= next_address;



                ---------------------------------------------------------------
                -- Sequential Increment
                ---------------------------------------------------------------

                else


                    pc_reg <= std_logic_vector(
                                unsigned(pc_reg) + 1
                             );


                end if;


            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Output Assignment
    ---------------------------------------------------------------------------

    pc_value <= pc_reg;



end architecture rtl;