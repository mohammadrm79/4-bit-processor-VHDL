#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
LOG_DIR="$BUILD_DIR/logs"
WORK_DIR="$BUILD_DIR/sim"

mkdir -p "$LOG_DIR" "$WORK_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$LOG_DIR/lint_${TIMESTAMP}.log"
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
log "RISC-4 VHDL Lint"
log "======================================"
log "Log file: $LOG_FILE"

find "$WORK_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true

run_logged "Analyzing package files..." ghdl -a --std=08 --workdir="$WORK_DIR" src/pkg/cpu_pkg.vhdl

log "Analyzing common RTL files..."
for file in src/rtl/common/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing datapath RTL files..."
for file in src/rtl/datapath/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing memory RTL files..."
for file in src/rtl/memory/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing control RTL files..."
CONTROL_FILES=(
    src/rtl/control/control_fsm.vhdl
    src/rtl/control/instruction_decoder.vhdl
    src/rtl/control/cpu_core.vhdl
)

for file in "${CONTROL_FILES[@]}"; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing top files..."
for file in src/top/*.vhdl; do
    run_logged "Checking: $file" ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "======================================"
log "Lint completed successfully"
log "======================================"