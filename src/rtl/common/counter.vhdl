-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : counter.vhdl
-- Description  : Generic synchronous counter component
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--
-- ============================================================================

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity counter is

    generic
    (
        WIDTH : natural := 4
    );

    port
    (
        clk     : in std_logic;
        reset   : in std_logic;

        enable  : in std_logic;

        count_in  : in std_logic_vector(WIDTH-1 downto 0);
        count_out : out std_logic_vector(WIDTH-1 downto 0)
    );

end entity counter;



architecture rtl of counter is

    signal counter_reg : std_logic_vector(WIDTH-1 downto 0);

begin


    ---------------------------------------------------------------------------
    -- Counter Register Logic
    ---------------------------------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then

                counter_reg <= (others => '0');


            elsif enable = '1' then

                counter_reg <= count_in;


            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Output Assignment
    ---------------------------------------------------------------------------

    count_out <= counter_reg;



end architecture rtl;