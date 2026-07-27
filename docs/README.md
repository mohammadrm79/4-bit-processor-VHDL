# Documentation

This documentation describes the current repository implementation. VHDL source is authoritative whenever a document and RTL disagree.

## Contents

| Area | Location | Scope |
|---|---|---|
| Design baseline | `design_spec.md`, `design_decisions.md` | Implemented architecture and recorded decisions |
| Architecture | `architecture/` | CPU integration, datapath, control, memory, and timing |
| ISA | `isa/` | Implemented encoding, opcodes, operations, and limitations |
| Reports | `reports/` | Current build, simulation, and verification status |
| Planning | `roadmap.md` | Completed work and reserved future work |

## Directory structure

```text
docs/
├── architecture/     Implementation-aligned architecture descriptions
├── diagrams/         Empty Draw.io placeholders; diagrams are not implemented
├── isa/              ISA reference
├── reports/          Build and verification status
├── design_decisions.md
├── design_spec.md
└── roadmap.md
```

The four files in `diagrams/` are empty placeholders and must not be interpreted as architecture diagrams.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Rewritten to describe the current VHDL implementation. |
| 1.0.0 | Initial documentation index. |
