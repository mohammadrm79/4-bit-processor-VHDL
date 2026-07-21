# Datapath Architecture

> **Project:** RISC-4 Educational CPU
>
> **Document:** Datapath Architecture
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - cpu_overview.md
> - control_unit.md
> - memory.md
> - timing.md
> - ../design_spec.md
> - ../design_decisions.md
> - ../isa/overview.md

---

# 1. Purpose

This document defines the datapath architecture of the RISC-4 Educational CPU.

The datapath is responsible for transporting, transforming, and storing data during instruction execution. It contains all hardware elements that directly manipulate operands.

---

# 2. Design Goals

The datapath has been designed to satisfy the following objectives:

- Simple and readable organization
- Fully synthesizable RTL
- Modular implementation
- Clear separation from the Control Unit
- Efficient register transfers
- Easy verification
- Future extensibility

---

# 3. Datapath Overview

The datapath consists of interconnected hardware modules responsible for:

- Register storage
- Arithmetic operations
- Logical operations
- Memory access
- Program flow support

All data transfers occur under the supervision of the Control Unit.

---

# 4. Major Components

| Component | Function |
|-----------|----------|
| Register File | Stores processor registers |
| ALU | Performs arithmetic and logical operations |
| Program Counter | Holds instruction addresses |
| Instruction Register | Holds the current instruction |
| Status Register | Stores processor flags |
| Data Memory Interface | Reads and writes data memory |
| Internal Buses | Connect datapath components |

---

# 5. Datapath Organization

```
                    Instruction Register
                             │
                             ▼
                    Instruction Decoder
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
       Register File                  Immediate Value
         │        │                         │
         │        └──────────────┐          │
         ▼                       ▼          ▼
      Operand A              Operand B  Immediate
              │                  │          │
              └──────────┬───────┘          │
                         ▼                  │
                   +-------------+          │
                   |     ALU     |◄─────────┘
                   +------+------+ 
                          │
          ┌───────────────┼────────────────┐
          ▼               ▼                ▼
  Register File    Status Register    Data Memory
```

---

# 6. Register File Interface

The Register File provides:

- Two combinational read ports
- One synchronous write port

Signals:

| Signal | Direction | Width | Description |
|--------|-----------|------:|-------------|
| rs_addr | Output | 3 | Source register address |
| rd_addr | Output | 3 | Destination register address |
| rs_data | Input | 4 | Source register value |
| rd_data | Input | 4 | Destination register value |
| write_data | Output | 4 | Data written to register |
| write_enable | Output | 1 | Register write enable |

---

# 7. ALU Interface

The ALU receives operands from the Register File or immediate values.

Inputs:

- Operand A
- Operand B
- ALU operation code

Outputs:

- Result
- Zero flag
- Carry flag
- Negative flag
- Overflow flag

---

# 8. Status Register

The Status Register stores the ALU flags after execution.

| Flag | Description |
|------|-------------|
| Z | Zero |
| C | Carry |
| N | Negative |
| V | Overflow |

Only instructions that explicitly modify flags update this register.

---

# 9. Immediate Data Path

Immediate values are extracted from I-Type instructions by the Instruction Decoder.

The immediate value is routed directly to the ALU when required.

No additional immediate extension hardware is required for Version 1.

---

# 10. Memory Data Path

The datapath communicates with Data Memory through a simple interface.

Operations supported:

- Read
- Write

Memory accesses occur only through:

- LOAD
- STORE

This follows the Load/Store architecture defined by the ISA.

---

# 11. Internal Data Widths

| Signal | Width |
|---------|------:|
| Datapath | 4 bits |
| Registers | 4 bits |
| ALU Result | 4 bits |
| Instruction | 16 bits |
| Register Address | 3 bits |
| Opcode | 5 bits |
| Immediate | 8 bits |
| Jump Address | 11 bits |

---

# 12. Data Flow

Typical instruction execution proceeds as follows:

1. Fetch instruction.
2. Load instruction into the Instruction Register.
3. Decode operands.
4. Read source registers.
5. Execute ALU or memory operation.
6. Update Status Register if required.
7. Write result back to the destination register.
8. Advance the Program Counter.

---

# 13. Datapath Constraints

The datapath shall satisfy the following constraints:

- Single 4-bit data width
- No pipeline registers
- No speculative execution
- One instruction active at a time
- Single write-back stage
- Fully synchronous operation

---

# 14. RTL Mapping

| Datapath Element | RTL Module |
|------------------|------------|
| Register File | register_file.vhd |
| ALU | alu.vhd |
| Program Counter | pc.vhd |
| Instruction Register | instruction_register.vhd |
| Status Register | status_register.vhd |
| CPU Top | cpu_top.vhd |

---

# 15. Verification Requirements

The datapath shall be verified through:

- Register File unit tests
- ALU unit tests
- Program Counter tests
- Instruction Register tests
- Integration tests
- Full processor simulation

---

# 16. Future Extensions

Future datapath enhancements may include:

- Barrel shifter
- Hardware multiplier
- Stack pointer
- Address generation unit
- Memory-mapped I/O
- Pipeline registers
- Forwarding logic

---

# 17. References

- CPU Architecture Overview
- Control Unit Architecture
- Memory Organization
- Timing Specification
- ISA Encoding
- Design Specification
```