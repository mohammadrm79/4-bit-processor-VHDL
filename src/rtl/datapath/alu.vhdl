-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : alu.vhdl
--
-- Version      : 1.1.0
-- Description  :
--   Fixed combinational ALU timing
--   Fixed extended_result latch issue
--   Fixed carry generation
--   Fixed shift carry handling
--   Fixed overflow calculation
--
-- ============================================================================

LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.cpu_pkg.ALL;

ENTITY alu IS

    PORT (
        operand_a : IN data_word_t;

        operand_b : IN data_word_t;

        operation : IN alu_operation_t;

        result : OUT data_word_t;

        zero : OUT STD_LOGIC;

        carry : OUT STD_LOGIC;

        negative : OUT STD_LOGIC;

        overflow : OUT STD_LOGIC
    );

END ENTITY alu;

ARCHITECTURE rtl OF alu IS

    SIGNAL result_internal : data_word_t;

    SIGNAL carry_internal : STD_LOGIC;

    SIGNAL overflow_internal : STD_LOGIC;

BEGIN

    PROCESS (
        operand_a,
        operand_b,
        operation
        )

        VARIABLE temp : unsigned(DATA_WIDTH DOWNTO 0);

        VARIABLE a : signed(DATA_WIDTH - 1 DOWNTO 0);

        VARIABLE b : signed(DATA_WIDTH - 1 DOWNTO 0);

        VARIABLE r : signed(DATA_WIDTH - 1 DOWNTO 0);

    BEGIN

        temp := (OTHERS => '0');

        carry_internal <= '0';

        overflow_internal <= '0';

        a := signed(operand_a);

        b := signed(operand_b);
        CASE operation IS

            WHEN ALU_ADD =>

                temp :=
                       unsigned('0' & operand_a)
                       +
                       unsigned('0' & operand_b);

                r := a + b;

                REPORT
                    " operand_a: " & INTEGER'image(to_integer(unsigned(operand_a))) &
                    " operand_b: " & INTEGER'image(to_integer(unsigned(operand_b))) &
                    " result: " & INTEGER'image(to_integer(unsigned(r))) &
                    " temp: " & INTEGER'image(to_integer(temp)) &
                    " a: " & INTEGER'image(to_integer(a)) &
                    " b: " & INTEGER'image(to_integer(b)) &
                    " r: " & INTEGER'image(to_integer(r)) &
                    " overflow_internal: " & STD_LOGIC'image(overflow_internal)
                    SEVERITY NOTE;
                IF (operand_a(DATA_WIDTH - 1) = operand_b(DATA_WIDTH - 1))
                    AND
                    (r(DATA_WIDTH - 1) /= operand_a(DATA_WIDTH - 1))
                    THEN

                    overflow_internal <= '1';

                END IF;

            WHEN ALU_SUB =>

                temp :=
                       unsigned('0' & operand_a)
                       -
                       unsigned('0' & operand_b);

                r := a - b;

                IF (operand_a(DATA_WIDTH - 1) /= operand_b(DATA_WIDTH - 1))
                    AND
                    (r(DATA_WIDTH - 1) /= operand_a(DATA_WIDTH - 1))
                    THEN

                    overflow_internal <= '1';

                END IF;

            WHEN ALU_INC =>

                temp :=
                       unsigned('0' & operand_a)
                       +
                       1;

            WHEN ALU_DEC =>

                temp :=
                       unsigned('0' & operand_a)
                       -
                       1;

            WHEN ALU_AND =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned(operand_a AND operand_b);

            WHEN ALU_OR =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned(operand_a OR operand_b);

            WHEN ALU_XOR =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned(operand_a XOR operand_b);

            WHEN ALU_NOT =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned(NOT operand_a);

            WHEN ALU_SHL =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned(operand_a(DATA_WIDTH - 2 DOWNTO 0) & '0');

                temp(DATA_WIDTH)
                 :=
                operand_a(DATA_WIDTH - 1);

            WHEN ALU_SHR =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned('0' & operand_a(DATA_WIDTH - 1 DOWNTO 1));

                temp(DATA_WIDTH)
                 :=
                operand_a(0);

            WHEN ALU_PASS =>

                temp(DATA_WIDTH - 1 DOWNTO 0)
                 :=
                unsigned(operand_a);

            WHEN OTHERS =>

                temp := (OTHERS => '0');

        END CASE;

        result_internal
        <= STD_LOGIC_VECTOR(temp(DATA_WIDTH - 1 DOWNTO 0));

        carry_internal
        <= temp(DATA_WIDTH);

    END PROCESS;

    result <= result_internal;

    zero <= '1'
            WHEN result_internal = "0000"
            ELSE
            '0';

    negative <= result_internal(DATA_WIDTH - 1);

    carry <= carry_internal;

    overflow <= overflow_internal;

END ARCHITECTURE rtl;