# RISC-4 ISA Reference

This ISA reference describes opcode allocation and behavior implemented by the current VHDL. It does not define aspirational behavior.

## Implemented instructions

| Class | Instructions |
|---|---|
| Arithmetic | ADD, SUB, INC, DEC |
| Logic/shift | AND, OR, XOR, NOT, SHL, SHR |
| Memory/immediate | LOAD, STORE, MOVI |
| Control | JMP, JZ, JC |
| System | NOP, HALT |

`CMP` and `JNZ` are **Not Implemented**. Reserved opcodes have no explicit trap behavior and execute as no-ops through the FSM.

## Reference map

- [Encoding](encoding.md)
- [Opcode allocation](reference/opcode_table.md)
- [Flags](reference/flags.md)
- [Timing](reference/timing.md)
- [Examples](examples.md)

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Rebased on current VHDL opcode allocation. |
| 1.0.0 | Initial ISA index. |
