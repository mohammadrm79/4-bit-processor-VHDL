library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.cpu_pkg.all;


entity tb_alu is
end entity tb_alu;


architecture sim of tb_alu is


    signal operand_a : data_word_t;
    signal operand_b : data_word_t;

    signal operation : alu_operation_t;

    signal result : data_word_t;

    signal zero     : std_logic;
    signal carry    : std_logic;
    signal negative : std_logic;
    signal overflow : std_logic;


begin


    uut : entity work.alu

        port map
        (
            operand_a => operand_a,
            operand_b => operand_b,

            operation => operation,

            result => result,

            zero     => zero,
            carry    => carry,
            negative => negative,
            overflow => overflow
        );



    stimulus : process

    begin


        -----------------------------------------------------------------------
        -- ADD
        -----------------------------------------------------------------------

        operand_a <= "0011";
        operand_b <= "0001";
        operation <= ALU_ADD;

        wait for 10 ns;


        assert result = "0100"
            report "ADD failed"
            severity error;



        -----------------------------------------------------------------------
        -- SUB
        -----------------------------------------------------------------------

        operand_a <= "0100";
        operand_b <= "0001";
        operation <= ALU_SUB;

        wait for 10 ns;


        assert result = "0011"
            report "SUB failed"
            severity error;



        -----------------------------------------------------------------------
        -- AND
        -----------------------------------------------------------------------

        operand_a <= "1111";
        operand_b <= "0011";
        operation <= ALU_AND;

        wait for 10 ns;


        assert result = "0011"
            report "AND failed"
            severity error;



        -----------------------------------------------------------------------
        -- OR
        -----------------------------------------------------------------------

        operand_a <= "1000";
        operand_b <= "0011";
        operation <= ALU_OR;

        wait for 10 ns;


        assert result = "1011"
            report "OR failed"
            severity error;



        -----------------------------------------------------------------------
        -- XOR
        -----------------------------------------------------------------------

        operand_a <= "1111";
        operand_b <= "0011";
        operation <= ALU_XOR;

        wait for 10 ns;


        assert result = "1100"
            report "XOR failed"
            severity error;



        -----------------------------------------------------------------------
        -- NOT
        -----------------------------------------------------------------------

        operand_a <= "1010";
        operand_b <= "0000";
        operation <= ALU_NOT;

        wait for 10 ns;


        assert result = "0101"
            report "NOT failed"
            severity error;



        -----------------------------------------------------------------------
        -- Zero Flag
        -----------------------------------------------------------------------

        operand_a <= "0000";
        operand_b <= "0000";
        operation <= ALU_ADD;

        wait for 10 ns;


        assert zero = '1'
            report "Zero flag failed"
            severity error;



        report "ALU test completed successfully"
            severity note;



        wait;


    end process;


end architecture sim;