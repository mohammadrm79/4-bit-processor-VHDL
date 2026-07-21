# R-Type Instruction Format

> **Project:** RISC-4 Educational CPU
>
> **Document:** R-Type Instruction Format
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../encoding.md
> - ../reference/opcode_table.md
> - ../reference/registers.md

---

# 1. Introduction

The R-Type (Register-Type) instruction format is used for register-to-register operations.

These instructions operate entirely on the processor register file and do not directly access memory.

The R-Type format is primarily used by arithmetic and logical instructions.

---

# 2. Instruction Layout

```
15          11 10        8 7         5 4          0

+-------------+-----------+-----------+------------+
|   OPCODE    |    Rd     |    Rs     |  Reserved  |
+-------------+-----------+-----------+------------+

     5 bits       3 bits      3 bits      5 bits
```

---

# 3. Field Description

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 bits | Operation selector |
| Rd | 3 bits | Destination register |
| Rs | 3 bits | Source register |
| Reserved | 5 bits | Reserved, must be encoded as zero |

---

# 4. Register Encoding

| Binary | Register |
|---------|----------|
| 000 | R0 |
| 001 | R1 |
| 010 | R2 |
| 011 | R3 |
| 100 | R4 |
| 101 | R5 |
| 110 | R6 |
| 111 | R7 |

---

# 5. Supported Instructions

| Instruction | Description |
|-------------|-------------|
| ADD | Addition |
| SUB | Subtraction |
| INC | Increment |
| DEC | Decrement |
| CMP | Compare |
| AND | Bitwise AND |
| OR | Bitwise OR |
| XOR | Bitwise XOR |
| NOT | Bitwise NOT |

---

# 6. Operand Usage

## Two-Operand Instructions

The following instructions use both register fields.

```asm
ADD Rd, Rs
SUB Rd, Rs
CMP Rd, Rs
AND Rd, Rs
OR Rd, Rs
XOR Rd, Rs
```

RTL example:

```
Rd ← f(Rd, Rs)
```

---

## Single-Operand Instructions

The following instructions use only the destination register.

```asm
INC Rd
DEC Rd
NOT Rd
```

For these instructions:

- `Rd` contains the operand.
- `Rs` shall be encoded as `000`.
- Reserved bits shall be zero.

---

# 7. Register Access

| Field | Access |
|--------|--------|
| Rd | Read and Write |
| Rs | Read Only |

Example:

```asm
ADD R1, R2
```

Execution:

```
Read R1
Read R2

ALU

Write R1
```

---

# 8. RTL Behavior

General execution model:

```
OperandA ← Register[Rd]

OperandB ← Register[Rs]

Result ← ALU(Operation, OperandA, OperandB)

Register[Rd] ← Result
```

Exception:

```
CMP
```

updates only the status flags.

No register is modified.

---

# 9. Status Flags

R-Type instructions may update the Processor Status Register.

| Instruction | Z | C | N | V |
|-------------|---|---|---|---|
| ADD | ✓ | ✓ | ✓ | ✓ |
| SUB | ✓ | ✓ | ✓ | ✓ |
| INC | ✓ | ✓ | ✓ | ✓ |
| DEC | ✓ | ✓ | ✓ | ✓ |
| CMP | ✓ | ✓ | ✓ | ✓ |
| AND | ✓ | — | ✓ | 0 |
| OR | ✓ | — | ✓ | 0 |
| XOR | ✓ | — | ✓ | 0 |
| NOT | ✓ | — | ✓ | 0 |

Legend:

- ✓ Updated
- — Unchanged
- 0 Cleared

---

# 10. Reserved Bits

The Reserved field shall always be encoded as zero.

Software shall not assign any meaning to these bits.

Future ISA revisions may redefine reserved bits while maintaining backward compatibility.

---

# 11. Hardware Notes

The R-Type format enables:

- Two register reads per instruction
- One register write per instruction
- Simple ALU control
- Efficient datapath implementation

The register file therefore requires:

- Two read ports
- One write port

---

# 12. Example Encodings

Example:

```asm
ADD R1, R2
```

Fields:

| Field | Value |
|--------|-------|
| Opcode | ADD |
| Rd | R1 |
| Rs | R2 |
| Reserved | 00000 |

---

Example:

```asm
INC R3
```

Fields:

| Field | Value |
|--------|-------|
| Opcode | INC |
| Rd | R3 |
| Rs | 000 |
| Reserved | 00000 |

---

# 13. Future Extensions

Future ISA revisions may extend the R-Type format with:

- Shift amount fields
- Rotate operations
- Multiply and divide instructions
- Extended ALU operations

Such extensions shall preserve the fixed 16-bit instruction width whenever possible.

---

# 14. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial R-Type instruction format specification |
