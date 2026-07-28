#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "Cleaning RISC-4 build artifacts..."

rm -rf "$PROJECT_ROOT/build"


echo "Clean completed."