# Control Unit Architecture

> **Project:** RISC-4 Educational CPU
>
> **Document:** Control Unit Architecture
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - cpu_overview.md
> - datapath.md
> - memory.md
> - timing.md
> - ../design_spec.md
> - ../design_decisions.md
> - ../isa/encoding.md

---

# 1. Purpose

This document describes the architecture and operation of the Control Unit.

The Control Unit coordinates the execution of every instruction by generating the control signals required by the datapath modules.

---

# 2. Responsibilities

The Control Unit is responsible for:

- Sequencing instruction execution
- Generating datapath control signals
- Controlling register writes
- Controlling ALU operations
- Managing memory access
- Updating the Program Counter
- Handling conditional branches
- Controlling processor halt

---

# 3. Design Goals

The Control Unit has been designed to provide:

- Deterministic behavior
- Simple implementation
- Fully synthesizable RTL
- Easy debugging
- Easy verification
- Clear state transitions
- Future extensibility

---

# 4. Architecture

The Control Unit is implemented as a synchronous Finite State Machine (FSM).

Characteristics:

- Single clock domain
- Rising-edge triggered
- Synchronous reset
- Multi-cycle execution
- One active state at a time

---

# 5. Inputs

| Signal | Description |
|---------|-------------|
| Clock | System clock |
| Reset | Synchronous active-high reset |
| Opcode | Current instruction opcode |
| Zero Flag | Status Register |
| Carry Flag | Status Register |
| Negative Flag | Status Register |
| Overflow Flag | Status Register |

---

# 6. Outputs

| Signal | Description |
|---------|-------------|
| PC Load | Load Program Counter |
| PC Increment | Increment Program Counter |
| IR Load | Load Instruction Register |
| Register Write Enable | Write Register File |
| Memory Read | Read Data Memory |
| Memory Write | Write Data Memory |
| ALU Operation | Select ALU function |
| Status Register Write | Update processor flags |
| CPU Halt | Halt processor |

---

# 7. Execution States

The processor executes one instruction through four sequential stages.

| State | Description |
|--------|-------------|
| Fetch | Read instruction from Instruction Memory |
| Decode | Decode instruction fields |
| Execute | Execute ALU, memory or branch operation |
| WriteBack | Store results and update architectural state |

---

# 8. State Transition Diagram

```
          +---------+
          |  Reset  |
          +----+----+
               |
               v
          +---------+
          | Fetch   |
          +----+----+
               |
               v
          +---------+
          | Decode  |
          +----+----+
               |
               v
          +---------+
          | Execute |
          +----+----+
               |
               v
          +-----------+
          | WriteBack |
          +-----+-----+
                |
                v
             Fetch
```

---

# 9. Instruction Control

The opcode determines the required control signals.

Instruction classes include:

- Arithmetic
- Logic
- Memory
- Control Flow
- System

Each class activates a predefined sequence of control signals during execution.

---

# 10. Branch Handling

Branch instructions evaluate the Status Register.

Conditional branches:

- JZ
- JC

Unconditional branch:

- JMP

The Program Counter is updated only during the Execute stage.

---

# 11. HALT Behavior

When a HALT instruction is executed:

- Program Counter stops advancing.
- Register File remains unchanged.
- Memory accesses stop.
- The processor remains in the halted state until reset.

---

# 12. Timing Requirements

The Control Unit operates synchronously.

Requirements:

- One active state per clock cycle
- Deterministic transitions
- No combinational feedback loops
- No asynchronous control logic

---

# 13. RTL Mapping

| Function | RTL Module |
|----------|------------|
| FSM | control_unit.vhd |
| Opcode Decode | instruction_decoder.vhd |
| State Register | control_unit.vhd |

---

# 14. Verification Requirements

The Control Unit shall be verified by:

- Reset tests
- State transition tests
- Instruction sequencing tests
- Branch tests
- HALT tests
- Full CPU integration tests

---

# 15. Future Extensions

Future revisions may introduce:

- Interrupt controller
- Exception handling
- Pipeline control
- Hazard detection
- Stall generation
- Branch prediction

---

# 16. References

- CPU Architecture Overview
- Datapath Architecture
- Timing Specification
- ISA Encoding
- Design Decisions
```