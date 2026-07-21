# Instruction Set Architecture (ISA) Overview

> **Project:** RISC-4 Educational CPU
>
> **Document:** ISA Overview
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - ../design_spec.md
> - ../design_decisions.md
> - encoding.md
> - examples.md
> - instructions/
> - reference/

---

# 1. Introduction

This document provides a high-level overview of the Instruction Set Architecture (ISA) implemented by the RISC-4 Educational CPU.

The ISA defines the interface between software and hardware by specifying:

- Instruction encoding
- Register organization
- Memory model
- Execution model
- Addressing modes
- Instruction categories
- Processor state

This document serves as the architectural entry point for all ISA-related documentation.

---

# 2. Design Goals

The ISA has been designed with the following objectives:

- Simplicity
- Educational value
- Hardware efficiency
- Easy RTL implementation
- Easy verification
- Predictable execution
- Future extensibility

The processor intentionally sacrifices performance in favor of architectural clarity and ease of implementation.

---

# 3. Architectural Philosophy

The processor follows a classical Reduced Instruction Set Computer (RISC) philosophy.

Key architectural characteristics include:

- Fixed-length instructions
- Register-based execution
- Load/Store architecture
- Harvard memory organization
- Multi-cycle execution
- Non-pipelined implementation
- Simple instruction decoder

The architecture is intended to demonstrate fundamental CPU design principles rather than maximize execution performance.

---

# 4. CPU Characteristics

| Property | Value |
|-----------|-------|
| Architecture | RISC |
| Datapath Width | 4 bits |
| Instruction Width | 16 bits |
| Opcode Width | 5 bits |
| Register Count | 8 |
| Register Width | 4 bits |
| Execution Model | Multi-cycle |
| Memory Architecture | Harvard |
| Pipeline | None |
| Branch Delay Slot | No |
| Endianness | Not Applicable |

---

# 5. Register Model

The processor contains eight General-Purpose Registers (GPRs).

| Register | Width |
|----------|-------|
| R0 | 4 bits |
| R1 | 4 bits |
| R2 | 4 bits |
| R3 | 4 bits |
| R4 | 4 bits |
| R5 | 4 bits |
| R6 | 4 bits |
| R7 | 4 bits |

All registers are architecturally identical.

The ISA assigns no predefined purpose to any register.

Future ISA revisions may dedicate registers for specialized functions such as a Stack Pointer (SP) or Link Register (LR).

---

# 6. Memory Model

The processor uses a Harvard memory architecture.

Instruction memory and data memory are physically separated.

## Instruction Memory

Characteristics:

- Read-only during execution
- Stores 16-bit instructions
- Addressed by the Program Counter

## Data Memory

Characteristics:

- Read/Write
- Stores 4-bit values
- Directly accessed through LOAD and STORE instructions

---

# 7. Execution Model

Each instruction progresses through a fixed sequence of execution stages.

1. Fetch
2. Decode
3. Execute
4. Write Back

Only one instruction is executed at any given time.

Pipeline execution and speculative execution are intentionally not implemented.

---

# 8. Addressing Modes

The ISA supports a small number of addressing modes to simplify hardware implementation.

Supported addressing modes are:

- Register Addressing
- Immediate Addressing
- Direct Memory Addressing

Detailed instruction formats are defined in **encoding.md**.

---

# 9. Instruction Categories

The instruction set is organized into five logical categories.

- Arithmetic Instructions
- Logic Instructions
- Memory Instructions
- Control Flow Instructions
- System Instructions

Each category is documented separately under:

```
docs/isa/instructions/
```

---

# 10. Processor Status Flags

The Arithmetic Logic Unit updates the processor status register.

The processor currently defines four flags.

| Flag | Description |
|------|-------------|
| Z | Zero |
| C | Carry |
| N | Negative |
| V | Overflow |

The exact behavior of every instruction is documented in the instruction specification files located under:

```
docs/isa/instructions/
```

---

# 11. Instruction Encoding

All instructions are exactly 16 bits wide.

Each instruction begins with a fixed 5-bit opcode.

The opcode uniquely determines:

- Instruction type
- Operand layout
- Decoder behavior

Detailed encoding rules are specified in **encoding.md**.

---

# 12. Programming Model

Programs execute sequentially beginning at the reset address.

The Program Counter automatically advances after each instruction unless modified by:

- JMP
- JZ
- JC
- JNZ

Program execution terminates only after the execution of a HALT instruction.

---

# 13. Design Decisions

The ISA is based on the architectural decisions documented in **design_decisions.md**.

The most significant decisions include:

| Decision | Description |
|-----------|-------------|
| DD-001 | 4-bit Datapath |
| DD-002 | 16-bit Fixed-Length Instructions |
| DD-003 | Load/Store Architecture |
| DD-004 | Eight General-Purpose Registers |
| DD-005 | Multi-Cycle Execution |
| DD-006 | Harvard Memory Architecture |
| DD-007 | Non-Pipelined Processor |
| DD-011 | Multiple Instruction Formats |
| DD-012 | 5-bit Opcode Allocation |

---

# 14. Future Compatibility

The ISA has been designed with future expansion in mind.

Potential future extensions include:

- Shift Instructions
- Stack Support
- CALL / RET
- Interrupt Handling
- Memory-Mapped I/O
- UART Peripheral
- GPIO Peripheral
- Timer Peripheral
- Hardware Multiplier
- Extended Addressing Modes

Future ISA revisions shall preserve backward compatibility whenever practical.

---

# 15. Related Documentation

The complete ISA specification consists of the following documents.

## Core Documents

- encoding.md
- examples.md

## Instruction Formats

- formats/r_type.md
- formats/i_type.md
- formats/j_type.md
- formats/s_type.md

## Instruction Specifications

- instructions/arithmetic.md
- instructions/logic.md
- instructions/memory.md
- instructions/control.md
- instructions/system.md

## Reference

- reference/opcode_table.md
- reference/registers.md
- reference/flags.md
- reference/timing.md

---

# 16. Version History

| Version | Description |
|----------|-------------|
| 0.1.0 | Initial ISA overview |
| 0.2.0 | Updated for ISA Version 1 documentation structure and 5-bit opcode architecture |
