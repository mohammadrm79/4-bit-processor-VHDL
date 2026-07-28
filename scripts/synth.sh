#!/usr/bin/env bash
set -euo pipefail

TOP="system_top"

NO_TIMESTAMP=false
NO_FILE_NAME=false
BASE_NAME_ONLY=false
SKIP_LINT=false

while [[ $# -gt 0 ]]; do

    case "$1" in

        --top)
            TOP="$2"
            shift
            ;;

        --skip-lint)
            SKIP_LINT=true
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
WORK_DIR="$BUILD_DIR/sim"
SYNTH_DIR="$BUILD_DIR/synth"
LOG_DIR="$BUILD_DIR/logs"

mkdir -p \
    "$WORK_DIR" \
    "$SYNTH_DIR" \
    "$LOG_DIR"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

LOG_FILE="$LOG_DIR/synth_${TIMESTAMP}.log"

: > "$LOG_FILE"

# --------------------------------------------------
# Colors
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
        printf '[%s] %s\n' \
            "$(date '+%Y-%m-%d %H:%M:%S')" \
            "$line"
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
log "RISC-4 Synthesis"
log "======================================"
log "Log file: $LOG_FILE"
log "Output directory: $SYNTH_DIR"
# --------------------------------------------------
# Lint
# --------------------------------------------------

if ! $SKIP_LINT; then

    LINT_ARGS=()

    $NO_TIMESTAMP   && LINT_ARGS+=(--no-time-stamp)
    $NO_FILE_NAME   && LINT_ARGS+=(--no-file-name)
    $BASE_NAME_ONLY && LINT_ARGS+=(--base-name-only)

    LINT_ARGS+=(--skip-clean)

    "$PROJECT_ROOT/scripts/lint.sh" "${LINT_ARGS[@]}"

fi

# --------------------------------------------------
# Clean previous synthesis output
# --------------------------------------------------

find "$SYNTH_DIR" \
    -mindepth 1 \
    -maxdepth 1 \
    -exec rm -rf {} + \
    2>/dev/null || true

# --------------------------------------------------
# Output Files
# --------------------------------------------------

VHDL_NETLIST="$SYNTH_DIR/${TOP}.vhdl"
RAW_VHDL_NETLIST="$SYNTH_DIR/${TOP}_raw.vhdl"
RAW_VHDL_IEEE_NETLIST="$SYNTH_DIR/${TOP}_raw_ieee.vhdl"
VERILOG_NETLIST="$SYNTH_DIR/${TOP}.v"
DOT_GRAPH="$SYNTH_DIR/${TOP}.dot"

REPORT_FILE="$SYNTH_DIR/report.txt"

# --------------------------------------------------
# Common Source List
# --------------------------------------------------

SRC_FILES=(
    src/pkg/cpu_pkg.vhdl

    src/rtl/datapath/alu.vhdl
    src/rtl/datapath/alu_result_register.vhdl
    src/rtl/datapath/flags_register.vhdl
    src/rtl/datapath/instruction_register.vhdl
    src/rtl/datapath/pc.vhdl
    src/rtl/datapath/register_file.vhdl

    src/rtl/memory/data_memory.vhdl
    src/rtl/memory/instruction_memory.vhdl

    src/rtl/control/control_fsm.vhdl
    src/rtl/control/instruction_decoder.vhdl
    src/rtl/control/cpu_core.vhdl

    src/top/system_top.vhdl
)

# --------------------------------------------------
# Run synthesis check
# --------------------------------------------------

log "$(color green "Running GHDL synthesis check...")"

run_logged \
    "$(color magenta "Checking synthesizability")" \
    ghdl --synth \
        --std=08 \
        --out=none \
        "${SRC_FILES[@]}" \
        -e "$TOP"

# --------------------------------------------------
# Generate synthesized VHDL
# --------------------------------------------------

log "$(color green "Generating VHDL netlist...")"

ghdl --synth \
    --std=08 \
    "${SRC_FILES[@]}" \
    -e "$TOP" \
    > "$VHDL_NETLIST"

# --------------------------------------------------
# Generate raw VHDL
# --------------------------------------------------

log "$(color green "Generating raw VHDL netlist...")"

ghdl --synth \
    --std=08 \
    --out=raw-vhdl \
    "${SRC_FILES[@]}" \
    -e "$TOP" \
    > "$RAW_VHDL_NETLIST"


# --------------------------------------------------
# Generate Verilog
# --------------------------------------------------

log "$(color green "Generating Verilog netlist...")"

ghdl --synth \
    --std=08 \
    --out=verilog \
    "${SRC_FILES[@]}" \
    -e "$TOP" \
    > "$VERILOG_NETLIST"

# --------------------------------------------------
# Generate Graphviz
# --------------------------------------------------

log "$(color green "Generating Graphviz netlist...")"

ghdl --synth \
    --std=08 \
    --out=dot \
    "${SRC_FILES[@]}" \
    -e "$TOP" \
    > "$DOT_GRAPH"

# --------------------------------------------------
# Report
# --------------------------------------------------

{
    echo "======================================"
    echo "RISC-4 Synthesis Report"
    echo "======================================"
    echo
    echo "Top Module : $TOP"
    echo
    echo "Generated Files"
    echo "---------------"
    echo "Synthesized VHDL      : $VHDL_NETLIST"
    echo "Raw VHDL             : $RAW_VHDL_NETLIST"
    echo "Verilog              : $VERILOG_NETLIST"
    echo "Graphviz             : $DOT_GRAPH"
    echo
    echo "Generated : $(date)"
} > "$REPORT_FILE"


# --------------------------------------------------
# Optimize Verilog with Yosys
# --------------------------------------------------

YOSYS_LOG="$SYNTH_DIR/yosys.log"

RTLIL_NETLIST="$SYNTH_DIR/${TOP}.il"
JSON_NETLIST="$SYNTH_DIR/${TOP}.json"
BLIF_NETLIST="$SYNTH_DIR/${TOP}.blif"
EDIF_NETLIST="$SYNTH_DIR/${TOP}.edif"

VERILOG_OPT_NETLIST="$SYNTH_DIR/${TOP}_opt.v"
log "$(color green "Optimizing Verilog with Yosys...")"

cat > "$SYNTH_DIR/synth.ys" <<EOF
read_verilog -sv $VERILOG_NETLIST

hierarchy -check -top $TOP
proc
opt
fsm
opt
memory
opt
techmap
opt
setundef -zero
clean
stat
write_rtlil   $RTLIL_NETLIST
write_json    $JSON_NETLIST
write_blif    $BLIF_NETLIST
write_edif    $EDIF_NETLIST
write_verilog $VERILOG_OPT_NETLIST
EOF







yosys \
    -Q \
    -q \
    -l "$YOSYS_LOG" \
    -s "$SYNTH_DIR/synth.ys"
# --------------------------------------------------
# Report
# --------------------------------------------------

{
    echo "======================================"
    echo "RISC-4 Synthesis Report"
    echo "======================================"
    echo
    echo "Top Module : $TOP"
    echo
    echo "Generated Files"
    echo "---------------"
    echo "Synthesized VHDL : $VHDL_NETLIST"
    echo "Raw VHDL         : $RAW_VHDL_NETLIST"
    echo "Verilog          : $VERILOG_NETLIST"
    echo "Graphviz         : $DOT_GRAPH"
    echo
    echo "Optimized Outputs"
    echo "-----------------"
    echo "ILANG            : $RTLIL_NETLIST"
    echo "JSON             : $JSON_NETLIST"
    echo "BLIF             : $BLIF_NETLIST"
    echo "EDIF             : $EDIF_NETLIST"
    echo "Yosys Log        : $YOSYS_LOG"
    echo
    echo "Generated : $(date)"
} > "$REPORT_FILE"
