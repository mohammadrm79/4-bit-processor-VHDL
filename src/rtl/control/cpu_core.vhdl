-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : cpu_core.vhdl
--
-- Version      : 3.0.0
-- Description  :
--   Three-register datapath
--   R-Type format:
--     RD  = instruction(10:8)
--     RS1 = instruction(7:5)
--     RS2 = instruction(4:2)
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.cpu_pkg.ALL;

ENTITY cpu_core IS

    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        halted : OUT STD_LOGIC;

        debug_r0 : OUT data_word_t;
        debug_r1 : OUT data_word_t;
        debug_r2 : OUT data_word_t;
        debug_r3 : OUT data_word_t
    );

END ENTITY cpu_core;

ARCHITECTURE rtl OF cpu_core IS

    SIGNAL pc_value : address_t;

    SIGNAL instruction_memory_data : instruction_t;
    SIGNAL instruction : instruction_t;

    SIGNAL opcode : opcode_t := OP_HALT;

    ---------------------------------------------------------------------------
    -- Register indices
    ---------------------------------------------------------------------------

    SIGNAL destination_register : register_index_t;
    SIGNAL source_register_a : register_index_t;
    SIGNAL source_register_b : register_index_t;

    SIGNAL immediate : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL jump_address : address_t;

    SIGNAL cpu_state : cpu_state_t;

    SIGNAL pc_enable : STD_LOGIC;
    SIGNAL pc_load : STD_LOGIC;
    SIGNAL ir_enable : STD_LOGIC;

    SIGNAL register_write_enable : STD_LOGIC;
    SIGNAL flags_write_enable : STD_LOGIC;

    SIGNAL memory_write_enable : STD_LOGIC;
    SIGNAL memory_read_enable : STD_LOGIC;

    SIGNAL alu_operation : alu_operation_t;
    SIGNAL write_back_source : write_back_source_t;

    ---------------------------------------------------------------------------
    -- Datapath
    ---------------------------------------------------------------------------

    SIGNAL register_data_a : data_word_t;
    SIGNAL register_data_b : data_word_t;

    SIGNAL alu_result : data_word_t;
    SIGNAL alu_result_registered : data_word_t;
    SIGNAL alu_result_enable : STD_LOGIC;
    SIGNAL alu_zero : STD_LOGIC;
    SIGNAL alu_carry : STD_LOGIC;
    SIGNAL alu_negative : STD_LOGIC;
    SIGNAL alu_overflow : STD_LOGIC;

    SIGNAL zero_flag : STD_LOGIC;
    SIGNAL carry_flag : STD_LOGIC;

    SIGNAL memory_address : address_t;
    SIGNAL memory_read_data : data_word_t;

    SIGNAL register_write_data : data_word_t;

BEGIN

    ---------------------------------------------------------------------------
    -- PC
    ---------------------------------------------------------------------------

    program_counter : ENTITY work.pc
        PORT MAP
        (
            clk => clk,
            reset => reset,
            enable => pc_enable,
            load => pc_load,
            next_address => jump_address,
            pc_value => pc_value
        );

    ---------------------------------------------------------------------------
    -- Instruction Memory
    ---------------------------------------------------------------------------

    instruction_mem : ENTITY work.instruction_memory
        PORT MAP
        (
            address => pc_value,
            instruction => instruction_memory_data
        );

    ---------------------------------------------------------------------------
    -- Instruction Register
    ---------------------------------------------------------------------------

    instruction_reg : ENTITY work.instruction_register
        PORT MAP
        (
            clk => clk,
            reset => reset,
            enable => ir_enable,
            instruction_in => instruction_memory_data,
            instruction_out => instruction
        );

    ---------------------------------------------------------------------------
    -- Decoder
    ---------------------------------------------------------------------------

    decoder : ENTITY work.instruction_decoder
        PORT MAP
        (
            instruction => instruction,

            opcode => opcode,
            format => OPEN,

            register_a => destination_register,
            source_a => source_register_a,
            source_b => source_register_b,

            immediate => immediate,
            address => jump_address
        );

    ---------------------------------------------------------------------------
    -- Register File
    ---------------------------------------------------------------------------

    registers : ENTITY work.register_file
        PORT MAP
        (
            clk => clk,
            reset => reset,

            write_enable => register_write_enable,
            write_address => destination_register,
            write_data => register_write_data,

            read_address_a => source_register_a,
            read_address_b => source_register_b,

            read_data_a => register_data_a,
            read_data_b => register_data_b,

            debug_r0 => debug_r0,
            debug_r1 => debug_r1,
            debug_r2 => debug_r2,
            debug_r3 => debug_r3
        );

    ---------------------------------------------------------------------------
    -- ALU
    ---------------------------------------------------------------------------

    arithmetic_logic_unit : ENTITY work.alu
        PORT MAP
        (
            operand_a => register_data_a,
            operand_b => register_data_b,

            operation => alu_operation,

            result => alu_result,

            zero => alu_zero,
            carry => alu_carry,
            negative => alu_negative,
            overflow => alu_overflow
        );
    PROCESS (alu_result, register_data_a, register_data_b, alu_operation)
    BEGIN
        REPORT
            "ALU_MONITOR A="
            & INTEGER'image(to_integer(unsigned(register_data_a)))
            & " B="
            & INTEGER'image(to_integer(unsigned(register_data_b)))
            & " RESULT="
            & INTEGER'image(to_integer(unsigned(alu_result)))
            SEVERITY NOTE;
    END PROCESS;

    alu_result_reg : ENTITY work.alu_result_register
        PORT MAP
        (
            clk => clk,
            reset => reset,
            enable => alu_result_enable,

            data_in => alu_result,
            data_out => alu_result_registered
        );
    ---------------------------------------------------------------------------
    -- Flags
    ---------------------------------------------------------------------------

    flags : ENTITY work.flags_register
        PORT MAP
        (
            clk => clk,
            reset => reset,
            enable => flags_write_enable,

            zero_in => alu_zero,
            carry_in => alu_carry,
            negative_in => alu_negative,
            overflow_in => alu_overflow,

            zero_out => zero_flag,
            carry_out => carry_flag,

            negative_out => OPEN,
            overflow_out => OPEN
        );

    ---------------------------------------------------------------------------
    -- Data Memory
    ---------------------------------------------------------------------------

    memory_address <= "0000000" & register_data_b;

    data_mem : ENTITY work.data_memory
        PORT MAP
        (
            clk => clk,
            reset => reset,

            address => memory_address,

            write_enable => memory_write_enable,

            write_data => register_data_a,

            read_data => memory_read_data
        );

    ---------------------------------------------------------------------------
    -- Write Back
    ---------------------------------------------------------------------------

    PROCESS (
        write_back_source,
        alu_result,
        immediate,
        memory_read_data
        )

        VARIABLE wb_value : data_word_t;

    BEGIN

        CASE write_back_source IS

            WHEN WB_ALU =>
                wb_value := alu_result_registered;

            WHEN WB_IMMEDIATE =>
                wb_value := immediate(3 DOWNTO 0);

            WHEN WB_MEMORY =>
                wb_value := memory_read_data;

            WHEN OTHERS =>
                wb_value := (OTHERS => '0');

        END CASE;

        REPORT
            "WB: source="
            & write_back_source_t'image(write_back_source)
            & " wb="
            & INTEGER'image(to_integer(unsigned(wb_value)))
            SEVERITY NOTE;

        register_write_data <= wb_value;
    END PROCESS;

    ---------------------------------------------------------------------------
    -- Control FSM
    ---------------------------------------------------------------------------

    control : ENTITY work.control_fsm
        PORT MAP
        (
            clk => clk,
            reset => reset,
            alu_result_enable => alu_result_enable,
            opcode => opcode,

            zero_flag => zero_flag,
            carry_flag => carry_flag,

            state_out => cpu_state,

            pc_enable => pc_enable,
            pc_load => pc_load,
            ir_enable => ir_enable,

            register_write_enable => register_write_enable,
            flags_write_enable => flags_write_enable,

            memory_read_enable => memory_read_enable,
            memory_write_enable => memory_write_enable,

            alu_operation => alu_operation,
            write_back_source => write_back_source,

            halted => halted
        );

END ARCHITECTURE rtl;