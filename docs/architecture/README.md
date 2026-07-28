# Processor Architecture

These documents describe the implemented `system_top` → `cpu_core` integration.

- [CPU overview](cpu_overview.md) — entities, connections, and architectural state.
- [Datapath](datapath.md) — instruction fields, operands, ALU, data memory, and write-back.
- [Control unit](control_unit.md) — `control_fsm` states and control signals.
- [Memory](memory.md) — instruction/data-memory implementation and addressing.
- [Timing](timing.md) — single-clock state and data-update timing.

The Draw.io sources in [`../diagrams/`](../diagrams/) are editable diagrams; they are not RTL source files.
