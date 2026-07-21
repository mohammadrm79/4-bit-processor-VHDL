# Programming Examples

> **Project:** RISC-4 Educational CPU
>
> **Document:** Programming Examples
>
> **Version:** 1.0.0
>
> **Status:** Stable
>
> **Related Documents:**
>
> - overview.md
> - encoding.md
> - reference/opcode_table.md
> - reference/registers.md
> - reference/flags.md
> - instructions/

---

# 1. Introduction

This document provides example assembly programs demonstrating the use of the RISC-4 Instruction Set Architecture (ISA).

The examples are intended for:

- ISA validation
- Assembly language reference
- Processor verification
- Testbench development
- Future assembler development

Unless otherwise specified, all registers are assumed to contain zero after reset.

---

# 2. Example 1 — Load Immediate Values

## Objective

Load constant values into registers.

```asm
MOVI R1, 5
MOVI R2, 3
HALT
```

Expected result:

| Register | Value |
|----------|------:|
| R1 | 5 |
| R2 | 3 |

---

# 3. Example 2 — Integer Addition

## Objective

Add two values.

```asm
MOVI R1, 5
MOVI R2, 3
ADD  R1, R2
HALT
```

Execution:

```
R1 = 5
R2 = 3

R1 = R1 + R2

R1 = 8
```

Expected result:

| Register | Value |
|----------|------:|
| R1 | 8 |
| R2 | 3 |

---

# 4. Example 3 — Integer Subtraction

```asm
MOVI R1, 9
MOVI R2, 4
SUB  R1, R2
HALT
```

Expected result:

| Register | Value |
|----------|------:|
| R1 | 5 |

---

# 5. Example 4 — Increment and Decrement

```asm
MOVI R1, 7

INC R1
INC R1
DEC R1

HALT
```

Expected result:

```
7 → 8 → 9 → 8
```

Final value:

| Register | Value |
|----------|------:|
| R1 | 8 |

---

# 6. Example 5 — Logical Operations

```asm
MOVI R1, 10
MOVI R2, 12

AND R1, R2
OR  R1, R2
XOR R1, R2
NOT R1

HALT
```

Purpose:

Demonstrate every logical instruction.

---

# 7. Example 6 — Memory Access

Store a value into memory and load it back.

```asm
MOVI  R1, 9

STORE R1, 20

LOAD  R2, 20

HALT
```

Expected result:

| Location | Value |
|----------|------:|
| DMEM[20] | 9 |

| Register | Value |
|----------|------:|
| R2 | 9 |

---

# 8. Example 7 — Comparison

```asm
MOVI R1, 5
MOVI R2, 5

CMP R1, R2

HALT
```

Expected flags:

| Flag | Value |
|------|------:|
| Z | 1 |
| C | Implementation Defined |
| N | 0 |
| V | 0 |

---

# 9. Example 8 — Conditional Branch

```asm
MOVI R1, 8
MOVI R2, 8

CMP R1, R2

JZ Equal

MOVI R3, 0

Equal:

MOVI R3, 1

HALT
```

Expected result:

| Register | Value |
|----------|------:|
| R3 | 1 |

---

# 10. Example 9 — Counting Loop

```asm
MOVI R1, 5

Loop:

DEC R1

JNZ Loop

HALT
```

Execution:

```
5
4
3
2
1
0
```

Expected result:

| Register | Value |
|----------|------:|
| R1 | 0 |

Expected flags:

```
Z = 1
```

---

# 11. Example 10 — NOP Demonstration

```asm
MOVI R1, 5

NOP

NOP

INC R1

HALT
```

Expected result:

```
R1 = 6
```

---

# 12. Example 11 — HALT

```asm
MOVI R1, 4

HALT

INC R1
```

Expected behavior:

- HALT is executed.
- Processor enters the HALTED state.
- INC is never executed.

Expected result:

| Register | Value |
|----------|------:|
| R1 | 4 |

---

# 13. Example 12 — Complete Program

The following program computes:

```
(6 + 3) - 2
```

```asm
MOVI R1, 6
MOVI R2, 3
MOVI R3, 2

ADD R1, R2
SUB R1, R3

STORE R1, 10

HALT
```

Execution:

```
6 + 3 = 9

9 - 2 = 7

DMEM[10] = 7
```

Expected result:

| Register | Value |
|----------|------:|
| R1 | 7 |

| Memory | Value |
|--------|------:|
| DMEM [10] | 7 |

---

# 14. Notes

These examples are intended as architectural references.

They will also serve as:

- Unit test specifications
- Integration test programs
- Simulation workloads
- Future assembler validation cases

Additional examples may be added in future ISA revisions.

---

# 15. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial programming examples |
