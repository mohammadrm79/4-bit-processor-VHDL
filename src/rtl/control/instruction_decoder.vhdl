-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : instruction_decoder.vhdl
-- Description  : Instruction Decoder
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-002 : 16-bit Fixed-Length Instructions
--   - DD-011 : Multiple Instruction Formats
--   - DD-012 : Initial Opcode Allocation
--   - DD-013 : Hierarchical RTL Organization
--
-- Responsibilities:
--   - Extract opcode field
--   - Identify instruction format
--   - Decode register operands
--   - Decode immediate/address fields
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity instruction_decoder is

    port
    (
        instruction : in instruction_t;


        opcode : out opcode_t;


        format : out instruction_format_t;


        register_a : out register_index_t;

        register_b : out register_index_t;


        immediate : out std_logic_vector(7 downto 0);


        address : out address_t

    );

end entity instruction_decoder;



architecture rtl of instruction_decoder is


    signal opcode_signal : opcode_t;



begin


    ---------------------------------------------------------------------------
    -- Instruction Field Extraction
    ---------------------------------------------------------------------------

    opcode_signal <= instruction(15 downto 11);



    opcode <= opcode_signal;



    format <= opcode_to_format(opcode_signal);



    ---------------------------------------------------------------------------
    -- Register Extraction
    --
    -- R-Type:
    --   [15:11] Opcode
    --   [10:8]  Rd
    --   [7:5]   Rs
    --
    -- I-Type:
    --   [10:8] Register
    --
    ---------------------------------------------------------------------------

    register_a <= instruction(10 downto 8);



    register_b <= instruction(7 downto 5);



    ---------------------------------------------------------------------------
    -- Immediate Extraction
    --
    -- I-Type:
    --   [7:0] Immediate
    --
    ---------------------------------------------------------------------------

    immediate <= instruction(7 downto 0);



    ---------------------------------------------------------------------------
    -- Jump Address Extraction
    --
    -- J-Type:
    --   [10:0] Address
    --
    ---------------------------------------------------------------------------

    address <= "000" & instruction(10 downto 3);



end architecture rtl;