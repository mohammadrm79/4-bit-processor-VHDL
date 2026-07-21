# Design Specification

> **Project:** RISC-4 Educational CPU
>
> **Document:** Design Specification
>
> **Version:** 1.0.0
>
> **Status:** Active
>
> **Author:** Mohammadreza Moafi
>
> **Language:** VHDL-2008

---

# 1. Project Overview

## 1.1 Purpose

The purpose of this project is to design, simulate, verify, and synthesize a simple educational 4-bit RISC CPU using VHDL-2008 and a fully open-source EDA toolchain.

The processor is intended as a university-level digital systems design project that emphasizes clean architecture, modular RTL, maintainability, synthesizability, and complete engineering documentation.

The project follows a specification-driven workflow in which the architecture is fully defined before RTL implementation begins.

---

## 1.2 Objectives

The primary objectives of this project are:

- Design a fully synthesizable 4-bit RISC processor.
- Follow hierarchical hardware design principles.
- Implement reusable RTL modules.
- Verify every hardware module independently.
- Simulate the processor using GHDL.
- Synthesize the processor using Yosys.
- Produce professional engineering documentation.
- Maintain complete portability across FPGA vendors.

---

# 2. Design Philosophy

The project follows these principles:

- Modular architecture
- Hierarchical design
- Readable RTL
- Synthesizable VHDL
- Vendor-independent implementation
- Incremental development
- Specification-first workflow
- Independent module verification

---

# 3. CPU Overview

| Parameter | Value |
|-----------|-------|
| Architecture | RISC |
| Datapath Width | 4 bits |
| Register Width | 4 bits |
| General-Purpose Registers | 8 |
| Instruction Width | 16 bits |
| Opcode Width | 5 bits |
| Execution Model | Multi-cycle |
| Pipeline | None |
| Memory Architecture | Harvard |
| HDL | VHDL-2008 |
| Simulation | GHDL |
| Synthesis | Yosys |
| Waveform Viewer | GTKWave |

---

# 4. Functional Requirements

The processor shall support the following functionality:

- Sequential instruction execution
- Instruction fetching
- Instruction decoding
- Register read/write
- Arithmetic operations
- Logical operations
- Immediate operations
- Data memory access
- Conditional branching
- Unconditional jumping
- Program termination

---

# 5. Non-Functional Requirements

The processor shall satisfy the following quality requirements:

- Fully synthesizable RTL
- Portable implementation
- Modular structure
- Easy verification
- Easy debugging
- Easy maintenance
- Consistent coding style
- Complete documentation

---

# 6. System Constraints

The implementation shall satisfy the following constraints:

- VHDL-2008 only
- IEEE standard libraries only
- Vendor-independent RTL
- No proprietary IP
- No clock gating
- Single clock domain
- Open-source toolchain only

---

# 7. Clock and Reset

## Clock

- Single system clock
- Rising-edge triggered

## Reset

- Synchronous
- Active High

---

# 8. Memory Organization

The processor uses a Harvard memory architecture.

Instruction memory and data memory are physically independent.

## Instruction Memory

Characteristics:

- Read-only during execution
- 16-bit instruction width
- Addressed by the Program Counter

## Data Memory

Characteristics:

- Read/Write
- 4-bit data width
- Direct addressing

The architectural address space is defined by the ISA.

The physical implementation may use a smaller memory size than the architectural address space.

---

# 9. Register Organization

The processor contains a single register file.

Specifications:

- Eight general-purpose registers
- 4-bit register width
- Two combinational read ports
- One synchronous write port

Registers:

- R0
- R1
- R2
- R3
- R4
- R5
- R6
- R7

All registers are architecturally identical.

---

# 10. Arithmetic Logic Unit (ALU)

The ALU performs arithmetic and logical operations.

Supported operations include:

### Arithmetic

- ADD
- SUB
- INC
- DEC
- CMP

### Logical

- AND
- OR
- XOR
- NOT

The ALU updates the processor status flags.

Supported flags:

| Flag | Description |
|------|-------------|
| Z | Zero |
| C | Carry |
| N | Negative |
| V | Overflow |

---

# 11. Processor Modules

The processor is divided into independent RTL modules.

Major modules include:

- ALU
- Register File
- Program Counter
- Instruction Register
- Instruction Decoder
- Control Unit
- Processor Status Register
- Instruction Memory Interface
- Data Memory Interface
- CPU Top-Level

Each module shall have an independent testbench.

---

# 12. Instruction Execution Model

The processor follows a multi-cycle execution model.

Execution stages:

1. Fetch
2. Decode
3. Execute
4. Write Back

Only one instruction is active at any time.

Pipeline execution is intentionally omitted.

---

# 13. Verification Strategy

Verification shall be performed in three stages.

## Unit Verification

Individual verification of:

- ALU
- Register File
- Program Counter
- Instruction Register
- Decoder
- Control Unit

## Integration Verification

Verification of the complete processor datapath.

## System Verification

Execution of complete assembly programs.

Waveforms shall be inspected using GTKWave.

---

# 14. Synthesis Strategy

The processor shall be synthesized using a completely open-source toolchain.

RTL Flow:

```
VHDL-2008
      │
      ▼
GHDL Analysis
      │
      ▼
Yosys Synthesis
      │
      ▼
Generic Netlist
```

Future FPGA implementation may target open FPGA flows without modifying RTL.

---

# 15. Deliverables

The completed project shall include:

- RTL source code
- Testbenches
- Simulation scripts
- Makefile
- Waveforms
- Synthesis reports
- Design documentation
- Git repository

---

# 16. Future Extensions

Possible future improvements include:

- Stack Pointer
- CALL / RET instructions
- Interrupt controller
- Memory-mapped I/O
- UART peripheral
- GPIO peripheral
- Timer peripheral
- Hardware multiplier
- Pipeline implementation
- 8-bit processor variant

---

# 17. Development Methodology

The project follows a specification-driven development workflow.

Development phases:

1. Project Specification
2. ISA Definition
3. Architecture Design
4. RTL Development
5. Unit Verification
6. Integration Verification
7. System Simulation
8. Logic Synthesis
9. Documentation
10. Release

---

# 18. Toolchain

| Tool | Purpose |
|------|---------|
| VHDL-2008 | Hardware Description Language |
| GHDL | Simulation |
| Yosys | Logic Synthesis |
| GTKWave | Waveform Viewer |
| Make | Build Automation |
| Git | Version Control |

---

# 19. Related Documents

- Design Decisions
- ISA Overview
- ISA Encoding
- Instruction Specifications
- Architecture Documentation

---

# 20. Version History

| Version | Description |
|----------|-------------|
| 0.1.0 | Initial specification |
| 0.2.0 | Updated to ISA v1 architecture (5-bit opcode, modular instruction documentation) |
