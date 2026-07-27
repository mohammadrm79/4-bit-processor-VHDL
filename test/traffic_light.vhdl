LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY traffic_light IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC := '0';
        light_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY traffic_light;

ARCHITECTURE behave OF traffic_light IS
    TYPE STATE_MAP IS
    (
    RED, YELLOW, GREEN
    );

    SIGNAL next_state : STATE_MAP := RED;
    SIGNAL state : STATE_MAP := RED;
BEGIN

    PROCESS (clk, reset)
        VARIABLE next_state : STATE_MAP := RED;
    BEGIN
        IF reset = '1' THEN
            state <= RED;

        ELSIF rising_edge(clk) THEN
            CASE state IS
                WHEN RED =>
                    next_state := GREEN;
                WHEN GREEN =>
                    next_state := YELLOW;
                WHEN YELLOW =>
                    next_state := RED;
                WHEN OTHERS =>
                    next_state := RED;

            END CASE;
        END IF;
        state <= next_state;

    END PROCESS;

    PROCESS (state)
        VARIABLE out_light : STD_LOGIC_VECTOR(1 DOWNTO 0);
    BEGIN
        CASE state IS

            WHEN RED =>
                out_light := "00";
            WHEN GREEN =>
                out_light := "10";
            WHEN YELLOW =>
                out_light := "11";
        END CASE;
        light_out <= out_light;
    END PROCESS;

END ARCHITECTURE behave;