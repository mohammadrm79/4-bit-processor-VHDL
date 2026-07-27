# Project Roadmap

## Current completed repository content

- Package, datapath, memory, control, and top-level VHDL sources exist.
- Unit and integration testbench sources exist.
- Lint, simulation, synthesis, and clean scripts exist.
- ISA and architecture documentation is aligned with current RTL.

## Current limitations requiring resolution

- Integrated jumps do not load the PC because the PC load is not enabled.
- Memory instructions use register-derived addresses, not the documented immediate field.
- Several unit testbenches have interfaces that do not match their current DUT entities.
- The integration test expected result does not match `program_add.mem`.
- The Makefile has no targets; the synthesis script references a nonexistent mux path and omits `alu_result_register.vhdl`.
- Both lint and simulation scripts analyse `src/rtl/common/mux.vhdl`; its current syntax error prevents those configured flows from completing.

## Reserved for Future Version

The following are not implemented: `CMP`, `JNZ`, additional addressing modes, call/return, stack, interrupts, I/O, pipelines, FPGA deployment, coverage closure, and validated synthesis results.

## Revision history

| Version | Description |
|---|---|
| 1.2.0 | Added the configured-flow syntax limitation. |
| 1.1.0 | Replaced planning claims with current repository status. |
| 1.0.0 | Initial roadmap. |
