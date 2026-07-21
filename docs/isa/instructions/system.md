# System Instructions

> **Project:** RISC-4 Educational CPU
>
> **Document:** System Instruction Set
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../reference/opcode_table.md
> - ../formats/s_type.md
> - ../reference/timing.md

---

# 1. Introduction

System instructions control the execution state of the processor rather than manipulating registers or memory.

ISA Version 1 defines two system instructions:

- NOP
- HALT

These instructions use the **S-Type** instruction format.

---

# 2. Instruction Summary

| Instruction | Opcode | Description |
|------------|--------|-------------|
| NOP | 10000 | No operation |
| HALT | 10001 | Halt processor execution |

---

# 3. NOP

## Opcode

```
10000
```

## Format

S-Type

## Syntax

```asm
NOP
```

## Description

Performs no operation.

The instruction is executed normally through the fetch and decode stages, but no architectural state is modified except the Program Counter.

## RTL

```
PC ← PC + 1
```

## Register Access

None.

## Memory Access

None.

## Status Flags

No flags are modified.

## Processor State

Execution continues normally.

## Example

```asm
NOP
```

---

# 4. HALT

## Opcode

```
10001
```

## Format

S-Type

## Syntax

```asm
HALT
```

## Description

Stops instruction execution by placing the processor into the **HALTED** state.

Execution remains halted until the processor is reset.

## RTL

```
CPU_State ← HALTED
```

## Register Access

None.

## Memory Access

None.

## Status Flags

No flags are modified.

## Processor State

Execution stops.

## Example

```asm
HALT
```

---

# 5. Execution Characteristics

| Property | NOP | HALT |
|----------|-----|-------|
| Register Read | No | No |
| Register Write | No | No |
| Memory Read | No | No |
| Memory Write | No | No |
| Status Flags Updated | No | No |
| Program Counter Updated | Yes | No* |

\* After entering the **HALTED** state, the Program Counter no longer advances until a processor reset occurs.

---

# 6. Processor State Machine

```
               Reset
                 │
                 ▼
            +-----------+
            |  RUNNING  |
            +-----------+
                 │
             HALT
                 │
                 ▼
            +-----------+
            |  HALTED   |
            +-----------+
                 │
               Reset
                 │
                 └──────────────► RUNNING
```

---

# 7. Hardware Requirements

System instructions require:

- Instruction Decoder
- Control Unit
- Processor State Register
- Program Counter Control Logic

The HALT instruction additionally requires execution control logic capable of disabling instruction fetch while the processor is halted.

---

# 8. Reserved Encoding

The Reserved field of the S-Type format shall always be encoded as zero.

Software shall not rely on any value stored in the Reserved field.

Future ISA revisions may assign additional meanings to reserved bits.

---

# 9. Future Extensions

Future ISA revisions may introduce additional system-level instructions, including:

- RESET
- WAIT
- SLEEP
- BREAK
- INT
- IRET
- EI (Enable Interrupts)
- DI (Disable Interrupts)

These instructions are reserved for future ISA versions.

---

# 10. Design Notes

System instructions are intentionally isolated from arithmetic, logical, memory, and control instructions.

This separation simplifies the instruction decoder and provides a dedicated extension point for future processor features.

---

# 11. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial system instruction specification |
