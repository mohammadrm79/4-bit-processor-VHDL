# I-Type Instruction Format

I-type opcodes are `LOAD`, `STORE`, and `MOVI`.

```text
15        11 10      8 7                       0
+------------+---------+-------------------------+
|   opcode   | register|        immediate        |
+------------+---------+-------------------------+
```

| Opcode | Register field | Immediate behavior |
|---|---|---|
| LOAD | `Rd[10:8]` | Not used for addressing in `cpu_core` |
| STORE | `[10:8]` is not used as the store-data register | Not used for addressing in `cpu_core` |
| MOVI | `Rd[10:8]` | Low four bits are written |

The decoder independently exposes `source_a=instruction[7:5]` and `source_b=instruction[4:2]`, even for I-type words. In the integrated core, `LOAD` reads `DMEM[source_b]`; `STORE` writes `source_a` to `DMEM[source_b]`. This is the actual behavior and supersedes direct-immediate-address descriptions.

`MOVI` writes `instruction[3:0]` to the register selected by `[10:8]`; it does not update flags.

## Not Implemented

Direct immediate memory addressing, immediate sign extension, and an immediate-to-ALU operand path are not implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected I-type memory and immediate behavior. |
| 1.0.0 | Initial I-type format specification. |
