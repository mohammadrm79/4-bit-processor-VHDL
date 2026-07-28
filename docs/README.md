# RISC-4 Documentation

This documentation explains the VHDL implementation of the RISC-4 Educational CPU. It is organized for readers who want to understand the implemented processor, build it, or run its tests. When a document differs from the RTL, the sources under `src/` are authoritative.

## Start here

- [Design specification](design_spec.md) — implemented configuration and architectural baseline.
- [Design decisions](design_decisions.md) — constraints and rationale recorded for the project.
- [Requirements](requirements.md) — repository, tool, and implementation requirements.

## Architecture

- [Architecture index](architecture/README.md) — guide to the architecture documents.
- [CPU overview](architecture/cpu_overview.md) — top-level entities and architectural state.
- [Datapath](architecture/datapath.md) — decode, operands, ALU, data memory, and write-back paths.
- [Control unit](architecture/control_unit.md) — FSM states and control outputs.
- [Memory](architecture/memory.md) — instruction and data-memory models.
- [Timing](architecture/timing.md) — clocked and combinational behavior.

## Instruction-set architecture

- [ISA index](isa/README.md) — instruction-set navigation and implemented instruction groups.
- [ISA overview](isa/overview.md) — architectural values and programming model.
- [Instruction encoding](isa/encoding.md) — common field extraction and format classification.
- [R-type format](isa/formats/r_type.md) — register-to-register ALU encoding.
- [I-type format](isa/formats/i_type.md) — memory and immediate encoding.
- [J-type format](isa/formats/j_type.md) — jump-target encoding.
- [S-type format](isa/formats/s_type.md) — system and unallocated opcodes.
- [Arithmetic instructions](isa/instructions/arithmetic.md) — ADD, SUB, INC, and DEC.
- [Logic and shift instructions](isa/instructions/logic.md) — AND, OR, XOR, NOT, SHL, and SHR.
- [Memory and immediate instructions](isa/instructions/memory.md) — LOAD, STORE, and MOVI.
- [Control-flow instructions](isa/instructions/control.md) — JMP, JZ, and JC.
- [System instructions](isa/instructions/system.md) — NOP and HALT.
- [Opcode table](isa/reference/opcode_table.md) — complete allocated opcode list.
- [Registers](isa/reference/registers.md) — register-file organization.
- [Flags](isa/reference/flags.md) — Z, C, N, and V behavior.
- [Instruction timing](isa/reference/timing.md) — per-state execution timing.
- [Program-image examples](isa/examples.md) — supported assembly and hexadecimal image examples.

## Development and verification

- [Build guide](build.md) — lint, simulation, synthesis, and clean commands.
- [Scripts guide](scripts.md) — repository helper scripts and their inputs/outputs.
- [Test guide](test.md) — unit, integration, and program-test organization.

## Directory structure

```text
docs/
├── architecture/  Implementation-aligned CPU architecture
├── diagrams/      Draw.io diagram sources
├── isa/           Instruction-set reference
├── build.md       Build workflow
├── design_decisions.md
├── design_spec.md
├── requirements.md
├── scripts.md
└── test.md
```
