# RISC-4 Educational CPU

> **🇮🇷 Persian Documentation Available**
>
> If you prefer reading the documentation in Persian, see **[README-fa.md](README-fa.md)**.

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![VHDL](https://img.shields.io/badge/VHDL-2008-orange)
![GHDL](https://img.shields.io/badge/Simulator-GHDL-green)
![Yosys](https://img.shields.io/badge/Synthesis-Yosys-blue)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey)

---

# Overview

**RISC-4 Educational CPU** is an open-source educational processor implemented entirely in **VHDL-2008**. The project demonstrates the complete design flow of a small RISC processor, from instruction set architecture (ISA) definition and RTL implementation to simulation, synthesis, testing, and documentation.

The processor is intentionally simple while maintaining a clean modular architecture, making it suitable for:

- Digital Logic courses
- Computer Architecture courses
- FPGA education
- VHDL learning
- Processor design laboratories
- Self-study
- Research prototypes

The repository contains everything required to understand, simulate, test, and synthesize the processor without external dependencies beyond the standard open-source toolchain.

---

# Project Goals

The project aims to provide a compact yet complete processor implementation that demonstrates:

- Instruction Set Architecture (ISA)
- Modular RTL design
- Three-register datapath
- Finite State Machine (FSM) based control unit
- Register file implementation
- ALU design
- Instruction decoding
- Program Counter operation
- Memory interface
- Automated testing
- RTL synthesis
- Documentation

Rather than maximizing performance, the design prioritizes readability, maintainability, and educational value.

---

# Features

- VHDL-2008 implementation
- Modular RTL architecture
- Three-register instruction format
- Separate control and datapath
- Arithmetic and logic instructions
- Immediate instructions
- Load and Store instructions
- Jump and conditional branch instructions
- Instruction memory
- Data memory
- Register file
- Automatic assembler
- Unit testing
- Integration testing
- Automated regression testing
- GHDL simulation support
- Yosys synthesis flow
- Graphviz netlist generation
- Verilog netlist generation
- EDIF, BLIF, RTLIL and JSON export
- Comprehensive English and Persian documentation

---

# Supported Instruction Set

Current instructions include:

### Arithmetic

- ADD
- SUB
- INC
- DEC

### Logic

- AND
- OR
- XOR
- NOT

### Shift

- SHL
- SHR

### Memory

- LOAD
- STORE

### Immediate

- MOVI

### Branch

- JMP
- JZ
- JC

### Miscellaneous

- NOP
- HALT

---

# Repository Structure

```text
.
├── docs/
├── docs-fa/
├── scripts/
├── src/
├── tb/
├── build/
├── Makefile
├── README.md
└── README-fa.md
```

| Directory | Description |
|-----------|-------------|
| docs | English documentation |
| docs-fa | Persian documentation |
| src | VHDL source code |
| scripts | Build, simulation and utility scripts |
| tb | Unit and integration testbenches |
| build | Generated build artifacts |

---

# Toolchain

The project is designed to work with the open-source hardware toolchain.

Recommended tools:

- GHDL
- Yosys
- GTKWave
- Graphviz
- GNU Make
- GNU Awk

---

# Build Commands

Common commands:

```bash
make lint
```

Analyze all VHDL source files.

```bash
make test
```

Run assembler, simulation and automated regression tests.

```bash
make sim
```

Execute CPU simulation.

```bash
make synth
```

Generate synthesis netlists.

```bash
make clean
```

Remove generated artifacts.

---

# Documentation

Complete project documentation is available in the **docs/** directory.

The documentation includes:

- Requirements
- ISA Reference
- Processor Architecture
- Testing Framework
- Build Artifacts
- Build Scripts
- Simulation
- Synthesis
- Project Structure

Documentation index:

**➡️ [docs/README.md](docs/README.md)**

---

# Educational Purpose

This project was developed as an educational CPU implementation intended to demonstrate the complete hardware development workflow, including RTL design, instruction decoding, control logic, verification, testing, and synthesis.

The architecture intentionally favors clarity over complexity, making it suitable for learning modern digital design techniques.

---

# License

This project is released under the MIT License.

---

# Keywords

VHDL, VHDL-2008, CPU, Processor, RISC, Computer Architecture, Digital Design, RTL, FPGA, GHDL, Yosys, GTKWave, Graphviz, HDL, Educational CPU, Instruction Set Architecture, ISA, Datapath, Control Unit, Register File, ALU, Finite State Machine, Hardware Design, Open Source, FPGA Education