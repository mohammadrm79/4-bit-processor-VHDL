-- ============================================================================
-- Project      : RISC-4 Educational CPU
-- File         : alu.vhdl
--
-- Version      : 1.2.0
--
-- Description :
--   Fully combinational ALU
--   Fixed carry generation
--   Fixed overflow generation
--   Fixed INC/DEC overflow
--   Fixed shift carry
--   Stable flag generation
--
-- ============================================================================

LIBRARY IEEE;

USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

USE WORK.cpu_pkg.ALL;

ENTITY alu IS

	PORT
	(
		operand_a : IN data_word_t;
		operand_b : IN data_word_t;

		operation : IN alu_operation_t;

		result : OUT data_word_t;

		zero     : OUT STD_LOGIC;
		carry    : OUT STD_LOGIC;
		negative : OUT STD_LOGIC;
		overflow : OUT STD_LOGIC
	);

END ENTITY alu;

ARCHITECTURE rtl OF alu IS

	SIGNAL result_internal   : data_word_t;
	SIGNAL carry_internal    : STD_LOGIC;
	SIGNAL overflow_internal : STD_LOGIC;

BEGIN

	---------------------------------------------------------------------------
	-- Combinational ALU
	---------------------------------------------------------------------------

	alu_process :
	PROCESS
	(
		operand_a,
		operand_b,
		operation
	)

	VARIABLE temp : UNSIGNED(DATA_WIDTH DOWNTO 0);

	VARIABLE a : SIGNED(DATA_WIDTH-1 DOWNTO 0);
	VARIABLE b : SIGNED(DATA_WIDTH-1 DOWNTO 0);
	VARIABLE r : SIGNED(DATA_WIDTH-1 DOWNTO 0);

	VARIABLE carry_v    : STD_LOGIC;
	VARIABLE overflow_v : STD_LOGIC;

	BEGIN

		temp := (OTHERS => '0');

		carry_v := '0';
		overflow_v := '0';

		a := SIGNED(operand_a);
		b := SIGNED(operand_b);

		-----------------------------------------------------------------------
		-- Operation Decode
		-----------------------------------------------------------------------

		CASE operation IS

			-------------------------------------------------------------------
			-- ADD
			-------------------------------------------------------------------

			WHEN ALU_ADD =>

				temp :=
				UNSIGNED('0' & operand_a)
				+
				UNSIGNED('0' & operand_b);

				r := a + b;

				carry_v := temp(DATA_WIDTH);

				IF
				operand_a(DATA_WIDTH-1) =
				operand_b(DATA_WIDTH-1)
				AND
				r(DATA_WIDTH-1) /=
				operand_a(DATA_WIDTH-1)
				THEN
					overflow_v := '1';
				END IF;

				-- REPORT
				--     "ADD"
				-- SEVERITY NOTE;

				-------------------------------------------------------------------
				-- SUB
				-------------------------------------------------------------------

			WHEN ALU_SUB =>

				temp :=
				UNSIGNED('0' & operand_a)
				-
				UNSIGNED('0' & operand_b);

				r := a - b;

				carry_v := temp(DATA_WIDTH);

				IF
				operand_a(DATA_WIDTH-1) /=
				operand_b(DATA_WIDTH-1)
				AND
				r(DATA_WIDTH-1) /=
				operand_a(DATA_WIDTH-1)
				THEN
					overflow_v := '1';
				END IF;
				-------------------------------------------------------------------
				-- INC
				-------------------------------------------------------------------

			WHEN ALU_INC =>

				temp :=
				UNSIGNED('0' & operand_a)
				+ 1;

				carry_v := temp(DATA_WIDTH);

				r := a + 1;

				-- +7 -> -8
				IF
				operand_a = "0111"
				THEN
					overflow_v := '1';
				END IF;

				-------------------------------------------------------------------
				-- DEC
				-------------------------------------------------------------------

			WHEN ALU_DEC =>

				temp :=
				UNSIGNED('0' & operand_a)
				- 1;

				carry_v := temp(DATA_WIDTH);

				r := a - 1;

				-- -8 -> +7
				IF
				operand_a = "1000"
				THEN
					overflow_v := '1';
				END IF;

				-------------------------------------------------------------------
				-- AND
				-------------------------------------------------------------------

			WHEN ALU_AND =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(operand_a AND operand_b);

				-------------------------------------------------------------------
				-- OR
				-------------------------------------------------------------------

			WHEN ALU_OR =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(operand_a OR operand_b);

				-------------------------------------------------------------------
				-- XOR
				-------------------------------------------------------------------

			WHEN ALU_XOR =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(operand_a XOR operand_b);

				-------------------------------------------------------------------
				-- NOT
				-------------------------------------------------------------------

			WHEN ALU_NOT =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(NOT operand_a);

				-------------------------------------------------------------------
				-- SHL
				-------------------------------------------------------------------

			WHEN ALU_SHL =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(
					operand_a(DATA_WIDTH-2 DOWNTO 0)
					& '0'
				);

				carry_v := operand_a(DATA_WIDTH-1);

				-------------------------------------------------------------------
				-- SHR
				-------------------------------------------------------------------

			WHEN ALU_SHR =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(
					'0'
					&
					operand_a(DATA_WIDTH-1 DOWNTO 1)
				);

				carry_v := operand_a(0);

				-------------------------------------------------------------------
				-- PASS
				-------------------------------------------------------------------

			WHEN ALU_PASS =>

				temp(DATA_WIDTH-1 DOWNTO 0) :=
				UNSIGNED(operand_a);

				-------------------------------------------------------------------
				-- DEFAULT
				-------------------------------------------------------------------

			WHEN OTHERS =>

				temp := (OTHERS => '0');

		END CASE;
		-----------------------------------------------------------------------
		-- Register Outputs
		-----------------------------------------------------------------------

		result_internal <=
		STD_LOGIC_VECTOR(
			temp(DATA_WIDTH-1 DOWNTO 0)
		);

		carry_internal <= carry_v;

		overflow_internal <= overflow_v;

	END PROCESS alu_process;

	---------------------------------------------------------------------------
	-- Result
	---------------------------------------------------------------------------

	result <= result_internal;

	---------------------------------------------------------------------------
	-- Zero Flag
	---------------------------------------------------------------------------

	zero <=
	'1'
	WHEN result_internal = (result_internal'RANGE => '0')
ELSE
	'0';

	---------------------------------------------------------------------------
	-- Negative Flag
	---------------------------------------------------------------------------

	negative <= result_internal(DATA_WIDTH - 1);

	---------------------------------------------------------------------------
	-- Carry Flag
	---------------------------------------------------------------------------

	carry <= carry_internal;

	---------------------------------------------------------------------------
	-- Overflow Flag
	---------------------------------------------------------------------------

	overflow <= overflow_internal;

END ARCHITECTURE rtl;
