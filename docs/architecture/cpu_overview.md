# CPU Architecture Overview

> **Project:** RISC-4 Educational CPU
>
> **Document:** CPU Architecture Overview
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - ../design_spec.md
> - ../design_decisions.md
> - ../isa/overview.md
> - datapath.md
> - control_unit.md
> - memory.md
> - timing.md

---

# 1. Purpose

This document provides a high-level architectural description of the RISC-4 Educational CPU.

It defines the major hardware components, their responsibilities, and their interactions. The architecture described here serves as the implementation reference for the RTL design.

---

# 2. Design Objectives

The processor architecture has been designed with the following goals:

- Educational simplicity
- Modular implementation
- Fully synthesizable RTL
- Clear separation of datapath and control
- Vendor-independent design
- Easy verification
- Easy future extension

---

# 3. Architectural Overview

The processor implements a simple multi-cycle RISC architecture.

Key characteristics include:

- 4-bit datapath
- 16-bit fixed-length instructions
- Harvard memory architecture
- Eight general-purpose registers
- Multi-cycle instruction execution
- Single clock domain
- Non-pipelined execution

---

# 4. Major Components

The processor consists of the following modules.

| Module | Responsibility |
|---------|----------------|
| Program Counter (PC) | Holds the address of the next instruction |
| Instruction Memory | Stores program instructions |
| Instruction Register (IR) | Holds the current instruction |
| Instruction Decoder | Decodes opcode and operands |
| Register File | Stores general-purpose registers |
| Arithmetic Logic Unit (ALU) | Executes arithmetic and logical operations |
| Status Register | Stores processor flags |
| Data Memory | Stores program data |
| Control Unit | Controls instruction execution |
| CPU Top | Integrates all modules |

---

# 5. High-Level Block Diagram

```
                +----------------------+
                |   Instruction Memory |
                +----------+-----------+
                           |
                           v
                   +---------------+
                   | Program Counter|
                   +-------+-------+
                           |
                           v
                   +---------------+
                   | Instruction IR|
                   +-------+-------+
                           |
                           v
                 +-------------------+
                 | Instruction Decode|
                 +--------+----------+
                          |
          +---------------+----------------+
          |                                |
          v                                v
 +----------------+              +----------------+
 | Register File  |<-----------> |      ALU       |
 +--------+-------+              +--------+-------+
          |                               |
          +---------------+---------------+
                          |
                          v
                 +------------------+
                 | Status Register  |
                 +------------------+

                          |
                          v

                 +------------------+
                 |   Data Memory    |
                 +------------------+

                          ^
                          |
                 +------------------+
                 |   Control Unit   |
                 +------------------+
```

---

# 6. Datapath and Control

The processor is organized into two primary subsystems.

## Datapath

Responsible for:

- Register transfers
- Arithmetic operations
- Logical operations
- Memory data transfers

## Control Unit

Responsible for:

- Instruction sequencing
- Control signal generation
- Execution stage control
- Program flow

---

# 7. Execution Model

Each instruction progresses through the following stages:

1. Fetch
2. Decode
3. Execute
4. Write Back

Only one instruction is active at any given time.

---

# 8. Clocking Strategy

The processor uses:

- Single rising-edge clock
- Synchronous active-high reset
- No clock gating
- No multiple clock domains

---

# 9. Memory Organization

The architecture follows the Harvard model.

Instruction memory stores program instructions.

Data memory stores runtime data.

The two memories are independent.

---

# 10. Register Organization

The register file contains:

- Eight general-purpose registers
- Four-bit register width
- Two combinational read ports
- One synchronous write port

---

# 11. Processor Flags

The Status Register stores:

| Flag | Description |
|------|-------------|
| Z | Zero |
| C | Carry |
| N | Negative |
| V | Overflow |

---

# 12. Module Interfaces

Primary module communication occurs through:

- Instruction bus
- Datapath buses
- Register addresses
- Memory interface
- Control signals
- Status flags

---

# 13. RTL Mapping

| Architecture Component | Planned RTL Module |
|------------------------|--------------------|
| Program Counter | pc.vhd |
| Instruction Register | instruction_register.vhd |
| Instruction Decoder | instruction_decoder.vhd |
| Register File | register_file.vhd |
| ALU | alu.vhd |
| Status Register | status_register.vhd |
| Control Unit | control_unit.vhd |
| CPU Top | cpu_top.vhd |

---

# 14. Future Extensions

Potential future improvements include:

- Pipeline support
- Interrupt controller
- Stack pointer
- UART
- GPIO
- Timer peripherals
- Extended ALU
- Memory-mapped I/O

---

# 15. References

- Design Specification
- Design Decisions
- ISA Documentation
- Datapath Design
- Control Unit Design
- Memory Organization
- Timing Specification
```