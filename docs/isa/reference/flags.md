# Processor Status Flags

`flags_register` stores four one-bit values: Z (zero), C (carry), N (negative), and V (overflow). It is synchronously reset to zero. The core connects only Z and C to `control_fsm`; N and V are stored but not used for control.

## ALU outputs

| Flag | Implementation |
|---|---|
| Z | Set when the 4-bit ALU result equals `0000`. |
| N | Result bit 3. |
| C | Bit 4 of the ALU’s 5-bit temporary result. |
| V | Computed only for ADD and SUB; otherwise defaults to 0. |

For every ALU instruction (`ADD` through `SHR`), the FSM enables flag capture in execute. `MOVI`, `LOAD`, `STORE`, `NOP`, `HALT`, and all control opcodes do not enable flag capture.

The code does not implement a separate documented “no borrow” convention for subtraction; C is exactly the temporary result’s high bit.

## Not Implemented

`CMP`, `JNZ`, direct software access to flags, and N/V conditional branches are not implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Updated flag write rules and subtraction semantics. |
| 1.0.0 | Initial flags specification. |
