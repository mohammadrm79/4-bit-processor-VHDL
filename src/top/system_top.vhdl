-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : system_top.vhdl
-- Description  : System Level Top Module
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--   - DD-010 : Vendor-Independent RTL
--   - DD-013 : Hierarchical RTL Organization
--
-- This module represents the external integration point of the processor.
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;



entity system_top is

    port
    (
        clk   : in std_logic;

        reset : in std_logic;

        halted : out std_logic

    );

end entity system_top;



architecture rtl of system_top is


begin


    ---------------------------------------------------------------------------
    -- CPU Core Instance
    ---------------------------------------------------------------------------

    cpu : entity work.cpu_core

    port map
    (
        clk => clk,

        reset => reset,

        halted => halted

    );



end architecture rtl;