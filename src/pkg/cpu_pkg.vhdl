-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : cpu_pkg.vhdl
-- Description  : Common types, constants, opcodes, and helper definitions
--
-- Version      : 1.2.0
-- Description  :
--   Datapath Integration Support
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE cpu_pkg IS

    ---------------------------------------------------------------------------
    -- CPU Architectural Constants
    ---------------------------------------------------------------------------

    CONSTANT DATA_WIDTH : NATURAL := 4;

    CONSTANT INSTRUCTION_WIDTH : NATURAL := 16;

    CONSTANT REGISTER_COUNT : NATURAL := 8;

    CONSTANT REGISTER_ADDRESS_WIDTH : NATURAL := 3;

    CONSTANT OPCODE_WIDTH : NATURAL := 5;

    CONSTANT ADDRESS_WIDTH : NATURAL := 11;

    CONSTANT RESET_VECTOR :
    STD_LOGIC_VECTOR(ADDRESS_WIDTH - 1 DOWNTO 0)
     := (OTHERS => '0');

    ---------------------------------------------------------------------------
    -- Common Types
    ---------------------------------------------------------------------------

    SUBTYPE data_word_t IS
    STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    SUBTYPE instruction_t IS
    STD_LOGIC_VECTOR(INSTRUCTION_WIDTH - 1 DOWNTO 0);

    SUBTYPE opcode_t IS
    STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);

    SUBTYPE register_index_t IS
    STD_LOGIC_VECTOR(REGISTER_ADDRESS_WIDTH - 1 DOWNTO 0);

    SUBTYPE address_t IS
    STD_LOGIC_VECTOR(ADDRESS_WIDTH - 1 DOWNTO 0);

    ---------------------------------------------------------------------------
    -- Instruction Formats
    ---------------------------------------------------------------------------

    TYPE instruction_format_t IS
    (
    R_TYPE,
    I_TYPE,
    J_TYPE,
    S_TYPE
    );

    ---------------------------------------------------------------------------
    -- CPU States
    ---------------------------------------------------------------------------

    TYPE cpu_state_t IS
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

    TYPE alu_operation_t IS
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
    -- Write Back Source
    ---------------------------------------------------------------------------

    TYPE write_back_source_t IS
    (
    WB_ALU,
    WB_MEMORY,
    WB_IMMEDIATE
    );

    ---------------------------------------------------------------------------
    -- Memory Operation
    ---------------------------------------------------------------------------

    TYPE memory_operation_t IS
    (
    MEM_NONE,
    MEM_READ,
    MEM_WRITE
    );

    ---------------------------------------------------------------------------
    -- Flags
    ---------------------------------------------------------------------------

    TYPE flags_t IS RECORD

        zero : STD_LOGIC;

        carry : STD_LOGIC;

        negative : STD_LOGIC;

        overflow : STD_LOGIC;

    END RECORD;

    ---------------------------------------------------------------------------
    -- Opcode Allocation
    ---------------------------------------------------------------------------

    -- Arithmetic

    CONSTANT OP_ADD : opcode_t := "00000";

    CONSTANT OP_SUB : opcode_t := "00001";

    CONSTANT OP_INC : opcode_t := "00010";

    CONSTANT OP_DEC : opcode_t := "00011";

    -- Logic

    CONSTANT OP_AND : opcode_t := "00100";

    CONSTANT OP_OR : opcode_t := "00101";

    CONSTANT OP_XOR : opcode_t := "00110";

    CONSTANT OP_NOT : opcode_t := "00111";

    -- Shift

    CONSTANT OP_SHL : opcode_t := "01000";

    CONSTANT OP_SHR : opcode_t := "01001";

    -- Memory

    CONSTANT OP_LOAD : opcode_t := "01010";

    CONSTANT OP_STORE : opcode_t := "01011";

    -- Immediate

    CONSTANT OP_MOVI : opcode_t := "01100";

    -- Control

    CONSTANT OP_JMP : opcode_t := "01101";

    CONSTANT OP_JZ : opcode_t := "01110";

    CONSTANT OP_JC : opcode_t := "01111";

    -- System

    CONSTANT OP_NOP : opcode_t := "10000";

    CONSTANT OP_HALT : opcode_t := "10001";

    ---------------------------------------------------------------------------
    -- Helper Functions
    ---------------------------------------------------------------------------

    FUNCTION opcode_to_format(
        opcode : opcode_t
    ) RETURN instruction_format_t;

    FUNCTION opcode_to_alu_operation(
        opcode : opcode_t
    ) RETURN alu_operation_t;

    FUNCTION opcode_to_write_back_source(
        opcode : opcode_t
    ) RETURN write_back_source_t;

    FUNCTION is_valid_opcode(
        opcode : opcode_t
    ) RETURN BOOLEAN;

END PACKAGE cpu_pkg;

PACKAGE BODY cpu_pkg IS

    ---------------------------------------------------------------------------
    -- Instruction Format Decoder
    ---------------------------------------------------------------------------

    FUNCTION opcode_to_format(
        opcode : opcode_t
    )
        RETURN instruction_format_t IS

    BEGIN

        CASE opcode IS

            WHEN OP_ADD |
                OP_SUB |
                OP_INC |
                OP_DEC |
                OP_AND |
                OP_OR |
                OP_XOR |
                OP_NOT |
                OP_SHL |
                OP_SHR =>

                RETURN R_TYPE;

            WHEN OP_LOAD |
                OP_STORE |
                OP_MOVI =>

                RETURN I_TYPE;

            WHEN OP_JMP |
                OP_JZ |
                OP_JC =>

                RETURN J_TYPE;

            WHEN OTHERS =>

                RETURN S_TYPE;

        END CASE;

    END FUNCTION;

    ---------------------------------------------------------------------------
    -- ALU Operation Decoder
    ---------------------------------------------------------------------------

    FUNCTION opcode_to_alu_operation(
        opcode : opcode_t
    )
        RETURN alu_operation_t IS

    BEGIN

        CASE opcode IS

            WHEN OP_ADD =>

                RETURN ALU_ADD;

            WHEN OP_SUB =>

                RETURN ALU_SUB;

            WHEN OP_INC =>

                RETURN ALU_INC;

            WHEN OP_DEC =>

                RETURN ALU_DEC;

            WHEN OP_AND =>

                RETURN ALU_AND;

            WHEN OP_OR =>

                RETURN ALU_OR;

            WHEN OP_XOR =>

                RETURN ALU_XOR;

            WHEN OP_NOT =>

                RETURN ALU_NOT;

            WHEN OP_SHL =>

                RETURN ALU_SHL;

            WHEN OP_SHR =>

                RETURN ALU_SHR;

            WHEN OTHERS =>

                RETURN ALU_PASS;

        END CASE;

    END FUNCTION;

    ---------------------------------------------------------------------------
    -- Write Back Decoder
    ---------------------------------------------------------------------------

    FUNCTION opcode_to_write_back_source(
        opcode : opcode_t
    )
        RETURN write_back_source_t IS

    BEGIN

        CASE opcode IS

            WHEN OP_MOVI =>

                RETURN WB_IMMEDIATE;

            WHEN OP_LOAD =>

                RETURN WB_MEMORY;

            WHEN OP_ADD |
                OP_SUB |
                OP_INC |
                OP_DEC |
                OP_AND |
                OP_OR |
                OP_XOR |
                OP_NOT |
                OP_SHL |
                OP_SHR =>

                RETURN WB_ALU;

            WHEN OTHERS =>

                RETURN WB_ALU;

        END CASE;

    END FUNCTION;

    ---------------------------------------------------------------------------
    -- Opcode Validation
    ---------------------------------------------------------------------------

    FUNCTION is_valid_opcode(
        opcode : opcode_t
    )
        RETURN BOOLEAN IS

    BEGIN

        CASE opcode IS

            WHEN OP_ADD |
                OP_SUB |
                OP_INC |
                OP_DEC |
                OP_AND |
                OP_OR |
                OP_XOR |
                OP_NOT |
                OP_SHL |
                OP_SHR |
                OP_LOAD |
                OP_STORE |
                OP_MOVI |
                OP_JMP |
                OP_JZ |
                OP_JC |
                OP_NOP |
                OP_HALT =>

                RETURN true;

            WHEN OTHERS =>

                RETURN false;

        END CASE;

    END FUNCTION;

END PACKAGE BODY cpu_pkg;