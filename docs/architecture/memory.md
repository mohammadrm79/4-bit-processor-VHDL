# Memory Architecture

> **Project:** RISC-4 Educational CPU
>
> **Document:** Memory Architecture
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - cpu_overview.md
> - datapath.md
> - control_unit.md
> - timing.md
> - ../design_spec.md
> - ../design_decisions.md
> - ../isa/overview.md

---

# 1. Purpose

This document specifies the memory architecture of the RISC-4 Educational CPU.

It defines the organization of Instruction Memory and Data Memory, their interfaces, and their interaction with the datapath and Control Unit.

---

# 2. Design Goals

The memory subsystem has been designed to provide:

- Simple implementation
- Predictable timing
- Independent instruction and data access
- Fully synthesizable RTL
- Easy verification
- Vendor-independent implementation

---

# 3. Memory Organization

The processor implements a **Harvard Architecture**.

Instruction Memory and Data Memory are completely independent.

```
                 +----------------------+
                 |   Instruction Memory |
                 +----------+-----------+
                            |
                            |
                            v
                    Instruction Register
                            |
                            |
                            v
                       Control Unit

                 +----------------------+
                 |      Data Memory     |
                 +----------+-----------+
                            ^
                            |
                            |
                        Register File
                            ^
                            |
                           ALU
```

---

# 4. Instruction Memory

Instruction Memory stores the executable program.

Characteristics:

| Property | Value |
|----------|-------|
| Access | Read Only |
| Word Width | 16 bits |
| Address Source | Program Counter |
| Modified During Execution | No |

Instruction Memory is external to the CPU core and is accessed only during the Fetch stage.

---

# 5. Data Memory

Data Memory stores runtime variables.

Characteristics:

| Property | Value |
|----------|-------|
| Access | Read / Write |
| Data Width | 4 bits |
| Address Source | Immediate Field |
| Access Instructions | LOAD, STORE |

Data Memory is only accessed through dedicated memory instructions.

---

# 6. Address Space

Version 1 defines a simple linear address space.

| Memory | Address Width |
|---------|---------------|
| Instruction Memory | 11 bits |
| Data Memory | 8 bits |

The exact implementation size may be smaller than the theoretical address space.

Unused addresses are implementation-defined.

---

# 7. Memory Interfaces

## Instruction Memory Interface

| Signal | Width | Description |
|---------|------:|-------------|
| instr_addr | 11 | Instruction address |
| instr_data | 16 | Instruction word |

---

## Data Memory Interface

| Signal | Width | Description |
|---------|------:|-------------|
| data_addr | 8 | Memory address |
| data_in | 4 | Data written to memory |
| data_out | 4 | Data read from memory |
| mem_read | 1 | Read enable |
| mem_write | 1 | Write enable |

---

# 8. Memory Access Sequence

## Instruction Fetch

1. Program Counter provides instruction address.
2. Instruction Memory returns a 16-bit instruction.
3. Instruction Register stores the instruction.

---

## LOAD

1. Decode immediate address.
2. Read Data Memory.
3. Transfer value to Register File.

---

## STORE

1. Read source register.
2. Decode immediate address.
3. Write register value into Data Memory.

---

# 9. Memory Timing

Instruction Memory is accessed during the Fetch stage.

Data Memory is accessed during the Execute stage.

Only one memory operation is active during each instruction.

---

# 10. Design Constraints

The memory subsystem shall satisfy the following constraints:

- Harvard architecture
- No unified memory
- No cache
- No DMA
- No memory protection
- No virtual memory
- No burst transfers

---

# 11. RTL Mapping

| Function | RTL Module |
|----------|------------|
| Instruction Memory Interface | cpu_top.vhd |
| Data Memory Interface | cpu_top.vhd |

Instruction Memory and Data Memory are expected to be modeled as external components during simulation.

---

# 12. Verification Requirements

The memory subsystem shall be verified using:

- Instruction fetch tests
- LOAD instruction tests
- STORE instruction tests
- Address decoding tests
- Full processor execution tests

---

# 13. Future Extensions

Future versions may introduce:

- Memory initialization files
- Block RAM inference
- Memory-mapped I/O
- Stack memory
- Peripheral address space
- External memory bus
- Cache memory

---

# 14. References

- CPU Architecture Overview
- Datapath Architecture
- Control Unit Architecture
- ISA Overview
- Design Specification
- Design Decisions