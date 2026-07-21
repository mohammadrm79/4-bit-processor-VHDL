-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : cpu_core.vhdl
-- Description  : CPU Core Top-Level Integration
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-002 : 16-bit Fixed-Length Instructions
--   - DD-003 : Load/Store Architecture
--   - DD-005 : Multi-Cycle Execution
--   - DD-006 : Harvard Memory Architecture
--   - DD-007 : Non-Pipelined Processor
--   - DD-013 : Hierarchical RTL Organization
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
    -- Internal Signals
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



    signal cpu_state : cpu_state_t;



    signal zero_flag  : std_logic;

    signal carry_flag : std_logic;



    signal pc_enable : std_logic;

    signal pc_load   : std_logic;


    signal ir_enable : std_logic;


    signal register_write_enable : std_logic;


    signal flags_write_enable : std_logic;


    signal memory_read_enable : std_logic;

    signal memory_write_enable : std_logic;



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
    -- Instruction Decoder
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

        halted => halted

    );



end architecture rtl;