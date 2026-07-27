# Memory and Immediate Instructions

| Instruction | Opcode | Actual integrated behavior |
|---|---|---|
| LOAD | 01010 | `Rd ← DMEM[Rs2]` |
| STORE | 01011 | `DMEM[Rs2] ← Rs1` |
| MOVI | 01100 | `Rd ← immediate[3:0]` |

Data memory is 4 bits wide. The core zero-extends source-B register data to form its 11-bit data-memory address. The I-type immediate field does not select the memory address.

`LOAD` asserts `memory_read_enable` in execute, but data memory has no read-enable input; its read output is combinational at all times. `LOAD` writes the selected value during write-back. `STORE` asserts data-memory write enable in execute and writes synchronously at that edge. `MOVI` writes in write-back and does not update flags.

## Not Implemented

Direct addressing such as `LOAD Rd, Address`, immediate-address `STORE`, indexed/base-offset modes, and flag updates by `MOVI` are not implemented.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected opcodes, address source, and MOVI flags. |
| 1.0.0 | Initial memory instruction specification. |
