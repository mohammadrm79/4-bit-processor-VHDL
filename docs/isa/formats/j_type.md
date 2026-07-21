# J-Type Instruction Format

> **Project:** RISC-4 Educational CPU
>
> **Document:** J-Type Instruction Format
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../encoding.md
> - ../reference/opcode_table.md
> - ../reference/flags.md

---

# 1. Introduction

The J-Type (Jump-Type) instruction format is used for program control flow.

These instructions modify the Program Counter (PC), allowing unconditional or conditional branching.

Unlike R-Type and I-Type instructions, J-Type instructions do not access the register file.

---

# 2. Instruction Layout

```
15          11 10                     0

+-------------+------------------------+
|   OPCODE    |        Address         |
+-------------+------------------------+

     5 bits          11 bits
```

---

# 3. Field Description

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 bits | Operation selector |
| Address | 11 bits | Absolute instruction address |

---

# 4. Supported Instructions

| Instruction | Description |
|-------------|-------------|
| JMP | Unconditional jump |
| JZ | Jump if Zero flag is set |
| JNZ | Jump if Zero flag is clear |
| JC | Jump if Carry flag is set |

---

# 5. Address Field

The Address field specifies the destination instruction address.

The Program Counter shall be loaded directly with this value when the jump condition is satisfied.

```
PC ← Address
```

Addresses are absolute.

Relative branching is not supported in ISA Version 1.

---

# 6. Conditional Branches

Conditional jump instructions evaluate the Processor Status Register before updating the Program Counter.

| Instruction | Condition |
|-------------|-----------|
| JMP | Always |
| JZ | Z = 1 |
| JNZ | Z = 0 |
| JC | C = 1 |

---

# 7. Program Counter Behavior

Normally:

```
PC ← PC + 1
```

For a successful jump:

```
PC ← Address
```

If a conditional jump is **not taken**, execution continues with the next sequential instruction.

---

# 8. Register Access

J-Type instructions do not read or write any general-purpose registers.

| Resource | Access |
|----------|--------|
| Register File | No |
| Data Memory | No |
| Instruction Memory | Fetch Only |
| Program Counter | Read / Write |

---

# 9. Status Flags

J-Type instructions do not modify the Processor Status Register.

| Instruction | Z | C | N | V |
|-------------|---|---|---|---|
| JMP | — | — | — | — |
| JZ | — | — | — | — |
| JNZ | — | — | — | — |
| JC | — | — | — | — |

Legend:

- — Unchanged

---

# 10. RTL Behavior

## JMP

```
PC ← Address
```

---

## JZ

```
if Z = 1 then
    PC ← Address
else
    PC ← PC + 1
end if
```

---

## JNZ

```
if Z = 0 then
    PC ← Address
else
    PC ← PC + 1
end if
```

---

## JC

```
if C = 1 then
    PC ← Address
else
    PC ← PC + 1
end if
```

---

# 11. Hardware Notes

The J-Type format requires:

- Program Counter
- Branch decision logic
- Status flag evaluation
- PC multiplexer

The instruction decoder selects the branch condition according to the opcode.

---

# 12. Example Encodings

Example:

```asm
JMP 100
```

| Field | Value |
|--------|-------|
| Opcode | JMP |
| Address | 100 |

---

Example:

```asm
JZ 25
```

| Field | Value |
|--------|-------|
| Opcode | JZ |
| Address | 25 |

---

Example:

```asm
JNZ 8
```

| Field | Value |
|--------|-------|
| Opcode | JNZ |
| Address | 8 |

---

Example:

```asm
JC 200
```

| Field | Value |
|--------|-------|
| Opcode | JC |
| Address | 200 |

---

# 13. Future Extensions

Future ISA revisions may introduce additional control-flow instructions, including:

- CALL
- RET
- Conditional branches based on N and V flags
- Relative branches
- Branch with link
- Computed jump

These extensions shall preserve the fixed 16-bit instruction width whenever possible.

---

# 14. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial J-Type instruction format specification |
