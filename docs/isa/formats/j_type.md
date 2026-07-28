# J-Type Instruction Format

J-type opcodes are `JMP`, `JZ`, and `JC`.

```text
15        11 10                     0
+------------+------------------------+
|   opcode   |        address         |
+------------+------------------------+
```

The decoder sends `instruction[10:0]` to the PC `next_address` port. During execute, the FSM asserts `pc_load` for `JMP`, for `JZ` when Z is set, and for `JC` when C is set.

## Execution

The PC component loads `next_address` when both `enable` and `load` are asserted. The FSM asserts both signals in execute for `JMP`, and for taken `JZ` and `JC`, so these instructions change the PC in the integrated CPU. A condition that is false leaves both signals low; sequential execution continues from the PC value established in fetch.

`JNZ` is **Not Implemented**.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Recorded implemented decode and nonfunctional PC load. |
| 1.0.0 | Initial J-type format specification. |
