#!/usr/bin/env bash
set -euo pipefail

SKIP_CLEAN=false
NO_TIMESTAMP=false
NO_FILE_NAME=false
BASE_NAME_ONLY=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --skip-clean)
            SKIP_CLEAN=true
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

mkdir -p "$LOG_DIR" "$WORK_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$LOG_DIR/lint_${TIMESTAMP}.log"
: > "$LOG_FILE"

# --------------------------------------------------
# Style helpers
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

    print_line "$1" | tee -a "$LOG_FILE"
}

run_logged() {

    local label="$1"
    shift

    log "$label"

    "$@" 2>&1 | while IFS= read -r line; do
        print_line "$line"
    done | tee -a "$LOG_FILE"
}

cd "$PROJECT_ROOT"

log "======================================"
log "RISC-4 VHDL Lint"
log "======================================"
log "Log file: $LOG_FILE"

if ! $SKIP_CLEAN; then
    find "$WORK_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true
fi

run_logged "$(color blue "Analyzing package...")" \
    ghdl -a --std=08 --workdir="$WORK_DIR" \
    src/pkg/cpu_pkg.vhdl

log "$(color green "Analyzing datapath modules...")"

for file in src/rtl/datapath/*.vhdl; do
    run_logged "$(color blue Checking:) $(color yellow "$(basename_only "$file")")" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "$(color green "Analyzing memory modules...")"

for file in src/rtl/memory/*.vhdl; do
    run_logged "$(color blue Checking:) $(color yellow "$(basename_only "$file")")" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "$(color green "Analyzing control modules...")"

CONTROL_FILES=(
    src/rtl/control/control_fsm.vhdl
    src/rtl/control/instruction_decoder.vhdl
    src/rtl/control/cpu_core.vhdl
)

for file in "${CONTROL_FILES[@]}"; do
    run_logged "$(color blue Checking:) $(color yellow "$(basename_only "$file")")" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done
log "$(color green "Analyzing top modules...")"

for file in src/top/*.vhdl; do
    run_logged "$(color blue Checking:) $(color yellow "$(basename_only "$file")")" \
        ghdl -a --std=08 --workdir="$WORK_DIR" "$file"
done

log "======================================"
log "$(color green "Lint completed successfully")"
log "======================================"

exit 0