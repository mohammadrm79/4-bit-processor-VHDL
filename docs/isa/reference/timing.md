# Instruction Timing Specification

Instruction timing is governed by `control_fsm`, not by a pipeline.

| Instruction kind | State sequence after reset state |
|---|---|
| ALU, memory, MOVI, NOP, reserved opcode | FETCH → DECODE → EXECUTE → WRITE_BACK |
| HALT | FETCH → DECODE → EXECUTE → STATE_HALTED |

Fetch enables both IR capture and PC increment. ALU results and flags are captured in execute for ALU opcodes. Memory writes occur in execute. Register writes occur in write-back. The data-memory read path is combinational and is selected for `LOAD` write-back.

## Not Implemented

The design has no memory wait states, stalls, branching delay behavior, or functional PC redirection for jump opcodes.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected HALT and jump timing. |
| 1.0.0 | Initial timing specification. |
