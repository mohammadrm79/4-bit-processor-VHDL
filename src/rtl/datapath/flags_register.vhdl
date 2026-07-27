-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : flags_register.vhdl
-- Description  : Processor Status Flags Register
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-005 : Multi-Cycle Execution
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--
-- Flags:
--   Z : Zero
--   C : Carry
--   N : Negative
--   V : Overflow
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity flags_register is

    port
    (
        clk     : in std_logic;
        reset   : in std_logic;

        enable  : in std_logic;

        zero_in     : in std_logic;
        carry_in    : in std_logic;
        negative_in : in std_logic;
        overflow_in : in std_logic;


        zero_out     : out std_logic;
        carry_out    : out std_logic;
        negative_out : out std_logic;
        overflow_out : out std_logic

    );

end entity flags_register;



architecture rtl of flags_register is


    signal flags_reg : flags_t :=
    (
        zero     => '0',
        carry    => '0',
        negative => '0',
        overflow => '0'
    );



begin


    ---------------------------------------------------------------------------
    -- Status Register Logic
    ---------------------------------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then


                flags_reg.zero     <= '0';
                flags_reg.carry    <= '0';
                flags_reg.negative <= '0';
                flags_reg.overflow <= '0';



            elsif enable = '1' then


                flags_reg.zero     <= zero_in;
                flags_reg.carry    <= carry_in;
                flags_reg.negative <= negative_in;
                flags_reg.overflow <= overflow_in;



            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Output Assignment
    ---------------------------------------------------------------------------

    zero_out     <= flags_reg.zero;

    carry_out    <= flags_reg.carry;

    negative_out <= flags_reg.negative;

    overflow_out <= flags_reg.overflow;



end architecture rtl;