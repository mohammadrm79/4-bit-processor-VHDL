# Control Flow Instructions

| Instruction | Opcode | FSM condition |
|---|---|---|
| JMP | 01101 | Loads the target in execute |
| JZ | 01110 | Loads the target when Z=1 |
| JC | 01111 | Loads the target when C=1 |

Each instruction decodes an 11-bit target from `instruction[10:0]`.

The FSM asserts `pc_enable` and `pc_load` together for each taken transfer. The `pc` entity therefore replaces the already incremented sequential PC with the 11-bit target at the execute edge. There is no delay slot.

`JNZ` is **Not Implemented**.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected allocation and documented PC-load limitation. |
| 1.0.0 | Initial control-flow instruction specification. |
