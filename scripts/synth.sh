#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

BUILD_DIR="$PROJECT_ROOT/build"

mkdir -p "$BUILD_DIR"

echo "======================================"
echo "RISC-4 Synthesis"
echo "======================================"

echo "Running GHDL synthesis preparation..."

ghdl --synth \
--std=08 \
"$PROJECT_ROOT/src/pkg/cpu_pkg.vhdl" \
"$PROJECT_ROOT/src/rtl/common/register.vhdl" \
"$PROJECT_ROOT/src/rtl/common/counter.vhdl" \
"$PROJECT_ROOT/src/rtl/datapath/alu.vhdl" \
"$PROJECT_ROOT/src/rtl/datapath/flags_register.vhdl" \
"$PROJECT_ROOT/src/rtl/datapath/instruction_register.vhdl" \
"$PROJECT_ROOT/src/rtl/datapath/mux.vhdl" \
"$PROJECT_ROOT/src/rtl/datapath/pc.vhdl" \
"$PROJECT_ROOT/src/rtl/datapath/register_file.vhdl" \
"$PROJECT_ROOT/src/rtl/memory/data_memory.vhdl" \
"$PROJECT_ROOT/src/rtl/memory/instruction_memory.vhdl" \
"$PROJECT_ROOT/src/rtl/control/instruction_decoder.vhdl" \
"$PROJECT_ROOT/src/rtl/control/control_fsm.vhdl" \
"$PROJECT_ROOT/src/rtl/control/cpu_core.vhdl" \
"$PROJECT_ROOT/src/top/system_top.vhdl" \
-e system_top \
-o "$BUILD_DIR/system_top.vhdl"


echo "Running Yosys synthesis..."

yosys \
-p "
ghdl --std=08 $BUILD_DIR/system_top.vhdl -e system_top;
prep -top system_top;
write_json $BUILD_DIR/system_top.json;
"


echo "======================================"
echo "Synthesis completed."
echo "Output:"
echo "$BUILD_DIR/system_top.json"
echo "======================================"