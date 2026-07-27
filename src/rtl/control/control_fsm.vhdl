-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : control_fsm.vhdl
-- Description  : CPU Control Finite State Machine
--
-- Version      : 1.6.0
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.cpu_pkg.ALL;

ENTITY control_fsm IS

    PORT (
        clk : IN STD_LOGIC;

        reset : IN STD_LOGIC;

        opcode : IN opcode_t;

        zero_flag : IN STD_LOGIC;

        carry_flag : IN STD_LOGIC;

        state_out : OUT cpu_state_t;

        pc_enable : OUT STD_LOGIC;

        pc_load : OUT STD_LOGIC;

        ir_enable : OUT STD_LOGIC;

        register_write_enable : OUT STD_LOGIC;

        flags_write_enable : OUT STD_LOGIC;

        memory_read_enable : OUT STD_LOGIC;

        memory_write_enable : OUT STD_LOGIC;

        alu_operation : OUT alu_operation_t;

        write_back_source : OUT write_back_source_t;

        halted : OUT STD_LOGIC;

        alu_result_enable : OUT STD_LOGIC
    );

END ENTITY control_fsm;

ARCHITECTURE rtl OF control_fsm IS

    SIGNAL current_state : cpu_state_t := STATE_RESET;

    SIGNAL next_state : cpu_state_t := STATE_RESET;

BEGIN

    ---------------------------------------------------------------------------
    -- State Register
    ---------------------------------------------------------------------------

    PROCESS (clk)

    BEGIN

        IF rising_edge(clk) THEN

            IF reset = '1' THEN

                current_state <= STATE_RESET;

            ELSE

                current_state <= next_state;

            END IF;

        END IF;

    END PROCESS;

    ---------------------------------------------------------------------------
    -- Next State Logic
    ---------------------------------------------------------------------------

    PROCESS (current_state, opcode)

    BEGIN

        next_state <= STATE_RESET;

        CASE current_state IS

            WHEN STATE_RESET =>

                next_state <= FETCH;

            WHEN FETCH =>

                next_state <= DECODE;

            WHEN DECODE =>

                next_state <= EXECUTE;

            WHEN EXECUTE =>

                IF opcode = OP_HALT THEN

                    next_state <= STATE_HALTED;

                ELSE

                    next_state <= WRITE_BACK;

                END IF;

            WHEN WRITE_BACK =>

                next_state <= FETCH;

            WHEN STATE_HALTED =>

                next_state <= STATE_HALTED;

            WHEN OTHERS =>

                next_state <= STATE_RESET;

        END CASE;

    END PROCESS;

    ---------------------------------------------------------------------------
    -- Output Logic
    ---------------------------------------------------------------------------

    PROCESS (
        current_state,
        opcode,
        zero_flag,
        carry_flag
        )

    BEGIN
        alu_result_enable <= '0';
        pc_enable <= '0';

        pc_load <= '0';

        ir_enable <= '0';

        register_write_enable <= '0';

        flags_write_enable <= '0';

        memory_read_enable <= '0';

        memory_write_enable <= '0';

        alu_operation <= ALU_PASS;

        write_back_source <= WB_ALU;

        halted <= '0';

        CASE current_state IS

            WHEN STATE_RESET =>

                NULL;

            WHEN FETCH =>

                ir_enable <= '1';

                pc_enable <= '1';

            WHEN DECODE =>

                NULL;

            WHEN EXECUTE =>

                CASE opcode IS

                    WHEN OP_ADD =>

                        alu_operation <= ALU_ADD;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_SUB =>

                        alu_operation <= ALU_SUB;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_INC =>

                        alu_operation <= ALU_INC;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_DEC =>

                        alu_operation <= ALU_DEC;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_AND =>

                        alu_operation <= ALU_AND;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_OR =>

                        alu_operation <= ALU_OR;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_XOR =>

                        alu_operation <= ALU_XOR;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_NOT =>

                        alu_operation <= ALU_NOT;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_SHL =>

                        alu_operation <= ALU_SHL;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_SHR =>

                        alu_operation <= ALU_SHR;

                        flags_write_enable <= '1';
                        alu_result_enable <= '1';

                    WHEN OP_MOVI =>

                        write_back_source <= WB_IMMEDIATE;

                    WHEN OP_LOAD =>

                        memory_read_enable <= '1';

                        write_back_source <= WB_MEMORY;

                    WHEN OP_STORE =>

                        memory_write_enable <= '1';

                    WHEN OP_JMP =>

                        pc_load <= '1';

                    WHEN OP_JZ =>

                        IF zero_flag = '1' THEN

                            pc_load <= '1';

                        END IF;

                    WHEN OP_JC =>

                        IF carry_flag = '1' THEN

                            pc_load <= '1';

                        END IF;

                    WHEN OP_HALT =>

                        NULL;

                    WHEN OTHERS =>

                        NULL;

                END CASE;

            WHEN WRITE_BACK =>

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

                        register_write_enable <= '1';

                        write_back_source <= WB_ALU;

                    WHEN OP_MOVI =>

                        register_write_enable <= '1';

                        write_back_source <= WB_IMMEDIATE;

                    WHEN OP_LOAD =>

                        register_write_enable <= '1';

                        write_back_source <= WB_MEMORY;

                    WHEN OTHERS =>

                        NULL;

                END CASE;

            WHEN STATE_HALTED =>

                halted <= '1';

            WHEN OTHERS =>

                NULL;

        END CASE;

        REPORT
            "STATE="
            & cpu_state_t'image(current_state)
            & " OPCODE="
            & INTEGER'image(to_integer(unsigned(opcode)))
            & " WB_EN="
            & STD_LOGIC'image(register_write_enable)
            SEVERITY NOTE;
    END PROCESS;

    state_out <= current_state;

END ARCHITECTURE rtl;