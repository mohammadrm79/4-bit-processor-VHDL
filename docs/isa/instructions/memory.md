# Memory Instructions

> **Project:** RISC-4 Educational CPU
>
> **Document:** Memory Instruction Set
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../reference/opcode_table.md
> - ../formats/i_type.md
> - ../reference/registers.md

---

# 1. Introduction

Memory instructions transfer data between the processor register file and the data memory.

The RISC-4 processor follows a **Load/Store architecture**.

Only memory instructions are permitted to access data memory.

Arithmetic and logical instructions operate exclusively on register operands.

---

# 2. Instruction Summary

| Instruction | Opcode | Description |
|------------|--------|-------------|
| LOAD | 01001 | Load data from memory |
| STORE | 01010 | Store data to memory |
| MOVI | 01011 | Load an immediate constant |

---

# 3. Memory Model

The processor implements a Harvard architecture.

Instruction memory and data memory are physically separated.

Only the data memory is accessed by the instructions described in this document.

```
                +----------------+
                | Instruction ROM|
                +----------------+
                        │
                        ▼

                 Instruction Fetch

                        ▲
                        │

+-----------+     +-------------+      +-----------+
| Register  |<--->|     CPU     |<---->| Data RAM  |
|   File    |     |             |      +-----------+
+-----------+     +-------------+
```

---

# 4. LOAD

## Opcode

```
01001
```

## Format

I-Type

## Syntax

```asm
LOAD Rd, Address
```

## Description

Loads one data word from data memory into the destination register.

## RTL

```
Rd ← DMEM[Address]
```

## Register Access

| Register | Access |
|----------|--------|
| Rd | Write |

## Memory Access

Read

## Status Flags

No flags are modified.

## Example

```asm
LOAD R1, 25
```

---

# 5. STORE

## Opcode

```
01010
```

## Format

I-Type

## Syntax

```asm
STORE Rs, Address
```

## Description

Stores the contents of the source register into data memory.

## RTL

```
DMEM[Address] ← Rs
```

## Register Access

| Register | Access |
|----------|--------|
| Rs | Read |

## Memory Access

Write

## Status Flags

No flags are modified.

## Example

```asm
STORE R1, 25
```

---

# 6. MOVI

## Opcode

```
01011
```

## Format

I-Type

## Syntax

```asm
MOVI Rd, Immediate
```

## Description

Loads an 8-bit immediate constant into the destination register.

If the processor datapath width is smaller than the immediate width, only the least significant bits are written to the destination register.

For ISA Version 1:

```
Register Width = 4 bits
Immediate Width = 8 bits

Rd ← Immediate[3:0]
```

The upper four bits are ignored.

## RTL

```
Rd ← Immediate[3:0]
```

## Register Access

| Register | Access |
|----------|--------|
| Rd | Write |

## Memory Access

None

## Status Flags

| Flag | Update |
|------|--------|
| Z | ✓ |
| C | — |
| N | ✓ |
| V | 0 |

## Example

```asm
MOVI R2, 12
```

---

# 7. Address Space

The current ISA provides an 8-bit address field.

| Property | Value |
|----------|-------|
| Address Width | 8 bits |
| Address Space | 256 locations |

The physical implementation may use a smaller memory.

Unused address bits shall be ignored by the implementation.

---

# 8. Execution Characteristics

| Property | LOAD | STORE | MOVI |
|----------|------|-------|------|
| Register Read | No | Yes | No |
| Register Write | Yes | No | Yes |
| Memory Read | Yes | No | No |
| Memory Write | No | Yes | No |
| ALU Required | Address Path Only | Address Path Only | No |
| Flags Updated | No | No | Yes |

---

# 9. Hardware Requirements

Memory instructions require:

- Register File
- Immediate Generator
- Data Memory Interface
- Address Bus
- Memory Data Bus
- Memory Control Signals
- Control Unit

---

# 10. Future Extensions

Future ISA revisions may introduce:

- Indexed Addressing
- Base + Offset Addressing
- Indirect Addressing
- Load Byte
- Store Byte
- Load Upper Immediate (LUI)
- Memory-Mapped I/O

These features are not part of ISA Version 1.

---

# 11. Design Notes

The Load/Store architecture simplifies the processor datapath by separating computation from memory access.

This approach also reduces the complexity of the Control Unit and aligns with classical RISC design principles.

---

# 12. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial memory instruction specification |
