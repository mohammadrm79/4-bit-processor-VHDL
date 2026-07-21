-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : register.vhdl
-- Description  : Generic synchronous register component
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


entity register_n is

    generic
    (
        WIDTH : natural := 4
    );

    port
    (
        clk     : in  std_logic;
        reset   : in  std_logic;

        enable  : in  std_logic;

        data_in  : in  std_logic_vector(WIDTH-1 downto 0);
        data_out : out std_logic_vector(WIDTH-1 downto 0)
    );

end entity register_n;



architecture rtl of register_n is

    signal reg_data : std_logic_vector(WIDTH-1 downto 0);

begin


    ---------------------------------------------------------------------------
    -- Synchronous Register Logic
    ---------------------------------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then

                reg_data <= (others => '0');


            elsif enable = '1' then

                reg_data <= data_in;


            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Output Assignment
    ---------------------------------------------------------------------------

    data_out <= reg_data;



end architecture rtl;