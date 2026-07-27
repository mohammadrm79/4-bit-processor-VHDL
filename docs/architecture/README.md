# Processor Architecture

Architecture documentation describes the integrated `system_top` → `cpu_core` implementation.

| Document | Subject |
|---|---|
| `cpu_overview.md` | Entities and high-level connections |
| `datapath.md` | Register, ALU, write-back, and operand paths |
| `control_unit.md` | `control_fsm` states and outputs |
| `memory.md` | Actual memory models and addressing |
| `timing.md` | Clocked state and data-update timing |

The files in `docs/diagrams/` are empty placeholders; no diagram is currently implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Updated to actual entity and file names. |
| 1.0.0 | Initial architecture index. |
