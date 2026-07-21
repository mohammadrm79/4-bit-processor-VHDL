# S-Type Instruction Format

> **Project:** RISC-4 Educational CPU
>
> **Document:** S-Type Instruction Format
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../encoding.md
> - ../reference/opcode_table.md

---

# 1. Introduction

The S-Type (System-Type) instruction format is reserved for processor-level operations that are not part of the arithmetic, logical, memory, or control-flow instruction groups.

System instructions affect the processor execution state rather than the datapath.

ISA Version 1 defines two system instructions:

- NOP
- HALT

---

# 2. Instruction Layout

```
15          11 10                     0

+-------------+------------------------+
|   OPCODE    |        Reserved        |
+-------------+------------------------+

     5 bits          11 bits
```

---

# 3. Field Description

| Field | Width | Description |
|--------|------:|-------------|
| Opcode | 5 bits | Operation selector |
| Reserved | 11 bits | Reserved, must be encoded as zero |

---

# 4. Supported Instructions

| Instruction | Description |
|-------------|-------------|
| NOP | No operation |
| HALT | Stop processor execution |

---

# 5. Reserved Field

The Reserved field shall always be encoded as zero.

Software shall not assign any meaning to these bits.

Future ISA revisions may redefine portions of this field while preserving backward compatibility whenever possible.

---

# 6. Register Access

System instructions do not access the register file.

| Resource | Access |
|----------|--------|
| Register File | No |
| Data Memory | No |
| Instruction Memory | Fetch Only |
| Program Counter | Internal |
| Processor Status Register | Unchanged |

---

# 7. Status Flags

System instructions do not modify the Processor Status Register.

| Instruction | Z | C | N | V |
|-------------|---|---|---|---|
| NOP | — | — | — | — |
| HALT | — | — | — | — |

Legend:

- — Unchanged

---

# 8. RTL Behavior

## NOP

The processor performs no architectural state modification.

```
PC ← PC + 1
```

No registers, memory locations, or status flags are modified.

---

## HALT

The processor enters the halted state.

```
CPU_State ← HALTED
```

Instruction execution stops until a system reset occurs.

The Program Counter is no longer updated while the processor remains halted.

---

# 9. Execution Behavior

## NOP

Execution sequence:

1. Fetch instruction
2. Decode instruction
3. No operation performed
4. Advance Program Counter

---

## HALT

Execution sequence:

1. Fetch instruction
2. Decode instruction
3. Enter HALTED state
4. Stop instruction execution

---

# 10. Hardware Notes

The S-Type format requires minimal hardware.

NOP requires no dedicated execution logic.

HALT requires a processor state register capable of indicating the halted state.

The Control Unit shall inhibit further instruction execution while the processor remains halted.

---

# 11. Example Encodings

Example:

```asm
NOP
```

| Field | Value |
|--------|-------|
| Opcode | NOP |
| Reserved | 00000000000 |

---

Example:

```asm
HALT
```

| Field | Value |
|--------|-------|
| Opcode | HALT |
| Reserved | 00000000000 |

---

# 12. Future Extensions

The S-Type instruction format reserves space for future processor management instructions.

Possible additions include:

- RESET
- WAIT
- SLEEP
- BREAK
- INT
- IRET
- ENABLE INTERRUPTS
- DISABLE INTERRUPTS

These instructions are not part of ISA Version 1.

---

# 13. Decoder Requirements

When an S-Type instruction is decoded:

1. Decode the opcode.
2. Verify that the Reserved field is zero.
3. Execute the corresponding system operation.
4. Ignore any future extension bits not defined by the current ISA revision.

---

# 14. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial S-Type instruction format specification |
