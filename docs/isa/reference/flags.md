# Processor Status Flags

> **Project:** RISC-4 Educational CPU
>
> **Document:** Processor Status Flags
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../overview.md
> - ../encoding.md
> - opcode_table.md
> - timing.md

---

# 1. Introduction

This document defines the Processor Status Register (PSR) and the behavior of all status flags used by the RISC-4 Educational CPU.

Status flags provide information about the result of instruction execution and are primarily used by conditional branch instructions.

---

# 2. Processor Status Register

The Processor Status Register (PSR) contains four status flags.

```
+----+----+----+----+
| Z  | C  | N  | V  |
+----+----+----+----+
 bit3 bit2 bit1 bit0
```

| Flag | Name | Description |
|------|------|-------------|
| Z | Zero | Result equals zero |
| C | Carry | Carry out (addition) or no borrow (subtraction) |
| N | Negative | Most Significant Bit (MSB) of the result is 1 |
| V | Overflow | Signed arithmetic overflow |

---

# 3. Zero Flag (Z)

The Zero flag is set whenever an operation produces a result equal to zero.

## Set Condition

```
Result == 0
```

## Cleared Condition

```
Result != 0
```

### Examples

```asm
MOVI R1, 0
```

```
Z = 1
```

---

```asm
MOVI R1, 5
```

```
Z = 0
```

---

# 4. Carry Flag (C)

The Carry flag indicates an unsigned carry or borrow condition.

## Addition

The Carry flag is set when an addition generates a carry beyond the most significant bit.

Example:

```
1111
+0001
-----
0000
```

Carry:

```
C = 1
```

---

## Subtraction

For subtraction, the Carry flag follows the common CPU convention:

- C = 1 → No borrow
- C = 0 → Borrow occurred

---

# 5. Negative Flag (N)

The Negative flag reflects the most significant bit of the result.

```
N = Result(3)
```

Example:

```
Result = 1001
```

```
N = 1
```

---

# 6. Overflow Flag (V)

The Overflow flag indicates signed arithmetic overflow.

Overflow occurs when:

- Two positive values produce a negative result.
- Two negative values produce a positive result.

Overflow is meaningful only for signed arithmetic.

Logical instructions shall clear this flag.

---

# 7. Flag Update Rules

| Instruction Category | Z | C | N | V |
|----------------------|---|---|---|---|
| ADD | ✓ | ✓ | ✓ | ✓ |
| SUB | ✓ | ✓ | ✓ | ✓ |
| INC | ✓ | ✓ | ✓ | ✓ |
| DEC | ✓ | ✓ | ✓ | ✓ |
| CMP | ✓ | ✓ | ✓ | ✓ |
| AND | ✓ | — | ✓ | 0 |
| OR  | ✓ | — | ✓ | 0 |
| XOR | ✓ | — | ✓ | 0 |
| NOT | ✓ | — | ✓ | 0 |
| LOAD | — | — | — | — |
| STORE | — | — | — | — |
| MOVI | ✓ | — | ✓ | 0 |
| JMP | — | — | — | — |
| JZ | — | — | — | — |
| JNZ | — | — | — | — |
| JC | — | — | — | — |
| NOP | — | — | — | — |
| HALT | — | — | — | — |

Legend:

- ✓ = Updated
- — = Unchanged
- 0 = Cleared

---

# 8. Flag Usage by Instructions

| Instruction | Flags Used |
|-------------|------------|
| JZ | Z |
| JNZ | Z |
| JC | C |

Current ISA Version 1 does not include instructions that directly test the N or V flags.

---

# 9. CMP Instruction Behavior

The CMP instruction performs an internal subtraction.

```
Rd - Rs
```

The computed result is discarded.

Only the Processor Status Register is updated.

No register contents are modified.

---

# 10. Reset Behavior

During processor reset:

```
Z = 0
C = 0
N = 0
V = 0
```

---

# 11. Design Notes

The Processor Status Register is not directly accessible by software.

Flags may only be modified as a side effect of instruction execution.

Future ISA revisions may introduce instructions for reading or saving processor status.

---

# 12. Future Extensions

Potential future status flags include:

- Interrupt Enable (I)
- Half Carry (H)
- Parity (P)
- Sticky Overflow (SV)

These extensions shall preserve backward compatibility with the current Processor Status Register whenever possible.

---

# 13. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial processor status flag specification |
