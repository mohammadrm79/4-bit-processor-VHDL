#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

BUILD_DIR="$PROJECT_ROOT/build"
WORK_DIR="$PROJECT_ROOT/work"
WAVE_DIR="$PROJECT_ROOT/wave"

mkdir -p "$BUILD_DIR"
mkdir -p "$WORK_DIR"
mkdir -p "$WAVE_DIR"

echo "======================================"
echo "RISC-4 Simulation"
echo "======================================"

echo "Cleaning previous simulation..."
rm -rf "$WORK_DIR"/*
rm -f "$BUILD_DIR"/*.ghw

echo "Analyzing package..."

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/pkg/cpu_pkg.vhdl"


echo "Analyzing common modules..."

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/rtl/common/register.vhdl"

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/rtl/common/counter.vhdl"


echo "Analyzing datapath modules..."

for file in "$PROJECT_ROOT"/src/rtl/datapath/*.vhdl
do
    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"
done


echo "Analyzing memory modules..."

for file in "$PROJECT_ROOT"/src/rtl/memory/*.vhdl
do
    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$file"
done


echo "Analyzing control modules..."

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/rtl/control/instruction_decoder.vhdl"

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/rtl/control/control_fsm.vhdl"

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/rtl/control/cpu_core.vhdl"


echo "Analyzing top module..."

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/src/top/system_top.vhdl"


echo "Analyzing CPU testbench..."

ghdl -a \
--std=08 \
--workdir="$WORK_DIR" \
"$PROJECT_ROOT/tb/integration/tb_cpu.vhdl"


echo "Elaborating testbench..."

ghdl -e \
--std=08 \
--workdir="$WORK_DIR" \
tb_cpu


echo "Running simulation..."

ghdl -r \
--std=08 \
--workdir="$WORK_DIR" \
tb_cpu \
--wave="$WAVE_DIR/cpu.ghw" \
--stop-time=1us


echo "======================================"
echo "Simulation completed."
echo "Waveform:"
echo "$WAVE_DIR/cpu.ghw"
echo "======================================"