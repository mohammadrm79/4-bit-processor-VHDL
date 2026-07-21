-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : cpu_pkg.vhdl
-- Description  : Common types, constants, opcodes, and helper definitions
--                shared across the processor RTL.
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- This package defines the architectural baseline specified by:
--   - DD-001  : 4-bit Datapath
--   - DD-002  : 16-bit Fixed-Length Instructions
--   - DD-004  : Eight General-Purpose Registers
--   - DD-011  : Multiple Instruction Formats
--   - DD-012  : Initial Opcode Allocation
--   - DD-013  : Hierarchical RTL Organization
--
-- ============================================================================

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package cpu_pkg is

    ---------------------------------------------------------------------------
    -- CPU Architectural Constants
    ---------------------------------------------------------------------------

    constant DATA_WIDTH              : natural := 4;
    constant INSTRUCTION_WIDTH       : natural := 16;

    constant REGISTER_COUNT          : natural := 8;
    constant REGISTER_ADDRESS_WIDTH  : natural := 3;

    constant OPCODE_WIDTH            : natural := 5;

    constant ADDRESS_WIDTH           : natural := 11;

    constant RESET_VECTOR            : std_logic_vector(ADDRESS_WIDTH-1 downto 0)
                                      := (others => '0');


    ---------------------------------------------------------------------------
    -- Common Subtypes
    ---------------------------------------------------------------------------

    subtype data_word_t is
        std_logic_vector(DATA_WIDTH-1 downto 0);


    subtype instruction_t is
        std_logic_vector(INSTRUCTION_WIDTH-1 downto 0);


    subtype opcode_t is
        std_logic_vector(OPCODE_WIDTH-1 downto 0);


    subtype register_index_t is
        std_logic_vector(REGISTER_ADDRESS_WIDTH-1 downto 0);


    subtype address_t is
        std_logic_vector(ADDRESS_WIDTH-1 downto 0);



    ---------------------------------------------------------------------------
    -- Instruction Formats
    ---------------------------------------------------------------------------

    type instruction_format_t is
    (
        R_TYPE,
        I_TYPE,
        J_TYPE,
        S_TYPE
    );


    ---------------------------------------------------------------------------
    -- CPU Execution States
    ---------------------------------------------------------------------------

    type cpu_state_t is
(
    STATE_RESET,
    FETCH,
    DECODE,
    EXECUTE,
    WRITE_BACK,
    STATE_HALTED
);


    ---------------------------------------------------------------------------
    -- ALU Operations
    ---------------------------------------------------------------------------

    type alu_operation_t is
    (
        ALU_ADD,
        ALU_SUB,
        ALU_INC,
        ALU_DEC,

        ALU_AND,
        ALU_OR,
        ALU_XOR,
        ALU_NOT,

        ALU_SHL,
        ALU_SHR,

        ALU_PASS
    );


    ---------------------------------------------------------------------------
    -- Memory Operation Type
    ---------------------------------------------------------------------------

    type memory_operation_t is
    (
        MEM_NONE,
        MEM_READ,
        MEM_WRITE
    );


    ---------------------------------------------------------------------------
    -- Processor Status Flags
    ---------------------------------------------------------------------------

    type flags_t is record

        zero     : std_logic;
        carry    : std_logic;
        negative : std_logic;
        overflow : std_logic;

    end record;



    ---------------------------------------------------------------------------
    -- Instruction Opcodes
    --
    -- Opcode width: 5 bits
    -- Total ISA instructions: 18
    -- Remaining opcode values are reserved.
    ---------------------------------------------------------------------------


    -- Arithmetic Instructions

    constant OP_ADD  : opcode_t := "00000";
    constant OP_SUB  : opcode_t := "00001";
    constant OP_INC  : opcode_t := "00010";
    constant OP_DEC  : opcode_t := "00011";


    -- Logical Instructions

    constant OP_AND  : opcode_t := "00100";
    constant OP_OR   : opcode_t := "00101";
    constant OP_XOR  : opcode_t := "00110";
    constant OP_NOT  : opcode_t := "00111";


    -- Shift Instructions

    constant OP_SHL  : opcode_t := "01000";
    constant OP_SHR  : opcode_t := "01001";


    -- Memory Instructions

    constant OP_LOAD : opcode_t := "01010";
    constant OP_STORE: opcode_t := "01011";


    -- Immediate Instructions

    constant OP_MOVI : opcode_t := "01100";


    -- Control Instructions

    constant OP_JMP  : opcode_t := "01101";
    constant OP_JZ   : opcode_t := "01110";
    constant OP_JC   : opcode_t := "01111";


    -- System Instructions

    constant OP_NOP  : opcode_t := "10000";
    constant OP_HALT : opcode_t := "10001";


    ---------------------------------------------------------------------------
    -- Reserved Opcode Range
    ---------------------------------------------------------------------------

    -- 10010 - 11111 reserved for future ISA extensions.



    ---------------------------------------------------------------------------
    -- Helper Functions
    ---------------------------------------------------------------------------


    function opcode_to_format
    (
        opcode : opcode_t
    )
    return instruction_format_t;


    function is_valid_opcode
    (
        opcode : opcode_t
    )
    return boolean;


end package cpu_pkg;



package body cpu_pkg is


    ---------------------------------------------------------------------------
    -- Determine Instruction Format From Opcode
    ---------------------------------------------------------------------------

    function opcode_to_format
    (
        opcode : opcode_t
    )
    return instruction_format_t is

    begin

        case opcode is

            when OP_ADD  |
                 OP_SUB  |
                 OP_INC  |
                 OP_DEC  |
                 OP_AND  |
                 OP_OR   |
                 OP_XOR  |
                 OP_NOT  |
                 OP_SHL  |
                 OP_SHR  =>

                return R_TYPE;


            when OP_LOAD |
                 OP_STORE|
                 OP_MOVI =>

                return I_TYPE;


            when OP_JMP  |
                 OP_JZ   |
                 OP_JC   =>

                return J_TYPE;


            when OP_NOP  |
                 OP_HALT =>

                return S_TYPE;


            when others =>

                return S_TYPE;

        end case;

    end function;



    ---------------------------------------------------------------------------
    -- Validate Opcode
    ---------------------------------------------------------------------------

    function is_valid_opcode
    (
        opcode : opcode_t
    )
    return boolean is

    begin

        case opcode is

            when OP_ADD  |
                 OP_SUB  |
                 OP_INC  |
                 OP_DEC  |
                 OP_AND  |
                 OP_OR   |
                 OP_XOR  |
                 OP_NOT  |
                 OP_SHL  |
                 OP_SHR  |
                 OP_LOAD |
                 OP_STORE|
                 OP_MOVI |
                 OP_JMP  |
                 OP_JZ   |
                 OP_JC   |
                 OP_NOP  |
                 OP_HALT =>

                return true;


            when others =>

                return false;

        end case;

    end function;


end package body cpu_pkg;