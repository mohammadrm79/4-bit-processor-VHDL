# Design Decisions

This record distinguishes implemented decisions from ideas reserved for later work. Current RTL is authoritative.

| ID | Decision | Status | RTL evidence |
|---|---|---|---|
| DD-001 | 4-bit datapath | Implemented | `DATA_WIDTH = 4` |
| DD-002 | 16-bit fixed instructions | Implemented | `INSTRUCTION_WIDTH = 16` |
| DD-003 | Separate instruction/data memories | Implemented | `instruction_memory`, `data_memory` |
| DD-004 | Eight general-purpose registers | Implemented | `REGISTER_COUNT = 8` |
| DD-005 | Multi-cycle control | Implemented | `control_fsm` |
| DD-006 | Single rising-edge clock | Implemented | Sequential RTL components |
| DD-007 | Synchronous active-high reset | Implemented | Sequential RTL components |
| DD-008 | 5-bit opcode field | Implemented | `OPCODE_WIDTH = 5` |
| DD-009 | Four named instruction formats | Implemented for decoding | `opcode_to_format` |

## Clarifications

“Harvard” describes the separate RTL memories, but both memories are internal simulation models rather than external interfaces. The instruction-memory model uses text I/O and a default program file.

`memory_operation_t` and the package helper functions are defined in `cpu_pkg`. The integrated core uses direct entity instantiations and a local write-back-selection process; there are no RTL entities named `counter`, `register_n`, or `mux` in the current source tree.

## Reserved for Future Version

Claims of a fully synthesizable, portable implementation, external memory interfaces, complete per-module verification, and vendor targets are **Reserved for Future Version**. The current synthesis flow has known path and source-list defects.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Converted decisions to implementation-aligned status. |
| 1.0.0 | Initial decision record. |
