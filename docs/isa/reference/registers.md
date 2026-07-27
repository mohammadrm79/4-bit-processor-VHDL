# Register File Specification

The register file has eight architecturally equivalent 4-bit registers.

| Encoding | Register |
|---|---|
| 000 | R0 |
| 001 | R1 |
| 010 | R2 |
| 011 | R3 |
| 100 | R4 |
| 101 | R5 |
| 110 | R6 |
| 111 | R7 |

Reads are combinational through two independent ports. Writes are synchronous and occur when `write_enable='1'`. Reset synchronously clears all registers. R0 is writable; it is not a constant-zero register.

Only R0–R3 are exported as debug outputs by the CPU top-level; that does not change the accessibility of R4–R7.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Confirmed writeable R0 and implemented interface. |
| 1.0.0 | Initial register-file specification. |
