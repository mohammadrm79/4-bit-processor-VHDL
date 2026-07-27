-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : instruction_decoder.vhdl
-- Description  : Instruction Decoder
--
-- Version      : 3.0.0
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

USE work.cpu_pkg.ALL;

ENTITY instruction_decoder IS

    PORT (
        instruction : IN instruction_t;

        opcode : OUT opcode_t;

        format : OUT instruction_format_t;

        register_a : OUT register_index_t; -- Destination

        source_a : OUT register_index_t; -- Source 1

        source_b : OUT register_index_t; -- Source 2

        immediate : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

        address : OUT address_t

    );

END ENTITY instruction_decoder;

ARCHITECTURE rtl OF instruction_decoder IS

BEGIN

    ---------------------------------------------------------------------------
    -- Opcode
    ---------------------------------------------------------------------------

    opcode <= instruction(15 DOWNTO 11);

    ---------------------------------------------------------------------------
    -- Instruction Format
    ---------------------------------------------------------------------------

    format <= opcode_to_format(instruction(15 DOWNTO 11));

    ---------------------------------------------------------------------------
    -- Register Decode
    --
    -- R-Type:
    -- [15:11] Opcode
    -- [10:8]  Destination Register
    -- [7:5]   Source Register A
    -- [4:2]   Source Register B
    ---------------------------------------------------------------------------

    register_a <= instruction(10 DOWNTO 8);

    source_a <= instruction(7 DOWNTO 5);

    source_b <= instruction(4 DOWNTO 2);

    ---------------------------------------------------------------------------
    -- Immediate Decode
    ---------------------------------------------------------------------------

    immediate <= instruction(7 DOWNTO 0);

    ---------------------------------------------------------------------------
    -- Jump Address Decode
    ---------------------------------------------------------------------------

    address <= instruction(10 DOWNTO 0);

END ARCHITECTURE rtl;