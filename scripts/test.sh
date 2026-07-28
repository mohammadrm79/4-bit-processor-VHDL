#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

TEST_LIST="$PROJECT_ROOT/tb/programs/tests.lst"
BIN_DIR="$PROJECT_ROOT/tb/programs/bin"
EXP_DIR="$PROJECT_ROOT/tb/programs/exp"
TMP_DIR="$PROJECT_ROOT/tb/programs/out"

mkdir -p "$TMP_DIR"

PASS=0
FAIL=0
ERROR=0
TOTAL=0

echo "======================================"
echo "RISC-4 Test Runner"
echo "======================================"

#
# Check required files
#

if [[ ! -f "$TEST_LIST" ]]; then
    echo "ERROR: Test list not found:"
    echo "  $TEST_LIST"
    exit 1
fi

#
# Step 1 : Lint
#

echo
echo "[1/3] Running lint..."
echo

"$PROJECT_ROOT/scripts/lint.sh" \
    --no-time-stamp \
    --no-file-name \
    --base-name-only

#
# Step 2 : Assemble programs
#

echo
echo "[2/3] Running assembler..."
echo

"$PROJECT_ROOT/scripts/assembler.sh"

#
# Step 3 : Execute tests
#

echo
echo "[3/3] Running tests..."
echo

while IFS= read -r test || [[ -n "$test" ]]; do

    #
    # Ignore blank lines and comments
    #

    [[ -z "$test" ]] && continue
    [[ "$test" =~ ^# ]] && continue

    TOTAL=$((TOTAL + 1))

    MEM_FILE="$BIN_DIR/$test.mem"
    EXP_FILE="$EXP_DIR/$test.exp"
    OUT_FILE="$TMP_DIR/$test.out"

    #
    # Required files
    #

    if [[ ! -f "$MEM_FILE" ]]; then

        printf "[ERROR] %-20s Missing %s\n" "$test" "$MEM_FILE"

        ERROR=$((ERROR + 1))

        continue

    fi

    if [[ ! -f "$EXP_FILE" ]]; then

        printf "[ERROR] %-20s Missing %s\n" "$test" "$EXP_FILE"

        ERROR=$((ERROR + 1))

        continue

    fi

    #
    # Run simulation
    #

    "$PROJECT_ROOT/scripts/sim.sh" \
        --tb tb_cpu \
        --program-file "$MEM_FILE" \
        --no-time-stamp \
        --no-file-name \
        --base-name-only \
        --bulk-test \
        --skip-lint \
        > "$OUT_FILE"

    #
    # Compare
    #

    if diff -u -B -Z "$EXP_FILE" "$OUT_FILE" >/dev/null; then

        printf "[PASS ] %-20s\n" "$test"

        PASS=$((PASS + 1))

    else

        printf "[FAIL ] %-20s\n" "$test"

        echo

        diff -u -B -Z "$EXP_FILE" "$OUT_FILE" || true

        echo

        FAIL=$((FAIL + 1))

    fi

done < "$TEST_LIST"

echo
echo "======================================"
echo "Test Summary"
echo "======================================"

printf "Passed : %d\n" "$PASS"
printf "Failed : %d\n" "$FAIL"
printf "Errors : %d\n" "$ERROR"
printf "Total  : %d\n" "$TOTAL"

echo "======================================"

#
# Exit status
#

if [[ $FAIL -ne 0 || $ERROR -ne 0 ]]; then
    exit 1
fi

exit 0