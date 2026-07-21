# Control Flow Instructions

> **Project:** RISC-4 Educational CPU
>
> **Document:** Control Flow Instruction Set
>
> **Version:** 1.0.0
>
> **Status:** Frozen
>
> **Related Documents:**
>
> - ../reference/opcode_table.md
> - ../reference/flags.md
> - ../formats/j_type.md

---

# 1. Introduction

Control flow instructions modify the normal sequential execution of a program.

Instead of allowing the Program Counter (PC) to increment normally, these instructions may load a new instruction address into the Program Counter.

Conditional branch instructions evaluate the Processor Status Register before deciding whether the branch is taken.

---

# 2. Instruction Summary

| Instruction | Opcode | Description |
|------------|--------|-------------|
| JMP | 01100 | Unconditional jump |
| JZ | 01101 | Jump if Zero flag is set |
| JNZ | 01110 | Jump if Zero flag is clear |
| JC | 01111 | Jump if Carry flag is set |

---

# 3. Program Counter Behavior

During normal execution:

```
PC ← PC + 1
```

A control instruction may override this behavior.

If the branch condition is satisfied:

```
PC ← Address
```

Otherwise:

```
PC ← PC + 1
```

---

# 4. JMP

## Opcode

```
01100
```

## Format

J-Type

## Syntax

```asm
JMP Address
```

## Description

Performs an unconditional jump to the specified instruction address.

## RTL

```
PC ← Address
```

## Flags

No flags are modified.

## Example

```asm
JMP 64
```

---

# 5. JZ

## Opcode

```
01101
```

## Format

J-Type

## Syntax

```asm
JZ Address
```

## Description

Transfers control if the Zero flag is set.

## RTL

```
if Z = 1 then
    PC ← Address
else
    PC ← PC + 1
end if
```

## Flags

No flags are modified.

## Example

```asm
CMP R1, R2
JZ 100
```

---

# 6. JNZ

## Opcode

```
01110
```

## Format

J-Type

## Syntax

```asm
JNZ Address
```

## Description

Transfers control if the Zero flag is clear.

## RTL

```
if Z = 0 then
    PC ← Address
else
    PC ← PC + 1
end if
```

## Flags

No flags are modified.

## Example

```asm
CMP R1, R2
JNZ 32
```

---

# 7. JC

## Opcode

```
01111
```

## Format

J-Type

## Syntax

```asm
JC Address
```

## Description

Transfers control if the Carry flag is set.

## RTL

```
if C = 1 then
    PC ← Address
else
    PC ← PC + 1
end if
```

## Flags

No flags are modified.

## Example

```asm
ADD R1, R2
JC 48
```

---

# 8. Execution Characteristics

| Property | Value |
|----------|-------|
| Instruction Format | J-Type |
| Register Read | No |
| Register Write | No |
| Data Memory Access | No |
| Status Flags Modified | No |
| Program Counter Modified | Yes |

---

# 9. Hardware Requirements

Control instructions require:

- Program Counter (PC)
- Instruction Decoder
- Branch Decision Logic
- Processor Status Register
- PC Multiplexer
- Control Unit

---

# 10. Branch Decision Logic

The Control Unit evaluates the branch condition according to the decoded opcode.

| Instruction | Branch Condition |
|------------|------------------|
| JMP | Always |
| JZ | Z = 1 |
| JNZ | Z = 0 |
| JC | C = 1 |

If the condition evaluates to **false**, execution continues sequentially.

---

# 11. Future Extensions

Possible future control instructions include:

- CALL
- RET
- JN (Jump if Negative)
- JV (Jump if Overflow)
- Relative Branch
- Branch with Link

These instructions are reserved for future ISA revisions.

---

# 12. Revision History

| Version | Description |
|----------|-------------|
| 1.0.0 | Initial control flow instruction specification |
