# Project Roadmap

> **Project:** RISC-4 Educational CPU
>
> **Document:** Development Roadmap
>
> **Version:** 1.0.0
>
> **Status:** Active

---

# 1. Purpose

This document defines the overall development roadmap for the RISC-4 Educational CPU project.

The project follows a specification-driven workflow in which every phase is completed and reviewed before moving to the next stage.

---

# 2. Development Philosophy

The project is developed incrementally.

Each phase produces a well-defined deliverable that serves as the foundation for the following phase.

General workflow:

```
Specification
      │
      ▼
Architecture
      │
      ▼
RTL
      │
      ▼
Verification
      │
      ▼
Simulation
      │
      ▼
Synthesis
      │
      ▼
Release
```

---

# 3. Project Phases

| Phase | Description | Status |
|--------|-------------|--------|
| Phase 1 | Repository Setup | ✅ Completed |
| Phase 2 | Project Specification | ✅ Completed |
| Phase 3 | ISA Design | ✅ Completed |
| Phase 4 | Architecture Design | ⏳ Planned |
| Phase 5 | RTL Implementation | ⏳ Planned |
| Phase 6 | Unit Verification | ⏳ Planned |
| Phase 7 | Integration Verification | ⏳ Planned |
| Phase 8 | System Simulation | ⏳ Planned |
| Phase 9 | Logic Synthesis | ⏳ Planned |
| Phase 10 | Documentation & Release | ⏳ Planned |

---

# 4. Phase Details

## Phase 1 — Repository Setup

### Objectives

- Create repository structure
- Configure Git
- Add project license
- Create `.gitignore`
- Organize project directories

### Deliverables

- Repository initialized
- Directory structure completed
- Initial commit created

**Status:** Completed

---

## Phase 2 — Project Specification

### Objectives

- Define project goals
- Define architectural constraints
- Select development tools
- Document design philosophy
- Record design decisions

### Deliverables

- `design_spec.md`
- `design_decisions.md`

**Status:** Completed

---

## Phase 3 — ISA Design

### Objectives

- Define instruction formats
- Define opcode allocation
- Define registers
- Define flags
- Define instruction behavior
- Create programming examples

### Deliverables

```
docs/isa/
```

**Status:** Completed

---

## Phase 4 — Architecture Design

### Objectives

- Define CPU block diagram
- Design datapath
- Design control unit
- Define memory interfaces
- Document timing model
- Create architecture diagrams

### Deliverables

```
docs/architecture/
docs/diagrams/
```

**Status:** Planned

---

## Phase 5 — RTL Implementation

### Objectives

Develop synthesizable VHDL modules for:

- Common package
- ALU
- Register File
- Program Counter
- Instruction Register
- Processor Status Register
- Instruction Decoder
- Control Unit
- CPU Top-Level

### Deliverables

```
src/rtl/
```

**Status:** Planned

---

## Phase 6 — Unit Verification

### Objectives

Create independent testbenches for every RTL module.

Modules include:

- ALU
- Register File
- Program Counter
- Instruction Register
- Decoder
- Control Unit

### Deliverables

```
src/sim/
```

**Status:** Planned

---

## Phase 7 — Integration Verification

### Objectives

- Integrate all RTL modules
- Verify datapath
- Verify instruction execution
- Verify processor state transitions

### Deliverables

- CPU integration testbench
- Waveforms
- Verification report

**Status:** Planned

---

## Phase 8 — System Simulation

### Objectives

- Execute complete example programs
- Validate ISA behavior
- Inspect waveforms
- Verify final processor operation

### Deliverables

- Simulation waveforms
- Simulation report

**Status:** Planned

---

## Phase 9 — Logic Synthesis

### Objectives

- Analyze RTL using GHDL
- Synthesize using Yosys
- Generate generic netlist
- Review synthesis statistics
- Verify synthesizability

### Deliverables

- Netlist
- Resource utilization
- Synthesis report

**Status:** Planned

---

## Phase 10 — Documentation & Release

### Objectives

- Final documentation review
- Final repository cleanup
- Tag Version 1.0.0
- Prepare project release

### Deliverables

- Release package
- Complete documentation
- Tagged Git repository

**Status:** Planned

---

# 5. Toolchain

| Tool | Purpose |
|------|---------|
| VHDL-2008 | Hardware Description Language |
| GHDL | Analysis and Simulation |
| Yosys | Logic Synthesis |
| GTKWave | Waveform Viewer |
| Make | Build Automation |
| Git | Version Control |

---

# 6. Project Milestones

| Milestone | Status |
|-----------|--------|
| Repository Initialized | ✅ |
| Documentation Baseline | ✅ |
| ISA Frozen | ✅ |
| Architecture Frozen | ⏳ |
| RTL Complete | ⏳ |
| Unit Tests Complete | ⏳ |
| Integration Complete | ⏳ |
| Simulation Complete | ⏳ |
| Synthesis Complete | ⏳ |
| Version 1.0 Release | ⏳ |

---

# 7. Success Criteria

The project shall be considered complete when:

- All RTL modules are implemented.
- All unit tests pass.
- Integration tests pass.
- Example programs execute correctly.
- The design is fully synthesizable.
- Documentation is complete.
- Version 1.0.0 is released.

---

# 8. Related Documents

- `design_spec.md`
- `design_decisions.md`
- `architecture/`
- `isa/`
- `reports/`

---

# 9. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial development roadmap |
