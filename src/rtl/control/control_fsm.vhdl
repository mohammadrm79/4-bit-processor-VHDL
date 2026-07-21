-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : control_fsm.vhdl
-- Description  : CPU Control Finite State Machine
--
-- Version      : 1.2.0
-- Description  :
--   Added ALU operation control for datapath integration
--
-- ============================================================================


library ieee;

use ieee.std_logic_1164.all;

use work.cpu_pkg.all;



entity control_fsm is

    port
    (
        clk   : in std_logic;
        reset : in std_logic;


        opcode : in opcode_t;


        zero_flag  : in std_logic;
        carry_flag : in std_logic;


        state_out : out cpu_state_t;


        pc_enable : out std_logic;
        pc_load   : out std_logic;


        ir_enable : out std_logic;


        register_write_enable : out std_logic;


        flags_write_enable : out std_logic;


        memory_read_enable  : out std_logic;
        memory_write_enable : out std_logic;


        alu_operation : out alu_operation_t;


        halted : out std_logic

    );

end entity control_fsm;



architecture rtl of control_fsm is


    signal current_state : cpu_state_t;

    signal next_state : cpu_state_t;



begin



    ---------------------------------------------------------------------------
    -- State Register
    ---------------------------------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then

                current_state <= STATE_RESET;


            else

                current_state <= next_state;


            end if;


        end if;


    end process;



    ---------------------------------------------------------------------------
    -- Next State Logic
    ---------------------------------------------------------------------------

    process(current_state, opcode)

    begin


        next_state <= current_state;


        case current_state is


            when STATE_RESET =>

                next_state <= FETCH;



            when FETCH =>

                next_state <= DECODE;



            when DECODE =>

                next_state <= EXECUTE;



            when EXECUTE =>


                if opcode = OP_HALT then

                    next_state <= STATE_HALTED;


                else

                    next_state <= WRITE_BACK;


                end if;



            when WRITE_BACK =>

                next_state <= FETCH;



            when STATE_HALTED =>

                next_state <= STATE_HALTED;



        end case;


    end process;



    ---------------------------------------------------------------------------
    -- Output Decode
    ---------------------------------------------------------------------------

    process(current_state, opcode, zero_flag, carry_flag)

    begin


        pc_enable <= '0';

        pc_load <= '0';


        ir_enable <= '0';


        register_write_enable <= '0';


        flags_write_enable <= '0';


        memory_read_enable <= '0';

        memory_write_enable <= '0';


        alu_operation <= ALU_PASS;


        halted <= '0';



        case current_state is



            -------------------------------------------------------------------
            -- FETCH
            -------------------------------------------------------------------

            when FETCH =>


                pc_enable <= '1';

                ir_enable <= '1';



            -------------------------------------------------------------------
            -- DECODE
            -------------------------------------------------------------------

            when DECODE =>

                null;



            -------------------------------------------------------------------
            -- EXECUTE
            -------------------------------------------------------------------

            when EXECUTE =>


                case opcode is


                    when OP_ADD =>

                        alu_operation <= ALU_ADD;

                        flags_write_enable <= '1';



                    when OP_SUB =>

                        alu_operation <= ALU_SUB;

                        flags_write_enable <= '1';



                    when OP_INC =>

                        alu_operation <= ALU_INC;

                        flags_write_enable <= '1';



                    when OP_DEC =>

                        alu_operation <= ALU_DEC;

                        flags_write_enable <= '1';



                    when OP_AND =>

                        alu_operation <= ALU_AND;

                        flags_write_enable <= '1';



                    when OP_OR =>

                        alu_operation <= ALU_OR;

                        flags_write_enable <= '1';



                    when OP_XOR =>

                        alu_operation <= ALU_XOR;

                        flags_write_enable <= '1';



                    when OP_NOT =>

                        alu_operation <= ALU_NOT;

                        flags_write_enable <= '1';



                    when OP_SHL =>

                        alu_operation <= ALU_SHL;

                        flags_write_enable <= '1';



                    when OP_SHR =>

                        alu_operation <= ALU_SHR;

                        flags_write_enable <= '1';



                    when OP_LOAD =>

                        memory_read_enable <= '1';



                    when OP_STORE =>

                        memory_write_enable <= '1';



                    when OP_JMP =>

                        pc_load <= '1';



                    when OP_JZ =>

                        if zero_flag = '1' then

                            pc_load <= '1';

                        end if;



                    when OP_JC =>

                        if carry_flag = '1' then

                            pc_load <= '1';

                        end if;



                    when others =>

                        null;



                end case;



            -------------------------------------------------------------------
            -- WRITE BACK
            -------------------------------------------------------------------

            when WRITE_BACK =>


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
                         OP_SHR |
                         OP_MOVI |
                         OP_LOAD =>


                        register_write_enable <= '1';



                    when others =>

                        null;



                end case;



            -------------------------------------------------------------------
            -- HALT
            -------------------------------------------------------------------

            when STATE_HALTED =>


                halted <= '1';



            when STATE_RESET =>


                null;



        end case;


    end process;



    state_out <= current_state;



end architecture rtl;