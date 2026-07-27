# R-Type Instruction Format

R-type opcodes are `ADD`, `SUB`, `INC`, `DEC`, `AND`, `OR`, `XOR`, `NOT`, `SHL`, and `SHR`.

```text
15        11 10      8 7       5 4       2 1     0
+------------+---------+---------+---------+-------+
|   opcode   |   Rd    |   Rs1   |   Rs2   | low2  |
+------------+---------+---------+---------+-------+
```

Binary operations use `Rs1` and `Rs2` and write `Rd`. `INC`, `DEC`, and `NOT` use `Rs1`; their decoded `Rs2` field does not affect the ALU result. `SHL` and `SHR` shift `Rs1` by one bit.

Bits `[1:0]` are not consumed by the decoder or core. They are not required to be zero by RTL.

## Not Implemented

Two-operand destructive syntax (`Rd ← Rd op Rs`) and `CMP` are not implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected three-register field layout. |
| 1.0.0 | Initial R-type format specification. |
