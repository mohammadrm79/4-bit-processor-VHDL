#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "======================================"
echo "RISC-4 VHDL Lint"
echo "======================================"



WORK_DIR="$PROJECT_ROOT/work"


rm -rf "$WORK_DIR"

mkdir -p "$WORK_DIR"


cd "$PROJECT_ROOT"



# ============================================================
# Package Files
# ============================================================

echo "Analyzing package files..."


for file in src/pkg/*.vhdl
do
    echo "Checking: $file"

    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"

done



# ============================================================
# RTL Common
# ============================================================

echo "Analyzing common RTL files..."


for file in src/rtl/common/*.vhdl
do
    echo "Checking: $file"

    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"

done



# ============================================================
# RTL Datapath
# ============================================================

echo "Analyzing datapath RTL files..."


for file in src/rtl/datapath/*.vhdl
do
    echo "Checking: $file"

    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"

done



# ============================================================
# RTL Memory
# ============================================================

echo "Analyzing memory RTL files..."


for file in src/rtl/memory/*.vhdl
do
    echo "Checking: $file"

    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"

done



# ============================================================
# RTL Control
# ============================================================

echo "Analyzing control RTL files..."


# Control dependencies first

CONTROL_FILES=(
    src/rtl/control/control_fsm.vhdl
    src/rtl/control/instruction_decoder.vhdl
    src/rtl/control/cpu_core.vhdl
)


for file in "${CONTROL_FILES[@]}"
do

    echo "Checking: $file"

    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"

done



# ============================================================
# Top Level
# ============================================================

echo "Analyzing top files..."


for file in src/top/*.vhdl
do
    echo "Checking: $file"

    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"

done



echo "======================================"
echo "Lint completed successfully"
echo "======================================"