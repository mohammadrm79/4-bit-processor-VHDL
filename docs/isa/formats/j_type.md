# J-Type Instruction Format

J-type opcodes are `JMP`, `JZ`, and `JC`.

```text
15        11 10                     0
+------------+------------------------+
|   opcode   |        address         |
+------------+------------------------+
```

The decoder sends `instruction[10:0]` to the PC `next_address` port. During execute, the FSM asserts `pc_load` for `JMP`, for `JZ` when Z is set, and for `JC` when C is set.

## Not Functionally Implemented

The PC component only loads `next_address` when both `enable` and `load` are asserted. The FSM does not assert `pc_enable` in execute, so none of these instructions changes the PC in the integrated CPU.

`JNZ` is **Not Implemented**.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Recorded implemented decode and nonfunctional PC load. |
| 1.0.0 | Initial J-type format specification. |
