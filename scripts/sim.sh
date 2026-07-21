#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
LOG_DIR="$BUILD_DIR/logs"
WORK_DIR="$BUILD_DIR/sim"
WAVE_DIR="$BUILD_DIR/waves"

mkdir -p "$BUILD_DIR" "$LOG_DIR" "$WORK_DIR" "$WAVE_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$LOG_DIR/sim_${TIMESTAMP}.log"
: > "$LOG_FILE"

log() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

run_logged() {
    local label="$1"
    shift

    log "$label"
    "$@" 2>&1 | awk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0; fflush(); }' | tee -a "$LOG_FILE"
}

cd "$PROJECT_ROOT"

log "======================================"
log "RISC-4 Simulation"
log "======================================"
log "Log file: $LOG_FILE"
log "Wave GHW: $WAVE_DIR/cpu.ghw"
log "Wave VCD: $WAVE_DIR/cpu.vcd"

log "Cleaning previous simulation..."
find "$WORK_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true
find "$WAVE_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true

run_logged "Analyzing package..." \
    ghdl -a --std=08 --workdir="$WORK_DIR" "$PROJECT_ROOT/src/pkg/cpu_pkg.vhdl"

log "Analyzing common modules..."
for file in "$PROJECT_ROOT"/src/rtl/common/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing datapath modules..."
for file in "$PROJECT_ROOT"/src/rtl/datapath/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing memory modules..."
for file in "$PROJECT_ROOT"/src/rtl/memory/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing control modules..."
CONTROL_FILES=(
    "$PROJECT_ROOT/src/rtl/control/control_fsm.vhdl"
    "$PROJECT_ROOT/src/rtl/control/instruction_decoder.vhdl"
    "$PROJECT_ROOT/src/rtl/control/cpu_core.vhdl"
)

for file in "${CONTROL_FILES[@]}"; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

run_logged "Analyzing top module..." \
    ghdl -a --std=08 --workdir="$WORK_DIR" "$PROJECT_ROOT/src/top/system_top.vhdl"

run_logged "Analyzing CPU testbench..." \
    ghdl -a --std=08 --workdir="$WORK_DIR" "$PROJECT_ROOT/tb/integration/tb_cpu.vhdl"

run_logged "Elaborating testbench..." \
    ghdl -e --std=08 --workdir="$WORK_DIR" tb_cpu

log "Running simulation..."
ghdl -r \
    --std=08 \
    --workdir="$WORK_DIR" \
    tb_cpu \
    --wave="$WAVE_DIR/cpu.ghw" \
    --vcd="$WAVE_DIR/cpu.vcd" \
    --stop-time=1us \
    2>&1 | awk '{ print strftime("[%Y-%m-%d %H:%M:%S]"), $0; fflush(); }' | tee -a "$LOG_FILE"

log "======================================"
log "Simulation completed."
log "Log file: $LOG_FILE"
log "Waveform GHW: $WAVE_DIR/cpu.ghw"
log "Waveform VCD: $WAVE_DIR/cpu.vcd"
log "======================================"