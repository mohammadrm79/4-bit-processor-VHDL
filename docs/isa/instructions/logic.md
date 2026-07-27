# Logic and Shift Instructions

| Instruction | Opcode | Operation |
|---|---|---|
| AND | 00100 | `Rd ← Rs1 AND Rs2` |
| OR | 00101 | `Rd ← Rs1 OR Rs2` |
| XOR | 00110 | `Rd ← Rs1 XOR Rs2` |
| NOT | 00111 | `Rd ← NOT Rs1` |
| SHL | 01000 | `Rd ← Rs1 << 1` |
| SHR | 01001 | `Rd ← Rs1 >> 1` |

All six instructions capture the ALU result and all four flags in execute, then write the registered result to `Rd` in write-back. Logic operations produce C=0 and V=0 because the ALU temporary/result defaults set those values. `SHL` C is the pre-shift MSB; `SHR` C is the pre-shift LSB.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Added implemented shifts and corrected opcode allocation. |
| 1.0.0 | Initial logic instruction specification. |
