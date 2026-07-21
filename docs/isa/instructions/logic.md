# Logic Instructions

> **Project:** RISC-4 Educational CPU
>
> **Document:** Logic Instruction Set
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../reference/opcode_table.md
> - ../reference/flags.md
> - ../formats/r_type.md

---

# 1. Introduction

Logic instructions perform bitwise operations on values stored in the general-purpose register file.

All logic instructions use the **R-Type** instruction format and operate independently on each bit of the operands.

---

# 2. Instruction Summary

| Instruction | Opcode | Description |
|------------|--------|-------------|
| AND | 00101 | Bitwise AND |
| OR | 00110 | Bitwise OR |
| XOR | 00111 | Bitwise Exclusive OR |
| NOT | 01000 | Bitwise NOT |

---

# 3. AND

## Opcode

```
00101
```

## Format

R-Type

## Syntax

```asm
AND Rd, Rs
```

## Description

Performs a bitwise AND operation between the destination register and the source register.

## RTL

```
Rd ← Rd AND Rs
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | — |
| N | ✓ |
| V | 0 |

## Example

```asm
AND R1, R2
```

---

# 4. OR

## Opcode

```
00110
```

## Format

R-Type

## Syntax

```asm
OR Rd, Rs
```

## Description

Performs a bitwise OR operation between the destination register and the source register.

## RTL

```
Rd ← Rd OR Rs
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | — |
| N | ✓ |
| V | 0 |

## Example

```asm
OR R3, R4
```

---

# 5. XOR

## Opcode

```
00111
```

## Format

R-Type

## Syntax

```asm
XOR Rd, Rs
```

## Description

Performs a bitwise Exclusive OR operation between the destination register and the source register.

## RTL

```
Rd ← Rd XOR Rs
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | — |
| N | ✓ |
| V | 0 |

## Example

```asm
XOR R5, R6
```

---

# 6. NOT

## Opcode

```
01000
```

## Format

R-Type

## Syntax

```asm
NOT Rd
```

## Description

Performs a bitwise inversion of the destination register.

The source register field shall be encoded as `000`.

## RTL

```
Rd ← NOT Rd
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | — |
| N | ✓ |
| V | 0 |

## Example

```asm
NOT R2
```

---

# 7. Execution Characteristics

| Property | Value |
|----------|-------|
| Instruction Format | R-Type |
| Register Reads | 2 (1 for NOT) |
| Register Writes | 1 |
| ALU Required | Yes |
| Data Memory Access | No |
| Status Flags | Updated |

---

# 8. Hardware Requirements

Logic instructions require:

- Register File
- ALU
- ALU Control Unit
- Processor Status Register
- Control Unit

The ALU shall implement dedicated combinational logic for each bitwise operation.

---

# 9. Truth Tables

## AND

| A | B | Result |
|---|---|--------|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

---

## OR

| A | B | Result |
|---|---|--------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

---

## XOR

| A | B | Result |
|---|---|--------|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

---

## NOT

| A | Result |
|---|--------|
| 0 | 1 |
| 1 | 0 |

---

# 10. Future Extensions

Possible future logical instructions include:

- NAND
- NOR
- XNOR
- SHL (Logical Shift Left)
- SHR (Logical Shift Right)
- ROL (Rotate Left)
- ROR (Rotate Right)

These instructions are reserved for future ISA revisions.

---

# 11. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial logic instruction specification |
