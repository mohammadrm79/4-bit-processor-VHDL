# Timing Architecture

All stateful integrated components use the rising edge of one clock and a synchronous active-high reset.

## Normal instruction timing

After reset has released and the FSM leaves `STATE_RESET`, a non-HALT instruction uses these FSM states:

| Clocked state | Observable actions |
|---|---|
| `FETCH` | IR captures instruction at current PC; PC increments. |
| `DECODE` | Decoder and register reads are combinational. |
| `EXECUTE` | ALU results/flags may be captured; data-memory write may occur. |
| `WRITE_BACK` | Register file may capture result. |

`HALT` follows fetch, decode, and execute, then enters `STATE_HALTED` without a write-back state.

## Data timing

- Register reads and both memory reads are combinational.
- Register-file writes, data-memory writes, PC updates, IR updates, ALU-result updates, and flag updates are rising-edge operations.
- ALU flags are captured during `EXECUTE` for ALU opcodes, before the next instruction’s execution.

During `EXECUTE`, a taken `JMP`, `JZ`, or `JC` loads the PC target on the rising edge. The otherwise sequential PC increment happened in the preceding `FETCH` state; there is no delay slot.

## Not Implemented

No wait-state, stall, clock-gating, or pipeline timing is implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected HALT timing and integrated control-flow behavior. |
| 1.0.0 | Initial timing architecture description. |
