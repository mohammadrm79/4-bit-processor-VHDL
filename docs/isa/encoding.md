# Instruction Encoding

## Common decoder slices

The instruction decoder unconditionally extracts these fields:

```text
15        11 10      8 7       5 4       2 1     0
+------------+---------+---------+---------+-------+
|   opcode   |   Rd    |   Rs1   |   Rs2   | low2  |
+------------+---------+---------+---------+-------+
```

`immediate = instruction[7:0]` and `address = instruction[10:0]` are also always produced.

## Opcode-selected format classification

| Format | Implemented opcode groups |
|---|---|
| R-type | ADD, SUB, INC, DEC, AND, OR, XOR, NOT, SHL, SHR |
| I-type | LOAD, STORE, MOVI |
| J-type | JMP, JZ, JC |
| S-type | NOP, HALT, and every other opcode |

### R-type

`Rd[10:8]`, `Rs1[7:5]`, and `Rs2[4:2]` are used by binary ALU operations. Bits `[1:0]` are not consumed by the decoder or CPU core.

### I-type

```text
15        11 10      8 7                       0
+------------+---------+-------------------------+
|   opcode   | register|        immediate        |
+------------+---------+-------------------------+
```

The immediate is used only by `MOVI`, which writes its least-significant four bits. Despite this field, memory addressing in `cpu_core` uses `Rs2[4:2]` as decoded from the low immediate bits.

### J-type

`address[10:0]` is supplied to the PC load input. Current PC-enable control prevents that load from taking effect.

### S-type

The remaining 11 bits have no effect for `NOP`, `HALT`, or reserved opcodes.

## Reserved for Future Version

Reserved bits are not checked for zero, sign extension is not implemented, and no illegal-instruction behavior is implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected field use and format behavior. |
| 1.0.0 | Initial encoding specification. |
