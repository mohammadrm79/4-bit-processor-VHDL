# Instruction Timing Specification

> **Project:** RISC-4 Educational CPU
>
> **Document:** Instruction Timing Specification
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../overview.md
> - opcode_table.md
> - ../instructions/
> - ../../design_decisions.md

---

# 1. Introduction

This document defines the execution timing model of the RISC-4 Educational CPU.

The processor implements a **multi-cycle execution model**, where each instruction progresses through a sequence of execution stages.

The primary objectives of this design are:

- Simplicity
- Hardware modularity
- Ease of debugging
- Educational clarity

---

# 2. Execution Model

Each instruction executes sequentially.

Only one instruction is active inside the processor at any given time.

There is:

- No pipelining
- No superscalar execution
- No speculative execution
- No out-of-order execution

---

# 3. Instruction Cycle

Each instruction passes through the following stages.

```
        +-------+
        | Fetch |
        +-------+
             │
             ▼
        +--------+
        | Decode |
        +--------+
             │
             ▼
        +---------+
        | Execute |
        +---------+
             │
             ▼
       +------------+
       | Write Back |
       +------------+
             │
             ▼
      Next Instruction
```

---

# 4. Pipeline Stages

Although the processor is **not pipelined**, the execution cycle is conceptually divided into four stages.

## 4.1 Fetch (IF)

Operations:

- Read instruction memory
- Load Instruction Register (IR)
- Increment Program Counter (unless overridden)

Hardware used:

- Program Counter
- Instruction Memory
- Instruction Register

---

## 4.2 Decode (ID)

Operations:

- Decode opcode
- Determine instruction format
- Read register operands
- Generate control signals

Hardware used:

- Instruction Decoder
- Register File
- Control Unit

---

## 4.3 Execute (EX)

Operations:

Depends on instruction type.

Examples:

- Arithmetic operation
- Logical operation
- Memory address generation
- Branch evaluation

Hardware used:

- ALU
- Immediate Generator
- Branch Logic

---

## 4.4 Write Back (WB)

Operations:

- Write ALU result
- Write memory data
- Update destination register
- Update status flags (when required)

Hardware used:

- Register File
- Processor Status Register

---

# 5. Typical Execution Time

| Stage | Cycles |
|---------|-------:|
| Fetch | 1 |
| Decode | 1 |
| Execute | 1 |
| Write Back | 1 |

Total:

```
4 Clock Cycles
```

---

# 6. Instruction Timing

| Instruction Category | Cycles |
|----------------------|-------:|
| Arithmetic | 4 |
| Logic | 4 |
| Memory | 4 |
| Control | 4 |
| System | 4 |

ISA Version 1 uses a fixed execution latency for every instruction.

---

# 7. Branch Timing

Conditional branches are evaluated during the Execute stage.

If the branch condition is true:

```
PC ← Target Address
```

Otherwise:

```
PC ← PC + 1
```

Because the processor is not pipelined, there are:

- No branch hazards
- No branch prediction
- No branch delay slots

---

# 8. HALT Timing

Execution sequence:

Cycle 1

```
Fetch HALT
```

Cycle 2

```
Decode HALT
```

Cycle 3

```
Enter HALTED State
```

Cycle 4

```
Instruction execution stops
```

After entering the HALTED state, no further instructions are fetched until a processor reset occurs.

---

# 9. Reset Timing

When Reset is asserted:

- Program Counter is cleared.
- Processor Status Register is cleared.
- Register File is initialized.
- Processor State becomes RUNNING.

The first instruction is fetched on the next execution cycle after reset is released.

---

# 10. Design Rationale

A fixed multi-cycle execution model provides several advantages:

- Simple finite-state machine
- Predictable instruction timing
- Easier RTL verification
- Easier waveform analysis
- Straightforward hardware implementation

Although this approach is not optimized for performance, it is well suited for an educational processor.

---

# 11. Future Enhancements

Future processor revisions may introduce:

- Variable-cycle instructions
- Memory wait states
- Pipelined execution
- Branch prediction
- Instruction prefetch
- Cache support

These features are outside the scope of ISA Version 1.

---

# 12. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial timing specification |
