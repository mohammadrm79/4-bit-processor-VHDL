# Instruction Encoding

> **Project:** RISC-4 Educational CPU
>
> **Document:** ISA Encoding
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - overview.md
> - reference/opcode_table.md
> - ../design_decisions.md

---

# 1. Introduction

This document defines the instruction encoding rules used by the RISC-4 Educational CPU.

The encoding specifies how every 16-bit instruction is divided into logical fields.

The exact opcode allocation is defined separately in **reference/opcode_table.md**.

---

# 2. Design Goals

The instruction encoding has been designed to satisfy the following goals:

- Fixed instruction length
- Simple hardware decoding
- Efficient register addressing
- Support for immediate operands
- Future ISA extensibility

---

# 3. General Rules

The following rules apply to every instruction.

- Every instruction is exactly 16 bits.
- The instruction width never changes.
- Instructions are aligned on 16-bit boundaries.
- The Program Counter always advances by one instruction unless modified by control flow instructions.
- The opcode field uniquely determines the instruction format.

---

# 4. Instruction Formats

The ISA currently defines four instruction formats.

| Format | Purpose                         |
| ------ | ------------------------------- |
| R-Type | Register-to-register operations |
| I-Type | Immediate and memory operations |
| J-Type | Jump and branch operations      |
| S-Type | System instructions             |

---

# 5. R-Type Format

Used by arithmetic and logical instructions.

```

15          11 10      8 7       5 4               0

+-------------+---------+---------+----------------+

|   OPCODE    |   Rd    |   Rs    |   Reserved     |

+-------------+---------+---------+----------------+


```

| Field    | Width | Description             |
| -------- | ----- | ----------------------- |
| Opcode   | 5     | Instruction opcode      |
| Rd       | 3     | Destination register    |
| Rs       | 3     | Source register         |
| Reserved | 5     | Reserved bits shall be encoded as zero in ISA version 1 |

---

# 6. I-Type Format

Used by instructions requiring one register operand and an immediate value or memory address.

```
15          11 10       8 7                     0

+-------------+----------+-----------------------+

|   OPCODE    | Register |      Immediate        |

+-------------+----------+-----------------------+
```

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 | Instruction opcode |
| Register | 3 | Register operand |
| Immediate | 8 | Immediate value or memory address |

#### Register Field Usage

| Instruction | Register Field |
|------------|----------------|
| LOAD | Destination register |
| STORE | Source register |
| MOVI | Destination register |
---

# 7. J-Type Format

Used by jump and branch instructions.

```
15          11 10                     0

+-------------+------------------------+

|   OPCODE    |        Address         |

+-------------+------------------------+
```

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 | Instruction opcode |
| Address | 11 | Jump target address |

---


# 8. S-Type Format

Used by system instructions.

```
15          11 10                     0

+-------------+------------------------+

|   OPCODE    |       Reserved         |

+-------------+------------------------+
```

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 | Instruction opcode |
| Reserved | 11 | Reserved (must be zero) |

---

# 9. Register Encoding

The processor contains eight general-purpose registers.

| Binary | Register |
| ------ | -------- |
| 000    | R0       |
| 001    | R1       |
| 010    | R2       |
| 011    | R3       |
| 100    | R4       |
| 101    | R5       |
| 110    | R6       |
| 111    | R7       |

---

# 10. Immediate Values

Immediate values occupy the least significant 8 bits of I-Type instructions.

Unless otherwise specified:

- Immediate values are treated as unsigned.
- Sign extension shall be performed by the execution unit when required.
- Memory addresses are interpreted as unsigned values.

---

# 11. Reserved Bits

Reserved bits shall always be encoded as zero.

Software shall not depend on reserved bit values.

Future ISA revisions may redefine reserved fields while maintaining backward compatibility.

---


# 12. Decoder Behavior

Instruction decoding follows the sequence below:

1. Fetch the instruction.
2. Extract the opcode field.
3. Determine the instruction format.
4. Decode register operands.
5. Decode immediate or address fields.
6. Generate execution control signals.

---

# 13. Future Extensions

The current encoding reserves opcode space for future ISA revisions.

Possible extensions include:

- Shift instructions
- Compare instructions
- Stack operations
- Subroutine support
- Interrupt handling
- Extended addressing modes

Future extensions shall preserve the fixed 16-bit instruction width.

---

# 14. Revision History

| Version | Description |
|---------|-------------|
| 0.1.0 | Initial encoding specification |
| 0.2.0 | Updated to 5-bit opcode encoding |
