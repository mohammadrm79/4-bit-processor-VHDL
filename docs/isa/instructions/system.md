# System Instructions

| Instruction | Opcode | Behavior |
|---|---|---|
| NOP | 10000 | No asserted execute/write-back action; fetch has already incremented PC. |
| HALT | 10001 | From execute, next state becomes `STATE_HALTED`. |

`halted` is low in all states except `STATE_HALTED`. In the halted state, no PC/IR/register/memory/flag enable is asserted; reset returns the FSM to `STATE_RESET`.

Unallocated opcodes are not system instructions in a semantic sense, but `opcode_to_format` returns S-type for them. They are not trapped.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Documented reset and unallocated-opcode behavior. |
| 1.0.0 | Initial system instruction specification. |
