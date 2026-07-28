#!/usr/bin/env bash
set -euo pipefail

PROGRAM_FILE=""
REPORT_ONLY=false
NO_TIMESTAMP=false
NO_FILE_NAME=false
BASE_NAME_ONLY=false
BULK_TEST=false
SKIP_LINT=false

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
        --base-name-only)
            BASE_NAME_ONLY=true
            ;;
        --bulk-test)
            BULK_TEST=true
            ;;
        --skip-lint)
            SKIP_LINT=true
            ;;
        --tb)
            TB_NAME="$2"
            shift
            ;;
        --program-file)
            PROGRAM_FILE="$2"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

PROJECT_ROOT="$(cd "$(dirname "$0")/.." &&pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
LOG_DIR="$BUILD_DIR/logs"
WORK_DIR="$BUILD_DIR/sim"
WAVE_DIR="$BUILD_DIR/waves"

mkdir -p "$BUILD_DIR" "$LOG_DIR" "$WORK_DIR" "$WAVE_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$LOG_DIR/sim_${TIMESTAMP}.log"
: > "$LOG_FILE"

# --------------------------------------------------
# Style Helpers
# --------------------------------------------------

color() {

    case "$1" in
        black) code=30 ;;
        red) code=31 ;;
        green) code=32 ;;
        yellow) code=33 ;;
        blue) code=34 ;;
        magenta) code=35 ;;
        cyan) code=36 ;;
        white) code=37 ;;
        bold) code=1 ;;
        *) code=0 ;;
    esac

    shift

    printf "\033[%sm%s\033[0m" "$code" "$*"
}

basename_only() {

    local path="$1"

    if $BASE_NAME_ONLY; then
        echo "${path##*/}"
    else
        echo "$path"
    fi
}

print_line() {

    local line="$1"

    if $BULK_TEST; then

        case "$line" in
            *"HALTED="*|\
            *"PC="*|\
            *"REG["*|\
            *"FLAG["*)

                line="${line#*: }"
                echo "$line"
                return
                ;;

            *)
                return
                ;;
        esac
    fi

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

find "$WAVE_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true

if ! $SKIP_LINT; then

    LINT_ARGS=()

    $NO_TIMESTAMP   && LINT_ARGS+=(--no-time-stamp)
    $NO_FILE_NAME   && LINT_ARGS+=(--no-file-name)
    $BASE_NAME_ONLY && LINT_ARGS+=(--base-name-only)
    LINT_ARGS+=(--skip-clean)

    "${PROJECT_ROOT}/scripts/lint.sh" "${LINT_ARGS[@]}"

fi

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
    tb_flags_register)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_flags_register.vhdl"
        ;;
    tb_instruction_register)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_instruction_register.vhdl"
        ;;
    tb_pc)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_pc.vhdl"
        ;;
    tb_alu_result_register)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_alu_result_register.vhdl"
        ;;
    tb_instruction_decoder)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_instruction_decoder.vhdl"
        ;;
    tb_control_fsm)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_control_fsm.vhdl"
        ;;
    tb_data_memory)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_data_memory.vhdl"
        ;;
    tb_instruction_memory)
        TB_FILE="$PROJECT_ROOT/tb/unit/tb_instruction_memory.vhdl"
        ;;
    *)
        echo "Unknown testbench: $TB_NAME"
        exit 1
        ;;
esac

SIM_ARGS=()

if [[ "$TB_NAME" == "tb_cpu" && -n "$PROGRAM_FILE" ]]; then
    SIM_ARGS+=("-gPROGRAM_FILE=$PROGRAM_FILE")
fi


# --------------------------------------------------
# Analyze Testbench
# --------------------------------------------------

run_logged "$(color magenta "Analyzing testbench...")" \
    ghdl -a \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$TB_FILE"

# --------------------------------------------------
# Elaborate
# --------------------------------------------------

run_logged "$(color magenta "Elaborating testbench...")" \
    ghdl -e \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$TB_NAME"

if ! $REPORT_ONLY; then
    log "Running simulation..."
fi
# --------------------------------------------------
# Run Simulation
# --------------------------------------------------

ghdl -r \
    --std=08 \
    --workdir="$WORK_DIR" \
    "$TB_NAME" \
    "${SIM_ARGS[@]}" \
    --wave="$WAVE_DIR/${TB_NAME}.ghw" \
    --vcd="$WAVE_DIR/${TB_NAME}.vcd" \
    --stop-time=1us \
    --backtrace-severity=warning \
2>&1 | while IFS= read -r line; do

    if $REPORT_ONLY; then
        [[ "$line" =~ report\ note|report\ warning|report\ error|assertion\ note|assertion\ warning|assertion\ error ]] || continue
    fi

    print_line "$line"

done | tee -a "$LOG_FILE"

# --------------------------------------------------
# Finish
# --------------------------------------------------

if ! $REPORT_ONLY; then

    log "======================================"
    log "Simulation completed."
    log "Log file: $LOG_FILE"
    log "Waveform GHW: $WAVE_DIR/${TB_NAME}.ghw"
    log "Waveform VCD: $WAVE_DIR/${TB_NAME}.vcd"
    log "======================================"

fi