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


    constant RESET_VECTOR :
        std_logic_vector(ADDRESS_WIDTH-1 downto 0)
        := (others => '0');



    ---------------------------------------------------------------------------
    -- Common Types
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
    -- CPU States
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
    -- Write Back Source
    ---------------------------------------------------------------------------


    type write_back_source_t is
    (
        WB_ALU,
        WB_MEMORY,
        WB_IMMEDIATE
    );



    ---------------------------------------------------------------------------
    -- Memory Operation
    ---------------------------------------------------------------------------


    type memory_operation_t is
    (
        MEM_NONE,
        MEM_READ,
        MEM_WRITE
    );



    ---------------------------------------------------------------------------
    -- Flags
    ---------------------------------------------------------------------------


    type flags_t is record

        zero     : std_logic;

        carry    : std_logic;

        negative : std_logic;

        overflow : std_logic;

    end record;



    ---------------------------------------------------------------------------
    -- Opcode Allocation
    ---------------------------------------------------------------------------


    -- Arithmetic

    constant OP_ADD  : opcode_t := "00000";

    constant OP_SUB  : opcode_t := "00001";

    constant OP_INC  : opcode_t := "00010";

    constant OP_DEC  : opcode_t := "00011";



    -- Logic

    constant OP_AND  : opcode_t := "00100";

    constant OP_OR   : opcode_t := "00101";

    constant OP_XOR  : opcode_t := "00110";

    constant OP_NOT  : opcode_t := "00111";



    -- Shift

    constant OP_SHL  : opcode_t := "01000";

    constant OP_SHR  : opcode_t := "01001";



    -- Memory

    constant OP_LOAD  : opcode_t := "01010";

    constant OP_STORE : opcode_t := "01011";



    -- Immediate

    constant OP_MOVI : opcode_t := "01100";



    -- Control

    constant OP_JMP : opcode_t := "01101";

    constant OP_JZ  : opcode_t := "01110";

    constant OP_JC  : opcode_t := "01111";



    -- System

    constant OP_NOP  : opcode_t := "10000";

    constant OP_HALT : opcode_t := "10001";




    ---------------------------------------------------------------------------
    -- Helper Functions
    ---------------------------------------------------------------------------


    function opcode_to_format
    (
        opcode : opcode_t
    )
    return instruction_format_t;



    function opcode_to_alu_operation
    (
        opcode : opcode_t
    )
    return alu_operation_t;



    function opcode_to_write_back_source
    (
        opcode : opcode_t
    )
    return write_back_source_t;



    function is_valid_opcode
    (
        opcode : opcode_t
    )
    return boolean;



end package cpu_pkg;






package body cpu_pkg is



    ---------------------------------------------------------------------------
    -- Instruction Format Decoder
    ---------------------------------------------------------------------------


    function opcode_to_format
    (
        opcode : opcode_t
    )
    return instruction_format_t is

    begin


        case opcode is


            when OP_ADD |
                 OP_SUB |
                 OP_INC |
                 OP_DEC |
                 OP_AND |
                 OP_OR  |
                 OP_XOR |
                 OP_NOT |
                 OP_SHL |
                 OP_SHR =>


                return R_TYPE;



            when OP_LOAD |
                 OP_STORE |
                 OP_MOVI =>


                return I_TYPE;



            when OP_JMP |
                 OP_JZ |
                 OP_JC =>


                return J_TYPE;



            when others =>


                return S_TYPE;



        end case;


    end function;




    ---------------------------------------------------------------------------
    -- ALU Operation Decoder
    ---------------------------------------------------------------------------


    function opcode_to_alu_operation
    (
        opcode : opcode_t
    )
    return alu_operation_t is

    begin


        case opcode is


            when OP_ADD =>

                return ALU_ADD;


            when OP_SUB =>

                return ALU_SUB;


            when OP_INC =>

                return ALU_INC;


            when OP_DEC =>

                return ALU_DEC;


            when OP_AND =>

                return ALU_AND;


            when OP_OR =>

                return ALU_OR;


            when OP_XOR =>

                return ALU_XOR;


            when OP_NOT =>

                return ALU_NOT;


            when OP_SHL =>

                return ALU_SHL;


            when OP_SHR =>

                return ALU_SHR;



            when others =>

                return ALU_PASS;


        end case;


    end function;





    ---------------------------------------------------------------------------
    -- Write Back Decoder
    ---------------------------------------------------------------------------


    function opcode_to_write_back_source
    (
        opcode : opcode_t
    )
    return write_back_source_t is


    begin


        case opcode is


            when OP_MOVI =>

                return WB_IMMEDIATE;



            when OP_LOAD =>

                return WB_MEMORY;



            when OP_ADD |
                 OP_SUB |
                 OP_INC |
                 OP_DEC |
                 OP_AND |
                 OP_OR  |
                 OP_XOR |
                 OP_NOT |
                 OP_SHL |
                 OP_SHR =>

                return WB_ALU;



            when others =>

                return WB_ALU;


        end case;


    end function;





    ---------------------------------------------------------------------------
    -- Opcode Validation
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