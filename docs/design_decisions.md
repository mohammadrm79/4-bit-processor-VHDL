# Design Decisions

> **Project:** RISC-4 Educational CPU
>
> **Document:** Design Decisions
>
> **Version:** 1.0.0
>
> **Status:** Active
>
> This document records all major architectural and engineering decisions made throughout the project.
> Each decision includes its rationale and expected consequences.
> Once a decision reaches the **Frozen** state, it should not be modified unless superseded by a newer decision.

---

# Decision Status

| Status | Description |
|----------|-------------|
| Draft | Under discussion and subject to change |
| Frozen | Approved and considered part of the project baseline |
| Deprecated | Replaced by a newer decision |

---

# DD-001 — 4-bit Datapath

**Status:** Frozen

## Decision

The processor datapath shall be **4 bits wide**.

## Rationale

The CPU is intended primarily as an educational processor.

A 4-bit datapath significantly reduces hardware complexity while preserving the essential concepts of processor architecture and RTL design.

## Consequences

- Smaller ALU
- Smaller buses
- Smaller registers
- Easier verification
- Faster simulation

---

# DD-002 — 16-bit Fixed-Length Instructions

**Status:** Frozen

## Decision

All instructions shall be exactly **16 bits** wide.

## Rationale

Separating instruction width from datapath width simplifies instruction decoding while providing sufficient space for opcode and operands.

## Consequences

- Uniform instruction fetch
- Fixed PC increment
- Simpler decoder
- Easier ISA expansion
- Simplified instruction memory

---

# DD-003 — Load/Store Architecture

**Status:** Frozen

## Decision

Arithmetic and logical instructions shall operate exclusively on registers.

Memory access shall only occur through dedicated **LOAD** and **STORE** instructions.

## Rationale

This follows classical RISC design principles and simplifies datapath implementation.

## Consequences

- Cleaner ALU
- Simpler datapath
- Simpler control FSM
- Better modularity

---

# DD-004 — Eight General-Purpose Registers

**Status:** Frozen

## Decision

The processor shall contain **eight general-purpose registers (R0–R7).**

## Rationale

Eight registers provide a practical balance between programming flexibility and hardware simplicity.

## Consequences

- 3-bit register addressing
- Compact register file
- Simple decoder
- Sufficient storage for educational software

---

# DD-005 — Multi-Cycle Execution

**Status:** Frozen

## Decision

Instructions shall execute using a **multi-cycle execution model**.

## Rationale

A multi-cycle processor greatly simplifies the datapath and control logic while remaining representative of real processor architectures.

## Consequences

- Smaller hardware
- Simpler FSM
- Easier verification
- Easier debugging

---

# DD-006 — Harvard Memory Architecture

**Status:** Frozen

## Decision

Instruction memory and data memory shall be physically separated.

## Rationale

Separating instruction and data memory simplifies instruction fetching and reduces control complexity.

## Consequences

- Independent instruction memory
- Independent data memory
- Simpler control logic
- Predictable instruction fetch

---

# DD-007 — Non-Pipelined Processor

**Status:** Frozen

## Decision

The processor shall execute exactly one instruction at a time.

Pipeline execution shall not be implemented.

## Rationale

The project prioritizes architectural clarity over execution performance.

## Consequences

- Simpler FSM
- Easier debugging
- Easier verification
- Lower hardware complexity

---

# DD-008 — Single Clock Domain

**Status:** Frozen

## Decision

All synchronous modules shall operate from a single rising-edge clock.

## Rationale

Using one clock domain eliminates clock-domain crossing issues and simplifies synthesis.

## Consequences

- Easier timing closure
- Easier synthesis
- No CDC issues
- Simpler verification

---

# DD-009 — Synchronous Active-High Reset

**Status:** Frozen

## Decision

All synchronous modules shall use a synchronous active-high reset.

## Rationale

Synchronous resets produce predictable synthesis results and simplify timing analysis.

## Consequences

- Consistent reset behavior
- Portable RTL
- Easier timing analysis

---

# DD-010 — Vendor-Independent RTL

**Status:** Frozen

## Decision

The RTL implementation shall use only IEEE-standard VHDL constructs.

Vendor-specific primitives, IP cores, and proprietary libraries shall not be used.

## Rationale

Vendor-independent RTL maximizes portability across simulators and synthesis tools while remaining compatible with open-source EDA flows.

## Consequences

- Compatible with GHDL
- Compatible with Yosys
- Portable RTL
- Easier maintenance
- Easier FPGA migration

---

# DD-011 — Multiple Instruction Formats

**Status:** Frozen

## Decision

The ISA shall define multiple instruction formats while maintaining a fixed instruction width of **16 bits**.

The initial ISA revision defines the following formats:

- R-Type
- I-Type
- J-Type
- S-Type

The instruction format shall be determined directly from the opcode.

## Rationale

Different instruction classes require different operand layouts.

Multiple formats improve readability, simplify decoder implementation, and allow future ISA expansion without changing instruction width.

## Consequences

- Cleaner ISA organization
- Simpler decoder
- Better scalability
- Easier documentation
- Compatible with fixed-length instruction fetch

## Affected Documents

- docs/isa/encoding.md
- docs/isa/formats/
- docs/isa/instructions/

## Affected Modules

- instruction_decoder.vhd
- instruction_register.vhd
- control_unit.vhd

## Notes

Additional instruction formats may be introduced in future ISA revisions while preserving backward compatibility.

---

# DD-012 — Initial Opcode Allocation

**Status:** Frozen

## Decision

The initial ISA revision shall define **18 instructions** using a **5-bit opcode field**.

Each opcode shall uniquely identify one instruction and implicitly determine its instruction format.

## Rationale

A 5-bit opcode provides sufficient encoding space while simplifying instruction decoding and allowing future ISA expansion.

## Consequences

- Simple opcode decoding
- Fixed instruction classification
- Straightforward Control FSM implementation
- Reserved opcode space for future extensions

## Affected Documents

- docs/isa/encoding.md
- docs/isa/reference/opcode_table.md
- docs/isa/instructions/

## Affected Modules

- instruction_decoder.vhd
- control_unit.vhd
- instruction_register.vhd

## Notes

The opcode allocation has been reviewed and approved as part of ISA Version 1.

Future ISA revisions may allocate unused opcode values without modifying existing instruction encodings.

---



# DD-013 — Hierarchical RTL Organization

**Status:** Frozen

---

## Decision

The RTL implementation shall follow a hierarchical directory organization based on functional hardware domains.

The RTL source code shall be organized into the following modules:

- `common` — Shared reusable hardware components
- `datapath` — Data processing components
- `control` — Instruction decoding and processor control logic
- `memory` — Instruction and data memory modules
- `core` — CPU integration logic
- `top` — System-level integration

Shared definitions, types, constants, opcode declarations, and utility functions shall be centralized in a single VHDL package


---

# Decision History

| Decision ID | Status | Title |
|-------------|--------|-------|
| DD-001 | Frozen | 4-bit Datapath |
| DD-002 | Frozen | 16-bit Fixed-Length Instructions |
| DD-003 | Frozen | Load/Store Architecture |
| DD-004 | Frozen | Eight General-Purpose Registers |
| DD-005 | Frozen | Multi-Cycle Execution |
| DD-006 | Frozen | Harvard Memory Architecture |
| DD-007 | Frozen | Non-Pipelined Processor |
| DD-008 | Frozen | Single Clock Domain |
| DD-009 | Frozen | Synchronous Active-High Reset |
| DD-010 | Frozen | Vendor-Independent RTL |
| DD-011 | Frozen | Multiple Instruction Formats |
| DD-012 | Frozen | Initial Opcode Allocation |
| DD-013 | Frozen | Hierarchical RTL Organization |
