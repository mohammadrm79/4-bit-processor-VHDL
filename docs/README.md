# Documentation

Welcome to the documentation of the **RISC-4 Educational CPU** project.

This directory contains the complete engineering documentation describing the processor architecture, Instruction Set Architecture (ISA), implementation strategy, verification methodology, and project reports.

The documentation is intended to serve as the single source of truth throughout the development lifecycle.

---

# Documentation Structure

```
docs/
│
├── README.md
├── design_spec.md
├── design_decisions.md
├── roadmap.md
│
├── architecture/
├── isa/
├── diagrams/
└── reports/
```

---

# Documents

## Design Specification

**File**

```
design_spec.md
```

Defines the overall processor specification, project goals, constraints, architectural requirements, implementation strategy, and development methodology.

---

## Design Decisions

**File**

```
design_decisions.md
```

Records every significant engineering decision made during the project.

Each decision includes:

- Decision
- Rationale
- Consequences
- Status

---

## Roadmap

**File**

```
roadmap.md
```

Defines the planned development phases from specification to final release.

---

# Architecture Documentation

Directory:

```
architecture/
```

Contains documentation describing the internal hardware architecture.

Topics include:

- CPU Overview
- Datapath
- Control Unit
- Memory Organization
- Timing Model

---

# ISA Documentation

Directory:

```
isa/
```

Contains the complete Instruction Set Architecture specification.

Including:

- ISA Overview
- Instruction Encoding
- Instruction Formats
- Instruction Specifications
- Programming Examples
- Reference Tables

---

# Diagrams

Directory:

```
diagrams/
```

Contains architecture diagrams created using draw.io.

Examples include:

- CPU Block Diagram
- Datapath
- Control FSM
- Instruction Formats

---

# Reports

Directory:

```
reports/
```

Contains project reports generated during development.

Reports include:

- Verification Report
- Simulation Report
- Synthesis Report

---

# Documentation Workflow

The documentation follows a specification-driven workflow.

```
Project Specification
        │
        ▼
ISA Definition
        │
        ▼
Architecture Design
        │
        ▼
RTL Implementation
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
Final Documentation
```

---

# Versioning

Documentation versions follow semantic versioning.

```
MAJOR.MINOR.PATCH
```

Example:

```
1.0.0
```

---

# Related Documents

- design_spec.md
- design_decisions.md
- roadmap.md
- architecture/
- isa/
- reports/