# Timing Architecture

> **Project:** RISC-4 Educational CPU
>
> **Document:** Timing Architecture
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents**
>
> - ../design_spec.md
> - ../design_decisions.md
> - ../isa/reference/timing.md
> - control_unit.md
> - cpu_overview.md

---

# 1. Introduction

This document defines the timing model of the RISC-4 Educational CPU.

The processor is intentionally designed as a non-pipelined, multi-cycle processor operating from a single synchronous clock domain.

---

# 2. Design Goals

The timing architecture is designed to provide:

- Predictable execution
- Simple control logic
- Deterministic behavior
- Easy verification
- Portable synthesis

---

# 3. Clock Domain

The processor operates entirely within a single clock domain.

| Property | Value |
|----------|-------|
| Clock Domains | 1 |
| Clock Edge | Rising Edge |
| Clock Gating | Not Used |
| Generated Clocks | None |

All synchronous modules receive the same clock signal.

---

# 4. Reset Timing

Reset behavior follows DD-009.

| Property | Value |
|----------|-------|
| Reset Type | Synchronous |
| Active Level | High |
| Scope | Entire Processor |

During reset:

- Program Counter is cleared.
- Instruction Register is cleared.
- Processor Status Register is cleared.
- Control FSM returns to RESET state.
- General-Purpose Registers are initialized to zero.

---

# 5. Processor Cycle

Instruction execution consists of four sequential stages.

```
Fetch
   ↓
Decode
   ↓
Execute
   ↓
Write Back
```

Only one instruction is active at any time.

---

# 6. Instruction Timing

The nominal execution latency is four clock cycles.

| Stage | Clock Cycle |
|--------|-------------|
| Fetch | Cycle 1 |
| Decode | Cycle 2 |
| Execute | Cycle 3 |
| Write Back | Cycle 4 |

After Write Back, execution immediately begins fetching the next instruction.

---

# 7. Fetch Stage

During Fetch:

- Program Counter is presented to Instruction Memory.
- Instruction Memory returns a 16-bit instruction.
- Instruction Register captures the instruction.
- Program Counter is prepared for update.

Outputs produced:

- Instruction Register
- Next Program Counter value

---

# 8. Decode Stage

During Decode:

The Control Unit performs:

- Opcode decoding
- Instruction format detection
- Register field extraction
- Immediate extraction
- Control signal generation

No architectural state is modified during Decode.

---

# 9. Execute Stage

The Execute stage performs the operation defined by the instruction.

Possible activities include:

- ALU computation
- Memory read
- Memory write
- Branch evaluation
- Jump target computation

Status flags are updated when required.

---

# 10. Write Back Stage

During Write Back:

Results are committed to the architectural state.

Possible write-back destinations include:

- Register File
- Program Counter
- Processor Status Register

Instructions without destination operands simply complete execution.

---

# 11. Program Counter Timing

The Program Counter normally advances once per instruction.

Normal execution:

```
PC ← PC + 1
```

Control instructions may override the increment.

Examples:

- JMP
- JZ
- JC

---

# 12. Register File Timing

Read operations:

- Combinational
- Available during Decode

Write operations:

- Synchronous
- Occur during Write Back

This guarantees deterministic register updates.

---

# 13. Memory Timing

Instruction Memory

- Read-only during execution
- Accessed during Fetch

Data Memory

- Read during Execute
- Written during Execute

Memory timing assumes single-cycle access.

---

# 14. Status Register Timing

Processor status flags are updated only by instructions that define flag behavior.

Flags become architecturally visible after the Execute stage and remain valid during Write Back and subsequent instruction execution.

---

# 15. Control Flow Timing

Conditional branches evaluate conditions during Execute.

If the branch is taken:

- Program Counter is updated.
- Next Fetch uses the new address.

Otherwise:

```
PC ← PC + 1
```

No speculative execution is performed.

---

# 16. Timing Assumptions

The implementation assumes:

- No wait states
- No memory stalls
- No cache
- No interrupts
- No DMA
- No asynchronous peripherals

Future processor revisions may relax these assumptions.

---

# 17. Timing Summary

| Component | Timing |
|-----------|--------|
| Clock Domains | 1 |
| Reset | Synchronous |
| Instruction Cycles | 4 |
| Register Read | Combinational |
| Register Write | Synchronous |
| Instruction Memory | Single-cycle Read |
| Data Memory Read | Execute Stage |
| Data Memory Write | Execute Stage |
| Pipeline | None |

---

# 18. References

- Design Specification
- CPU Overview
- Control Unit Architecture
- ISA Timing Reference
- Design Decisions DD-005, DD-007, DD-008, DD-009