# Datapath Architecture

## Instruction decode

The decoder always assigns:

| Output | Instruction bits |
|---|---|
| Opcode | `[15:11]` |
| Destination register | `[10:8]` |
| Source A | `[7:5]` |
| Source B | `[4:2]` |
| Immediate | `[7:0]` |
| Jump address | `[10:0]` |

For binary R-type operations, `Rd`, `Rs1`, and `Rs2` are active fields. `INC`, `DEC`, `NOT`, `SHL`, and `SHR` use `Rs1` only; `Rs2` remains decoded but does not affect their ALU result. Bits `[1:0]` have no decoded output.

## ALU and write-back

The ALU consumes register-file source A and source B. Its result enters `alu_result_register` for ALU operations. Write-back selects:

| Source | Value |
|---|---|
| `WB_ALU` | Registered ALU result |
| `WB_IMMEDIATE` | `immediate[3:0]` |
| `WB_MEMORY` | Combinational data-memory read |

`MOVI` does not route its immediate through the ALU.

## Data-memory datapath

`memory_address <= "0000000" & register_data_b`. `STORE` supplies `register_data_a` as write data. This means the integrated operation is register-derived, regardless of the I-type immediate field.

## Not Implemented

Immediate-to-ALU selection, immediate data-memory addressing, an address-generation unit, and externally visible N/V flag control are not implemented.

## Revision history

| Version | Description |
|---|---|
| 1.2.0 | Clarified the single-source R-type operations. |
| 1.1.0 | Corrected R-type and memory data paths. |
| 1.0.0 | Initial datapath description. |
