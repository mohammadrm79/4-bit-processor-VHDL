# Register File Specification

> **Project:** RISC-4 Educational CPU
>
> **Document:** Register File Specification
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

---

# 1. Introduction

This document defines the programmer-visible register set of the RISC-4 Educational CPU.

The processor provides eight general-purpose registers used by arithmetic, logical, memory, and control instructions.

---

# 2. Register Overview

| Property | Value |
|----------|-------|
| Register Count | 8 |
| Register Width | 4 bits |
| Address Width | 3 bits |
| Register Type | General Purpose |
| Read Ports | 2 |
| Write Ports | 1 |
| Write Policy | Synchronous |
| Read Policy | Combinational |

---

# 3. Register Encoding

| Binary | Decimal | Register |
|---------|---------|----------|
| 000 | 0 | R0 |
| 001 | 1 | R1 |
| 010 | 2 | R2 |
| 011 | 3 | R3 |
| 100 | 4 | R4 |
| 101 | 5 | R5 |
| 110 | 6 | R6 |
| 111 | 7 | R7 |

---

# 4. Register Description

All registers are architecturally identical.

No register has a dedicated hardware function in ISA Version 1.

| Register | Description |
|----------|-------------|
| R0 | General-purpose register |
| R1 | General-purpose register |
| R2 | General-purpose register |
| R3 | General-purpose register |
| R4 | General-purpose register |
| R5 | General-purpose register |
| R6 | General-purpose register |
| R7 | General-purpose register |

---

# 5. Register Usage Guidelines

Although every register is functionally identical, the following software convention is recommended.

| Register | Recommended Usage |
|----------|-------------------|
| R0 | Temporary variable |
| R1 | Operand A |
| R2 | Operand B |
| R3 | Function result |
| R4 | General-purpose |
| R5 | General-purpose |
| R6 | General-purpose |
| R7 | General-purpose |

These conventions are recommendations only.

Hardware does not enforce any register usage policy.

---

# 6. Register Access

Registers may be accessed by the following instruction categories.

| Instruction Category | Read | Write |
|----------------------|------|-------|
| Arithmetic | Yes | Yes |
| Logic | Yes | Yes |
| Memory (LOAD) | No | Yes |
| Memory (STORE) | Yes | No |
| Immediate | No | Yes |
| Control | Optional | No |
| System | No | No |

---

# 7. Reset Behavior

During processor reset:

- All registers shall be initialized to zero.
- Register contents remain unchanged until explicitly modified.
- Reset behavior is synchronous.

Initial state:

```
R0 = 0
R1 = 0
R2 = 0
R3 = 0
R4 = 0
R5 = 0
R6 = 0
R7 = 0
```

---

# 8. Read Operation

The register file supports two independent read ports.

Both source operands may be read during the same clock cycle.

Example:

```asm
ADD R1, R2
```

Read operations:

```
Read Port A → R1

Read Port B → R2
```

---

# 9. Write Operation

The register file provides one synchronous write port.

Only one register may be written during each instruction execution.

Example:

```asm
ADD R1, R2
```

Write operation:

```
R1 ← Result
```

---

# 10. Register Width

Each register stores a single 4-bit value.

```
+----+----+----+----+
| b3 | b2 | b1 | b0 |
+----+----+----+----+
```

Where:

- b3 is the Most Significant Bit (MSB)
- b0 is the Least Significant Bit (LSB)

---

# 11. Future Extensions

Future ISA revisions may introduce dedicated register roles, including:

- Stack Pointer (SP)
- Link Register (LR)
- Frame Pointer (FP)
- Processor Status Register (PSR)

These additions shall preserve compatibility with the existing register encoding whenever possible.

---

# 12. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial register file specification |
