# S-Type Instruction Format

`NOP` (`10000`) and `HALT` (`10001`) are system opcodes. `opcode_to_format` also classifies every unallocated opcode as S-type.

```text
15        11 10                     0
+------------+------------------------+
|   opcode   |      unused bits       |
+------------+------------------------+
```

The low eleven bits do not affect `NOP`, `HALT`, or unallocated opcode behavior.

`NOP` has no asserted execute or write-back action. `HALT` transitions from `EXECUTE` to `STATE_HALTED`; `halted='1'` is asserted only in that state.

Unallocated opcodes are not trapped or halted; they progress through execute/write-back without explicit actions.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Added actual unallocated-opcode behavior. |
| 1.0.0 | Initial S-type format specification. |
