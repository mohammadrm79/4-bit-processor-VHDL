LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.cpu_pkg.ALL;

ENTITY tb_alu IS
END ENTITY tb_alu;

ARCHITECTURE sim OF tb_alu IS

    SIGNAL operand_a : data_word_t;
    SIGNAL operand_b : data_word_t;

    SIGNAL operation : alu_operation_t;

    SIGNAL result : data_word_t;

    SIGNAL zero : STD_LOGIC;
    SIGNAL carry : STD_LOGIC;
    SIGNAL negative : STD_LOGIC;
    SIGNAL overflow : STD_LOGIC;

BEGIN

    uut : ENTITY work.alu

        PORT MAP
        (
            operand_a => operand_a,
            operand_b => operand_b,

            operation => operation,

            result => result,

            zero => zero,
            carry => carry,
            negative => negative,
            overflow => overflow
        );

    stimulus : PROCESS

    BEGIN

        -----------------------------------------------------------------------
        -- ADD
        -----------------------------------------------------------------------

        operand_a <= "0011";
        operand_b <= "0001";
        operation <= ALU_ADD;

        WAIT FOR 10 ns;

        ASSERT result = "0100"
        REPORT "ADD failed"
            SEVERITY error;

        -----------------------------------------------------------------------
        -- SUB
        -----------------------------------------------------------------------

        operand_a <= "0100";
        operand_b <= "0001";
        operation <= ALU_SUB;

        WAIT FOR 10 ns;

        ASSERT result = "0011"
        REPORT "SUB failed"
            SEVERITY error;

        -----------------------------------------------------------------------
        -- AND
        -----------------------------------------------------------------------

        operand_a <= "1111";
        operand_b <= "0011";
        operation <= ALU_AND;

        WAIT FOR 10 ns;

        ASSERT result = "0011"
        REPORT "AND failed"
            SEVERITY error;

        -----------------------------------------------------------------------
        -- OR
        -----------------------------------------------------------------------

        operand_a <= "1000";
        operand_b <= "0011";
        operation <= ALU_OR;

        WAIT FOR 10 ns;

        ASSERT result = "1011"
        REPORT "OR failed"
            SEVERITY error;

        -----------------------------------------------------------------------
        -- XOR
        -----------------------------------------------------------------------

        operand_a <= "1111";
        operand_b <= "0011";
        operation <= ALU_XOR;

        WAIT FOR 10 ns;

        ASSERT result = "1100"
        REPORT "XOR failed"
            SEVERITY error;

        -----------------------------------------------------------------------
        -- NOT
        -----------------------------------------------------------------------

        operand_a <= "1010";
        operand_b <= "0000";
        operation <= ALU_NOT;

        WAIT FOR 10 ns;

        ASSERT result = "0101"
        REPORT "NOT failed"
            SEVERITY error;

        -----------------------------------------------------------------------
        -- Zero Flag
        -----------------------------------------------------------------------

        operand_a <= "0000";
        operand_b <= "0000";
        operation <= ALU_ADD;

        WAIT FOR 10 ns;

        ASSERT zero = '1'
        REPORT "Zero flag failed"
            SEVERITY error;

        REPORT "ALU test completed successfully"
            SEVERITY note;

        WAIT;

    END PROCESS;

END ARCHITECTURE sim;