-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : mux.vhdl
-- Description  : Generic Multiplexer Component
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-013 : Hierarchical RTL Organization
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;



entity mux is

    generic
    (
        WIDTH : natural := 4
    );

    port
    (
        input_a : in std_logic_vector(WIDTH-1 downto 0);

        input_b : in std_logic_vector(WIDTH-1 downto 0);

        select_i : in std_logic;

        output_o : out std_logic_vector(WIDTH-1 downto 0)
    );

end entity mux;



architecture rtl of mux is

begin


    ---------------------------------------------------------------------------
    -- Combinational Multiplexer Logic
    ---------------------------------------------------------------------------

    process(input_a, input_b, select_i)

    begin


        case select_i is


            when '0' =>

                output_o <= input_a;


            when '1' =>

                output_o <= input_b;


            when others =>

                output_o <= (others => '0');


        end case;


    end process;



end architecture rtl;