# RISC-4 Educational CPU

This repository contains the current VHDL implementation of a small 4-bit, multi-cycle CPU. The VHDL implementation is the authoritative description of the processor.

## Implemented configuration

| Property | Implementation |
|---|---|
| Data width | 4 bits |
| Instruction width | 16 bits |
| Registers | Eight 4-bit general-purpose registers (R0–R7) |
| Opcode width | 5 bits |
| PC/address width | 11 bits |
| Memory | Separate instruction and data memories |
| Reset | Synchronous, active high |

The implemented ISA and its current limitations are documented in [docs/isa/README.md](docs/isa/README.md). Architecture, simulation, and verification status are in [docs/README.md](docs/README.md).

## Repository layout

```text
src/pkg/       Shared types and opcode definitions
src/rtl/       RTL grouped by common, control, datapath, and memory functions
src/top/       `system_top` integration entity
tb/unit/       Unit testbench sources
tb/integration/ Integration testbench source
tb/programs/   Hexadecimal instruction-memory images
scripts/       Lint, simulation, synthesis, and clean scripts
docs/          Implementation-aligned documentation
```

## Build status

The repository includes shell scripts, but the top-level Makefile contains command text rather than Make targets. See [simulation documentation](docs/reports/simulation_report.md) and [synthesis documentation](docs/reports/synthesis_report.md) before relying on those flows.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Documentation aligned with the current VHDL implementation. |
| 1.0.0 | Initial repository documentation. |
