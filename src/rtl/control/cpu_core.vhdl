-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : cpu_core.vhdl
-- Description  : CPU Core Top-Level Integration
--
-- Version      : 2.0.0
-- Description  :
--   Datapath integration
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity cpu_core is

    port
    (
        clk   : in std_logic;
        reset : in std_logic;

        halted : out std_logic

    );

end entity cpu_core;



architecture rtl of cpu_core is



    ---------------------------------------------------------------------------
    -- Instruction Path
    ---------------------------------------------------------------------------

    signal pc_value : address_t;

    signal instruction_memory_data : instruction_t;

    signal instruction : instruction_t;


    signal opcode : opcode_t;


    signal instruction_format : instruction_format_t;


    signal register_a : register_index_t;

    signal register_b : register_index_t;


    signal immediate : std_logic_vector(7 downto 0);

    signal jump_address : address_t;



    ---------------------------------------------------------------------------
    -- Control Signals
    ---------------------------------------------------------------------------

    signal cpu_state : cpu_state_t;


    signal pc_enable : std_logic;

    signal pc_load : std_logic;


    signal ir_enable : std_logic;


    signal register_write_enable : std_logic;


    signal flags_write_enable : std_logic;


    signal memory_read_enable : std_logic;

    signal memory_write_enable : std_logic;



    signal alu_operation : alu_operation_t;



    ---------------------------------------------------------------------------
    -- Register File Signals
    ---------------------------------------------------------------------------

    signal register_data_a : data_word_t;

    signal register_data_b : data_word_t;


    signal register_write_data : data_word_t;



    ---------------------------------------------------------------------------
    -- ALU Signals
    ---------------------------------------------------------------------------

    signal alu_result : data_word_t;


    signal alu_zero : std_logic;

    signal alu_carry : std_logic;

    signal alu_negative : std_logic;

    signal alu_overflow : std_logic;



    ---------------------------------------------------------------------------
    -- Flags
    ---------------------------------------------------------------------------

    signal zero_flag : std_logic;

    signal carry_flag : std_logic;



begin



    ---------------------------------------------------------------------------
    -- Program Counter
    ---------------------------------------------------------------------------

    program_counter : entity work.pc

    port map
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

    instruction_mem : entity work.instruction_memory

    port map
    (
        address => pc_value,

        instruction => instruction_memory_data

    );



    ---------------------------------------------------------------------------
    -- Instruction Register
    ---------------------------------------------------------------------------

    instruction_reg : entity work.instruction_register

    port map
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

    decoder : entity work.instruction_decoder

    port map
    (
        instruction => instruction,

        opcode => opcode,

        format => instruction_format,

        register_a => register_a,

        register_b => register_b,

        immediate => immediate,

        address => jump_address

    );



    ---------------------------------------------------------------------------
    -- Register File
    ---------------------------------------------------------------------------

    registers : entity work.register_file

    port map
    (
        clk => clk,

        reset => reset,


        write_enable => register_write_enable,

        write_address => register_a,

        write_data => register_write_data,


        read_address_a => register_a,

        read_address_b => register_b,


        read_data_a => register_data_a,

        read_data_b => register_data_b

    );



    ---------------------------------------------------------------------------
    -- ALU
    ---------------------------------------------------------------------------

    arithmetic_logic_unit : entity work.alu

    port map
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



    ---------------------------------------------------------------------------
    -- Flags Register
    ---------------------------------------------------------------------------

    flags : entity work.flags_register

    port map
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


        negative_out => open,

        overflow_out => open

    );



    ---------------------------------------------------------------------------
    -- Write Back Selection
    ---------------------------------------------------------------------------

    process(opcode, alu_result, immediate)

    begin


        case opcode is


            when OP_MOVI =>

                register_write_data <= immediate(3 downto 0);



            when others =>

                register_write_data <= alu_result;



        end case;


    end process;



    ---------------------------------------------------------------------------
    -- Control Unit
    ---------------------------------------------------------------------------

    control : entity work.control_fsm

    port map
    (
        clk => clk,

        reset => reset,


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


        halted => halted

    );



end architecture rtl;