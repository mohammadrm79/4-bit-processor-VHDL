# Processor Architecture

This directory contains the internal hardware architecture documentation for the **RISC-4 Educational CPU**.

Unlike the ISA documentation, which describes the processor from a software perspective, the architecture documentation focuses on the internal RTL organization and hardware implementation.

It serves as the primary reference during RTL development, verification, and future maintenance.

---

# Directory Structure

```
architecture/
│
├── README.md
├── cpu_overview.md
├── datapath.md
├── control_unit.md
├── memory.md
└── timing.md
```

---

# Documentation Overview

## cpu_overview.md

Provides a high-level description of the processor architecture.

Topics include:

- Overall CPU organization
- Major hardware modules
- Architectural philosophy
- Top-level block diagram
- Module interactions

---

## datapath.md

Describes the processor datapath.

Topics include:

- Datapath organization
- Internal buses
- Register file connections
- ALU integration
- Multiplexers
- Data flow during instruction execution

---

## control_unit.md

Documents the processor control unit.

Topics include:

- Control FSM
- Execution stages
- Control signal generation
- Decoder interaction
- Instruction sequencing

---

## memory.md

Describes the processor memory subsystem.

Topics include:

- Harvard architecture
- Instruction memory
- Data memory
- Memory interfaces
- Addressing model

---

## timing.md

Documents processor timing behavior.

Topics include:

- Clocking strategy
- Reset behavior
- Multi-cycle execution
- Timing assumptions
- Instruction execution timeline

---

# Hardware Organization

The processor is divided into several independent RTL modules.

Major architectural components include:

- Program Counter
- Instruction Register
- Instruction Decoder
- Register File
- Arithmetic Logic Unit (ALU)
- Processor Status Register
- Control Unit
- Instruction Memory Interface
- Data Memory Interface
- CPU Top-Level

Each module is implemented independently and verified using a dedicated testbench before system integration.

---

# Architectural Principles

The processor architecture follows these principles:

- Hierarchical design
- Modular implementation
- Vendor-independent RTL
- Specification-driven development
- Fully synthesizable hardware
- Clear separation of datapath and control
- Easy verification
- Easy future extension

---

# Relationship to the ISA

The ISA specifies **what** the processor must do.

The architecture specifies **how** the processor performs those operations internally.

The ISA remains stable even if the internal architecture changes, provided that externally observable behavior is preserved.

---

# Development Workflow

The architecture documentation supports the following development process:

```
Design Specification
        │
        ▼
ISA Definition
        │
        ▼
Architecture Design
        │
        ▼
RTL Development
        │
        ▼
Unit Verification
        │
        ▼
Integration
        │
        ▼
Simulation
        │
        ▼
Synthesis
```

---

# Related Documents

Project documentation:

- ../design_spec.md
- ../design_decisions.md

ISA documentation:

- ../isa/

Project roadmap:

- ../roadmap.md

Architecture diagrams:

- ../diagrams/

---

# Intended Audience

This documentation is intended for:

- RTL designers
- Verification engineers
- FPGA developers
- Students
- Future project contributors

---

# Document Status

Current Architecture Version:

```
1.0.0
```

Status:

```
Active
```

This directory defines the intended architectural baseline for Version 1 of the RISC-4 Educational CPU. The detailed architecture documents remain to be completed.
