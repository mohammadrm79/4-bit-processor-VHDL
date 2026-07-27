#!/usr/bin/env bash
set -euo pipefail

REPORT_ONLY=false
NO_TIMESTAMP=false
NO_FILE_NAME=false
TB_NAME="tb_cpu"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --report-only)
            REPORT_ONLY=true
            ;;
        --no-time-stamp)
            NO_TIMESTAMP=true
            ;;
        --no-file-name)
            NO_FILE_NAME=true
            ;;
        --tb)
            TB_NAME="$2"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
LOG_DIR="$BUILD_DIR/logs"
WORK_DIR="$BUILD_DIR/sim"
WAVE_DIR="$BUILD_DIR/waves"

mkdir -p "$BUILD_DIR" "$LOG_DIR" "$WORK_DIR" "$WAVE_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$LOG_DIR/sim_${TIMESTAMP}.log"
: > "$LOG_FILE"

print_line() {

    local line="$1"

    if $NO_FILE_NAME; then
        case "$line" in
            *"(report "*|*"(assertion "*)
                line="(${line#*\(}"
                ;;
        esac
    fi

    if $NO_TIMESTAMP; then
        echo "$line"
    else
        printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$line"
    fi
}

log() {

    if $REPORT_ONLY; then
        return
    fi

    print_line "$1" | tee -a "$LOG_FILE"
}

run_logged() {

    local label="$1"
    shift

    if ! $REPORT_ONLY; then
        log "$label"
    fi

    "$@" 2>&1 | while IFS= read -r line; do

        if $REPORT_ONLY; then
            [[ "$line" =~ report\ note|report\ warning|report\ error|assertion\ note|assertion\ warning|assertion\ error ]] || continue
        fi

        print_line "$line"

    done | tee -a "$LOG_FILE"
}

cd "$PROJECT_ROOT"

log "======================================"
log "RISC-4 Simulation"
log "======================================"
log "Log file: $LOG_FILE"
log "Wave GHW: $WAVE_DIR/${TB_NAME}.ghw"
log "Wave VCD: $WAVE_DIR/${TB_NAME}.vcd"

find "$WORK_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true
find "$WAVE_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true

run_logged "Analyzing package..." \
    ghdl -a --std=08 --workdir="$WORK_DIR" \
    "$PROJECT_ROOT/src/pkg/cpu_pkg.vhdl"

log "Analyzing common modules..."

for file in "$PROJECT_ROOT"/src/rtl/common/*.vhdl; do
    run_logged "Checking: $file" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing datapath modules..."

for file in "$PROJECT_ROOT"/src/rtl/datapath/*.vhdl; do
    run_logged "Checking: $file" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing memory modules..."

for file in "$PROJECT_ROOT"/src/rtl/memory/*.vhdl; do
    run_logged "Checking: $file" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "Analyzing control modules..."

CONTROL_FILES=(
    "$PROJECT_ROOT/src/rtl/control/control_fsm.vhdl"
    "$PROJECT_ROOT/src/rtl/control/instruction_decoder.vhdl"
    "$PROJECT_ROOT/src/rtl/control/cpu_core.vhdl"
)

for file in "${CONTROL_FILES[@]}"; do
    run_logged "Checking: $file" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

run_logged "Analyzing top module..." \
    ghdl -a --std=08 --workdir="$WORK_DIR" \
    "$PROJECT_ROOT/src/top/system_top.vhdl"

TB_FILE=""

case "$TB_NAME" in
    tb_cpu)
        TB_FILE="$PROJECT_ROOT/tb/integration/tb_cpu.vhdl"
        ;;
    tb_register_file)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_register_file.vhdl"
        ;;
    tb_alu)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_alu.vhdl"
        ;;
    *)
        echo "Unknown testbench: $TB_NAME"
        exit 1
        ;;
esac

run_logged "Analyzing testbench..." \
    ghdl -a --std=08 --workdir="$WORK_DIR" \
    "$TB_FILE"

run_logged "Elaborating testbench..." \
    ghdl -e --std=08 --workdir="$WORK_DIR" "$TB_NAME"

if ! $REPORT_ONLY; then
    log "Running simulation..."
fi

ghdl -r \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$TB_NAME" \
    --wave="$WAVE_DIR/${TB_NAME}.ghw" \
    --vcd="$WAVE_DIR/${TB_NAME}.vcd" \
    --stop-time=1us \
2>&1 | while IFS= read -r line; do

    if $REPORT_ONLY; then
        [[ "$line" =~ report\ note|report\ warning|report\ error|assertion\ note|assertion\ warning|assertion\ error ]] || continue
    fi

    print_line "$line"

done | tee -a "$LOG_FILE"

if ! $REPORT_ONLY; then
    log "======================================"
    log "Simulation completed."
    log "Log file: $LOG_FILE"
    log "Waveform GHW: $WAVE_DIR/${TB_NAME}.ghw"
    log "Waveform VCD: $WAVE_DIR/${TB_NAME}.vcd"
    log "======================================"
fi