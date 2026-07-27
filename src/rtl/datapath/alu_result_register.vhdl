-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : alu_result_register.vhdl
-- Description  : ALU Result Register
--
-- Version      : 1.0.0
-- ============================================================================
LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

USE work.cpu_pkg.ALL;

ENTITY alu_result_register IS

    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;

        data_in : IN data_word_t;
        data_out : OUT data_word_t
    );

END ENTITY alu_result_register;

ARCHITECTURE rtl OF alu_result_register IS

    SIGNAL reg_data : data_word_t := (OTHERS => '0');

BEGIN

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN

            IF reset = '1' THEN

                reg_data <= (OTHERS => '0');

            ELSIF enable = '1' THEN

                reg_data <= data_in;

            END IF;

        END IF;
    END PROCESS;

    data_out <= reg_data;

END ARCHITECTURE rtl;