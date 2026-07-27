# Control Flow Instructions

| Instruction | Opcode | FSM condition |
|---|---|---|
| JMP | 01101 | Always asserts `pc_load` in execute |
| JZ | 01110 | Asserts `pc_load` when Z=1 |
| JC | 01111 | Asserts `pc_load` when C=1 |

Each instruction decodes an 11-bit target from `instruction[10:0]`.

## Not Functionally Implemented

None of the above changes the program counter in `cpu_core`: PC load is gated by PC enable, and the FSM only asserts PC enable during fetch. Sequential fetch increments continue instead.

`JNZ` is **Not Implemented**.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected allocation and documented PC-load limitation. |
| 1.0.0 | Initial control-flow instruction specification. |
