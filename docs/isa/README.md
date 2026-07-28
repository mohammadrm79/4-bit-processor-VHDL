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

- [Overview](overview.md) and [encoding](encoding.md)
- Formats: [R-type](formats/r_type.md), [I-type](formats/i_type.md), [J-type](formats/j_type.md), and [S-type](formats/s_type.md)
- Instructions: [arithmetic](instructions/arithmetic.md), [logic and shift](instructions/logic.md), [memory and immediate](instructions/memory.md), [control flow](instructions/control.md), and [system](instructions/system.md)
- Reference: [opcode allocation](reference/opcode_table.md), [registers](reference/registers.md), [flags](reference/flags.md), and [timing](reference/timing.md)
- [Program-image examples](examples.md)

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Rebased on current VHDL opcode allocation. |
| 1.0.0 | Initial ISA index. |
