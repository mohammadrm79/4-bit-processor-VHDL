#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "Cleaning RISC-4 build artifacts..."

rm -rf "$PROJECT_ROOT/build"
rm -rf "$PROJECT_ROOT/work"
rm -rf "$PROJECT_ROOT/wave"
rm -rf "$PROJECT_ROOT/*.cf"
rm -rf "$PROJECT_ROOT/*.ghw"
rm -rf "$PROJECT_ROOT/*.vcd"

find "$PROJECT_ROOT" -name "*.o" -delete
find "$PROJECT_ROOT" -name "*.cf" -delete

echo "Clean completed."