#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PROGRAM_DIR="$ROOT_DIR/tb/programs"

ASM_DIR="$PROGRAM_DIR/asm"
BIN_DIR="$PROGRAM_DIR/bin"

TEST_LIST="$PROGRAM_DIR/tests.lst"

ASSEMBLER="$ROOT_DIR/scripts/assembler.awk"

echo "======================================"
echo "RISC-4 Assembler"
echo "======================================"

mkdir -p "$BIN_DIR"

while read -r test_name
do

    [[ -z "$test_name" ]] && continue
    [[ "$test_name" =~ ^# ]] && continue

    asm_file="$ASM_DIR/$test_name.asm"
    mem_file="$BIN_DIR/$test_name.mem"

    echo "Assembling: $test_name"

    awk -f "$ASSEMBLER" \
        "$asm_file" \
        > "$mem_file"

done < "$TEST_LIST"

echo
echo "Assembly completed successfully."
echo