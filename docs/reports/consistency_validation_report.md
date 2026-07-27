# Documentation Consistency Validation Report

> **Validation date:** 2026-07-27
>
> **Authority:** Current VHDL source and repository paths
>
> **Result:** Passed after documentation corrections

## Scope and method

The validation compared the Markdown documentation with `src/pkg/cpu_pkg.vhdl`, all VHDL entity declarations, `control_fsm` ports, repository paths, and the commands/outputs written in `scripts/sim.sh`. Relative Markdown links were resolved from their containing files.

## Results

| Check | Result | Evidence |
|---|---|---|
| Documented opcode allocation | Pass | All 18 documented values match `OP_ADD` through `OP_HALT` in `cpu_pkg`. |
| Documented implemented instructions | Pass | ADD, SUB, INC, DEC, AND, OR, XOR, NOT, SHL, SHR, LOAD, STORE, MOVI, JMP, JZ, JC, NOP, and HALT exist. |
| Not-implemented instructions | Pass | CMP and JNZ are explicitly marked Not Implemented. |
| Registers | Pass | R0–R7 match the 3-bit, eight-register file. |
| CPU states | Pass | STATE_RESET, FETCH, DECODE, EXECUTE, WRITE_BACK, and STATE_HALTED match `cpu_state_t`. |
| ALU operations | Pass | ADD, SUB, INC, DEC, AND, OR, XOR, NOT, SHL, SHR, and pass-through behavior match `alu_operation_t` and `alu`. |
| Control signals | Pass | Documented PC, IR, register, flags, memory, ALU-result, write-back, and halt controls correspond to `control_fsm` ports. |
| Package name | Pass | `cpu_pkg` matches the VHDL package. |
| Entity names | Pass | Documented integrated entities match declarations: `system_top`, `cpu_core`, `control_fsm`, `instruction_decoder`, `pc`, `instruction_memory`, `instruction_register`, `register_file`, `alu`, `alu_result_register`, `flags_register`, and `data_memory`. |
| File and directory references | Pass | All relative Markdown links resolve. References to nonexistent synthesis paths are explicitly documented as script defects, not as existing files. |
| Simulation script and waveform paths | Pass with limitation | `scripts/sim.sh`, `build/waves/cpu.ghw`, and `build/waves/cpu.vcd` match the script. The script does not complete because `src/rtl/common/mux.vhdl` has a GHDL syntax error. |
| Script names | Pass | `clean.sh`, `lint.sh`, `sim.sh`, and `synth.sh` exist under `scripts/`. |

## Corrections made during validation

- Clarified that write-back selection is a `cpu_core` process, not an instantiation of `mux`.
- Corrected the R-type datapath text to distinguish binary operations from operations that use source A only.
- Corrected simulation/verification status: the configured flow fails while analyzing `src/rtl/common/mux.vhdl`, before `tb_cpu` is elaborated.

## Known implementation limitations retained in the documentation

- `JMP`, `JZ`, and `JC` decode and assert PC load but do not redirect the PC because execute does not assert PC enable.
- Data-memory addressing is derived from source-B register data, not the I-type immediate.
- The current simulation and lint flows are blocked by the existing mux syntax error.
- The current synthesis script has an invalid mux path and omits `alu_result_register.vhdl`.

## Revision history

| Version | Description |
|---|---|
| 1.0.0 | Initial source-to-documentation consistency validation. |
