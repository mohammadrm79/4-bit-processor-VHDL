-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : instruction_register.vhdl
-- Description  : Instruction Register
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-002 : 16-bit Fixed-Length Instructions
--   - DD-005 : Multi-Cycle Execution
--   - DD-008 : Single Clock Domain
--   - DD-009 : Synchronous Active-High Reset
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity instruction_register is

    port
    (
        clk     : in std_logic;
        reset   : in std_logic;

        enable  : in std_logic;

        instruction_in  : in instruction_t;
        instruction_out : out instruction_t

    );

end entity instruction_register;



architecture rtl of instruction_register is


    signal instruction_reg : instruction_t :=
    (others => '0');



begin


    ---------------------------------------------------------------------------
    -- Instruction Register Storage
    ---------------------------------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then


                instruction_reg <= (others => '0');



            elsif enable = '1' then


                instruction_reg <= instruction_in;



            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Output Assignment
    ---------------------------------------------------------------------------

    instruction_out <= instruction_reg;



end architecture rtl;