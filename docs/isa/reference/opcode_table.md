# Opcode Allocation Table

The table is defined by `src/pkg/cpu_pkg.vhdl`.

| Binary | Hex | Instruction | Format | Integrated behavior |
|---|---:|---|---|---|
| 00000 | 00 | ADD | R | `Rd ← Rs1 + Rs2` |
| 00001 | 01 | SUB | R | `Rd ← Rs1 - Rs2` |
| 00010 | 02 | INC | R | `Rd ← Rs1 + 1` |
| 00011 | 03 | DEC | R | `Rd ← Rs1 - 1` |
| 00100 | 04 | AND | R | `Rd ← Rs1 AND Rs2` |
| 00101 | 05 | OR | R | `Rd ← Rs1 OR Rs2` |
| 00110 | 06 | XOR | R | `Rd ← Rs1 XOR Rs2` |
| 00111 | 07 | NOT | R | `Rd ← NOT Rs1` |
| 01000 | 08 | SHL | R | `Rd ← Rs1 << 1` |
| 01001 | 09 | SHR | R | `Rd ← Rs1 >> 1` |
| 01010 | 0A | LOAD | I | `Rd ← DMEM[Rs2]` |
| 01011 | 0B | STORE | I | `DMEM[Rs2] ← Rs1` |
| 01100 | 0C | MOVI | I | `Rd ← immediate[3:0]` |
| 01101 | 0D | JMP | J | `PC ← address[10:0]` |
| 01110 | 0E | JZ | J | `PC ← address[10:0]` when Z=1 |
| 01111 | 0F | JC | J | `PC ← address[10:0]` when C=1 |
| 10000 | 10 | NOP | S | No architectural write |
| 10001 | 11 | HALT | S | Enters halted state |

Opcodes `10010` through `11111` are unallocated. They are not rejected by the FSM and have no explicitly asserted execute/write-back actions.

## Not Implemented

`CMP` and `JNZ` are not allocated. `SHL` and `SHR` are implemented, not reserved.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Replaced obsolete allocation with package-defined opcodes. |
| 1.0.0 | Initial opcode allocation. |
