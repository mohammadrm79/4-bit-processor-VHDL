-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : alu.vhdl
-- Description  : Arithmetic Logic Unit
--
-- Version      : 1.0.0
-- Language     : VHDL-2008
--
-- Implements:
--   - DD-001 : 4-bit Datapath
--   - DD-003 : Load/Store Architecture
--   - DD-005 : Multi-Cycle Execution
--
-- ============================================================================

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cpu_pkg.all;



entity alu is

    port
    (
        operand_a : in  data_word_t;
        operand_b : in  data_word_t;

        operation : in  alu_operation_t;

        result : out data_word_t;

        zero     : out std_logic;
        carry    : out std_logic;
        negative : out std_logic;
        overflow : out std_logic
    );

end entity alu;



architecture rtl of alu is


    signal extended_result : unsigned(DATA_WIDTH downto 0);

    signal alu_result : data_word_t;


begin


    ---------------------------------------------------------------------------
    -- ALU Combinational Logic
    ---------------------------------------------------------------------------

    process(operand_a, operand_b, operation)

        variable temp : unsigned(DATA_WIDTH downto 0);

    begin


        temp := (others => '0');


        case operation is


            -------------------------------------------------------------------
            -- Arithmetic Operations
            -------------------------------------------------------------------

            when ALU_ADD =>

                temp := unsigned('0' & operand_a)
                      + unsigned('0' & operand_b);



            when ALU_SUB =>

                temp := unsigned('0' & operand_a)
                      - unsigned('0' & operand_b);



            when ALU_INC =>

                temp := unsigned('0' & operand_a)
                      + 1;



            when ALU_DEC =>

                temp := unsigned('0' & operand_a)
                      - 1;



            -------------------------------------------------------------------
            -- Logic Operations
            -------------------------------------------------------------------

            when ALU_AND =>

                temp(DATA_WIDTH-1 downto 0)
                    := unsigned(operand_a and operand_b);



            when ALU_OR =>

                temp(DATA_WIDTH-1 downto 0)
                    := unsigned(operand_a or operand_b);



            when ALU_XOR =>

                temp(DATA_WIDTH-1 downto 0)
                    := unsigned(operand_a xor operand_b);



            when ALU_NOT =>

                temp(DATA_WIDTH-1 downto 0)
                    := unsigned(not operand_a);



            -------------------------------------------------------------------
            -- Shift Operations
            -------------------------------------------------------------------

            when ALU_SHL =>

                temp(DATA_WIDTH-1 downto 0)
                    := shift_left(unsigned(operand_a), 1);



            when ALU_SHR =>

                temp(DATA_WIDTH-1 downto 0)
                    := shift_right(unsigned(operand_a), 1);



            -------------------------------------------------------------------
            -- Pass Operation
            -------------------------------------------------------------------

            when ALU_PASS =>

                temp(DATA_WIDTH-1 downto 0)
                    := unsigned(operand_a);



        end case;



        extended_result <= temp;
        
        alu_result <= std_logic_vector(temp(DATA_WIDTH-1 downto 0));


    end process;



    ---------------------------------------------------------------------------
    -- Result Assignment
    ---------------------------------------------------------------------------

    result <= alu_result;



    ---------------------------------------------------------------------------
    -- Status Flags
    ---------------------------------------------------------------------------

    zero <= '1' when alu_result = "0000"
            else '0';


    negative <= alu_result(DATA_WIDTH-1);



    carry <= extended_result(DATA_WIDTH);



    ---------------------------------------------------------------------------
    -- Overflow Detection
    ---------------------------------------------------------------------------

    process(operand_a, operand_b, alu_result, operation)

    begin

        overflow <= '0';


        case operation is


            when ALU_ADD =>

                if (operand_a(DATA_WIDTH-1) =
                    operand_b(DATA_WIDTH-1))
                and
                   (alu_result(DATA_WIDTH-1) /=
                    operand_a(DATA_WIDTH-1)) then

                    overflow <= '1';

                end if;



            when ALU_SUB =>

                if (operand_a(DATA_WIDTH-1) /=
                    operand_b(DATA_WIDTH-1))
                and
                   (alu_result(DATA_WIDTH-1) /=
                    operand_a(DATA_WIDTH-1)) then

                    overflow <= '1';

                end if;



            when others =>

                overflow <= '0';


        end case;


    end process;



end architecture rtl;