# Synthesis Report

## Configured script

`scripts/synth.sh` invokes `ghdl --synth` and then Yosys, intending to produce `build/system_top.vhdl` and `build/system_top.json`.

## Current limitations

No successful synthesis result is documented. The script references `src/rtl/datapath/mux.vhdl`, but the mux source is located at `src/rtl/common/mux.vhdl`. It also omits `src/rtl/datapath/alu_result_register.vhdl`, which is instantiated by `cpu_core`.

In addition, `instruction_memory` uses file I/O (`textio` and `hread`) to initialize a program model. This documentation does not claim that this construct or the current instruction-memory configuration is synthesizable by the configured tools.

## Not Implemented

Validated synthesis, resource utilization, timing closure, a target technology, and an FPGA bitstream are not implemented or reported.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Replaced empty report with current flow limitations. |
