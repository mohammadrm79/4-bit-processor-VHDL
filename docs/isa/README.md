# Instruction Set Architecture (ISA)

This directory contains the complete Instruction Set Architecture (ISA) specification for the **RISC-4 Educational CPU**.

The ISA defines the software-visible behavior of the processor, including instruction encoding, execution semantics, registers, addressing modes, and programming examples.

This documentation serves as the authoritative reference for implementing the instruction decoder, control unit, assembler, and verification environment.

---

# Directory Structure

```
isa/
│
├── README.md
├── overview.md
├── encoding.md
├── examples.md
│
├── formats/
│   ├── r_type.md
│   ├── i_type.md
│   ├── j_type.md
│   └── s_type.md
│
├── instructions/
│   ├── arithmetic.md
│   ├── logic.md
│   ├── memory.md
│   ├── control.md
│   └── system.md
│
└── reference/
    ├── opcode_table.md
    ├── registers.md
    ├── flags.md
    └── timing.md
```

---

# Documentation Overview

## overview.md

Provides a high-level introduction to the ISA.

Topics include:

- Design philosophy
- Register model
- Memory model
- Execution model
- Instruction categories
- Programming model

---

## encoding.md

Defines the binary encoding of every instruction format.

Topics include:

- Instruction width
- Opcode layout
- Register encoding
- Immediate encoding
- Decoder behavior

---

## examples.md

Contains complete example programs demonstrating the use of the instruction set.

Examples illustrate common programming patterns and expected processor behavior.

---

# Instruction Formats

Directory:

```
formats/
```

Documents every instruction format used by the processor.

Included formats:

- R-Type
- I-Type
- J-Type
- S-Type

Each document describes:

- Bit layout
- Field definitions
- Operand usage
- Typical instructions

---

# Instruction Specifications

Directory:

```
instructions/
```

Defines the behavior of every instruction supported by the processor.

Instruction categories include:

- Arithmetic
- Logic
- Memory
- Control Flow
- System

Each instruction specification includes:

- Opcode
- Format
- Syntax
- Description
- RTL operation
- Flags affected
- Execution timing
- Example

---

# Reference

Directory:

```
reference/
```

Contains reference material used throughout the project.

Available references:

- Opcode allocation
- Register encoding
- Processor flags
- Instruction timing

---

# Design Principles

The ISA follows these principles:

- Fixed-length instructions
- Register-based execution
- Load/Store architecture
- Multi-cycle execution
- Simple instruction decoding
- Hardware-oriented design
- Future extensibility

---

# Related Documents

Project-level documentation:

- ../design_spec.md
- ../design_decisions.md

Architecture documentation:

- ../architecture/

Project roadmap:

- ../roadmap.md

---

# Intended Audience

This documentation is intended for:

- RTL developers
- Verification engineers
- Students
- Contributors
- Future maintainers

---

# Document Status

Current ISA Version:

```
1.0.0
```

Status:

```
Stable
```

The ISA described in this directory represents the architectural baseline for Version 1 of the RISC-4 Educational CPU.
