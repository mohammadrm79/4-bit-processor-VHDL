# Simulation Report

## Configured flow

`scripts/sim.sh` is written to create `build/logs`, `build/sim`, and `build/waves`; analyse the package, common RTL, datapath RTL, memory RTL, ordered control RTL, top-level RTL, and `tb/integration/tb_cpu.vhdl`; elaborate `tb_cpu`; then run it for up to `1us` with GHDL VHDL-2008 mode.

It writes `build/waves/cpu.ghw`, `build/waves/cpu.vcd`, and a timestamped simulation log. Supported options are `--report-only`, `--no-time-stamp`, and `--no-file-name`.

## Current execution status

The configured simulation flow does not currently reach `tb_cpu`: it analyses `src/rtl/common/mux.vhdl` first, and GHDL reports a missing semicolon at that file’s `output_o <= '0'` statement. This report records the script’s intended commands and does not claim a successful run.

## Scope

The script does not analyse or run unit testbenches. It does not select `program_logic.mem` or `program_jump.mem`; `cpu_core` instantiates instruction memory without overriding its default `program_add.mem` path.

## Current expected integration behavior

The default image computes R3=13 before HALT. `tb_cpu` asserts R3=8, so its ADD verification is inconsistent with the image and implementation.

## Not Implemented

There is no documented passing simulation baseline, test selector, timeout assertion in `tb_cpu`, assembler, or automatic unit-test simulation flow.

## Revision history

| Version | Description |
|---|---|
| 1.2.0 | Recorded the common-RTL syntax failure that prevents the configured run. |
| 1.1.0 | Documented actual script scope and integration mismatch. |
