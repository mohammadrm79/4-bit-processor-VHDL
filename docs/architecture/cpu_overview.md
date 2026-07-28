# CPU Architecture Overview

`system_top` instantiates `cpu_core`. Its public outputs are `halted` and debug copies of R0–R3.

## Integrated components

```text
PC → instruction_memory → instruction_register → instruction_decoder
                                              ↓
register_file → ALU → alu_result_register → write-back selection → register_file
                    ↓
               flags_register

register_file operands → data_memory
control_fsm → enables, ALU operation, write-back source, halt output
```

The PC supplies instruction-memory addresses. The instruction register loads during `FETCH`; the PC increments on the same fetch edge. “Write-back selection” is a process in `cpu_core`, not an instantiation of the generic `mux` entity.

## Architectural state

- PC: 11-bit synchronous register.
- IR: 16-bit synchronous register.
- Register file: eight 4-bit registers, two combinational read ports, one synchronous write port.
- ALU result register: captures results for ALU write-back.
- Flags register: captures Z, C, N, V; only Z and C are connected to control.
- Data memory: 256 × 4 bits.

## Not Implemented

There is no entity named `cpu_top`, `control_unit`, or `status_register`; those historical names are not current RTL. There is no external memory interface or pipeline.

## Revision history

| Version | Description |
|---|---|
| 1.2.0 | Clarified that write-back selection is not the `mux` entity. |
| 1.1.0 | Aligned names and connections with `system_top` and `cpu_core`. |
| 1.0.0 | Initial CPU overview. |
