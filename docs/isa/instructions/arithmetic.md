# Arithmetic Instructions

> **Project:** RISC-4 Educational CPU
>
> **Document:** Arithmetic Instruction Set
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

Arithmetic instructions perform mathematical operations on values stored in the general-purpose register file.

All arithmetic instructions use the **R-Type** instruction format.

---

# 2. Instruction Summary

| Instruction | Opcode | Description |
|------------|--------|-------------|
| ADD | 00000 | Add two registers |
| SUB | 00001 | Subtract two registers |
| INC | 00010 | Increment register |
| DEC | 00011 | Decrement register |
| CMP | 00100 | Compare two registers |

---

# 3. ADD

## Opcode

```
00000
```

## Format

R-Type

## Syntax

```asm
ADD Rd, Rs
```

## Description

Adds the value of the source register to the destination register.

## RTL

```
Rd ← Rd + Rs
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | ✓ |
| N | ✓ |
| V | ✓ |

## Example

```asm
ADD R1, R2
```

---

# 4. SUB

## Opcode

```
00001
```

## Format

R-Type

## Syntax

```asm
SUB Rd, Rs
```

## Description

Subtracts the source register from the destination register.

## RTL

```
Rd ← Rd - Rs
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | ✓ |
| N | ✓ |
| V | ✓ |

## Example

```asm
SUB R4, R3
```

---

# 5. INC

## Opcode

```
00010
```

## Format

R-Type

## Syntax

```asm
INC Rd
```

## Description

Increments the destination register by one.

## RTL

```
Rd ← Rd + 1
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | ✓ |
| N | ✓ |
| V | ✓ |

## Example

```asm
INC R5
```

---

# 6. DEC

## Opcode

```
00011
```

## Format

R-Type

## Syntax

```asm
DEC Rd
```

## Description

Decrements the destination register by one.

## RTL

```
Rd ← Rd - 1
```

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | ✓ |
| N | ✓ |
| V | ✓ |

## Example

```asm
DEC R6
```

---

# 7. CMP

## Opcode

```
00100
```

## Format

R-Type

## Syntax

```asm
CMP Rd, Rs
```

## Description

Compares two registers by performing an internal subtraction.

The computed result is discarded.

Only the Processor Status Register is updated.

## RTL

```
Temp ← Rd - Rs

UpdateFlags(Temp)
```

## Register Write

None.

## Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | ✓ |
| N | ✓ |
| V | ✓ |

## Example

```asm
CMP R1, R2
```

---

# 8. Execution Characteristics

| Property | Value |
|----------|-------|
| Instruction Format | R-Type |
| Register Reads | 2 |
| Register Writes | 1 (except CMP) |
| ALU Required | Yes |
| Data Memory Access | No |
| Status Flags | Updated |

---

# 9. Hardware Requirements

Arithmetic instructions require:

- Register File
- ALU
- ALU Control Unit
- Processor Status Register
- Control Unit

---

# 10. Future Extensions

Possible future arithmetic instructions include:

- ADC (Add with Carry)
- SBC (Subtract with Borrow)
- NEG (Negate)
- MUL (Multiply)
- DIV (Divide)
- MOD (Modulo)

These instructions are not part of ISA Version 1.

---

# 11. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial arithmetic instruction specification |
