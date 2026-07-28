# Control Unit Architecture

`control_fsm` receives clock, reset, opcode, Z flag, and C flag. It produces state, PC/IR enables, register and flags write enables, memory enable signals, ALU operation, write-back source, ALU-result-register enable, and `halted`.

## States

| State | Behavior |
|---|---|
| `STATE_RESET` | No asserted operational enables; next state is `FETCH`. |
| `FETCH` | IR enable and PC enable asserted. |
| `DECODE` | No asserted operational enables. |
| `EXECUTE` | Opcode-specific ALU, flag, memory-write, or PC-load control. |
| `WRITE_BACK` | Writes ALU, immediate, or memory value for applicable instructions. |
| `STATE_HALTED` | Asserts `halted`; remains halted. |

`HALT` enters `STATE_HALTED` directly from `EXECUTE`. `NOP` and reserved opcodes perform no operation in execute/write-back and continue through the normal state sequence.

## Control flow

`JMP` asserts both `pc_enable` and `pc_load` in `EXECUTE`. `JZ` does the same when `zero_flag='1'`, and `JC` when `carry_flag='1'`. Because `pc` requires both signals to load `next_address`, these instructions redirect the PC to the decoder's 11-bit `jump_address` on that execute edge. A conditional branch whose condition is false does not assert either signal; the PC has already advanced during fetch.

## Not Implemented

N/V branch inputs, `JNZ`, invalid-opcode trapping, memory read gating, and variable-latency memory control are not implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Updated state/control behavior and current jump limitation. |
| 1.0.0 | Initial control-unit description. |
