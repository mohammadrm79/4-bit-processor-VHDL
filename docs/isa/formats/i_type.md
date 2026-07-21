# I-Type Instruction Format

> **Project:** RISC-4 Educational CPU
>
> **Document:** I-Type Instruction Format
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

The I-Type (Immediate-Type) instruction format is used for instructions that require one register operand and one immediate value or memory address.

The immediate field is interpreted according to the instruction semantics.

---

# 2. Instruction Layout

```
15          11 10        8 7                     0

+-------------+-----------+-----------------------+
|   OPCODE    | Register  |      Immediate        |
+-------------+-----------+-----------------------+

     5 bits       3 bits         8 bits
```

---

# 3. Field Description

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 bits | Operation selector |
| Register | 3 bits | Register operand |
| Immediate | 8 bits | Constant value or memory address |

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
| LOAD | Load from data memory |
| STORE | Store to data memory |
| MOVI | Load immediate value |

---

# 6. Operand Usage

## LOAD

Assembly syntax:

```asm
LOAD Rd, Address
```

Field mapping:

| Field | Meaning |
|--------|---------|
| Register | Destination register |
| Immediate | Memory address |

RTL:

```
Rd ← DMEM[Immediate]
```

---

## STORE

Assembly syntax:

```asm
STORE Rs, Address
```

Field mapping:

| Field | Meaning |
|--------|---------|
| Register | Source register |
| Immediate | Memory address |

RTL:

```
DMEM[Immediate] ← Rs
```

---

## MOVI

Assembly syntax:

```asm
MOVI Rd, Immediate
```

Field mapping:

| Field | Meaning |
|--------|---------|
| Register | Destination register |
| Immediate | Constant value |

RTL:

```
Rd ← Immediate
```

---

# 7. Immediate Field

The Immediate field is 8 bits wide.

Its interpretation depends on the instruction.

| Instruction | Immediate Meaning |
|-------------|-------------------|
| LOAD | Data memory address |
| STORE | Data memory address |
| MOVI | Unsigned constant |

Unless otherwise specified:

- Immediate values are treated as unsigned.
- Sign extension is performed only when explicitly required by an instruction.

---

# 8. Register Access

| Instruction | Read | Write |
|-------------|------|-------|
| LOAD | No | Yes |
| STORE | Yes | No |
| MOVI | No | Yes |

---

# 9. Status Flags

| Instruction | Z | C | N | V |
|-------------|---|---|---|---|
| LOAD | — | — | — | — |
| STORE | — | — | — | — |
| MOVI | ✓ | — | ✓ | 0 |

Legend:

- ✓ Updated
- — Unchanged
- 0 Cleared

---

# 10. Memory Addressing

The processor uses direct addressing.

Effective Address:

```
EA = Immediate
```

Indirect and indexed addressing are not supported in ISA Version 1.

---

# 11. Hardware Notes

The I-Type format requires:

- One register operand
- One 8-bit immediate field
- Immediate extraction logic
- Address generation logic for memory instructions

The Immediate field is connected directly to the datapath through the Immediate Generator.

---

# 12. Example Encodings

Example:

```asm
MOVI R2, 15
```

| Field | Value |
|--------|-------|
| Opcode | MOVI |
| Register | R2 |
| Immediate | 15 |

---

Example:

```asm
LOAD R1, 32
```

| Field | Value |
|--------|-------|
| Opcode | LOAD |
| Register | R1 |
| Immediate | 32 |

---

Example:

```asm
STORE R4, 20
```

| Field | Value |
|--------|-------|
| Opcode | STORE |
| Register | R4 |
| Immediate | 20 |

---

# 13. Future Extensions

Possible future enhancements include:

- Signed immediate values
- Indexed addressing
- Base + Offset addressing
- PC-relative addressing
- Load Upper Immediate (LUI)

These extensions shall preserve the fixed 16-bit instruction width whenever possible.

---

# 14. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial I-Type instruction format specification |
