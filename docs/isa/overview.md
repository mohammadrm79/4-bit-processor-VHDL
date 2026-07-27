# Instruction Set Architecture Overview

## Architectural values

| Property | Value |
|---|---|
| Datapath | 4 bits |
| Instruction | 16 bits |
| Opcode | 5 bits |
| Register file | Eight 4-bit registers |
| PC/jump field | 11 bits |
| Memory models | Separate instruction and data memories |
| Execution | Non-pipelined FSM |

## Formats

The package classifies ALU/logic/shift opcodes as R-type; `LOAD`, `STORE`, and `MOVI` as I-type; `JMP`, `JZ`, and `JC` as J-type; and all other opcodes as S-type. The decoder exposes common bit slices independently of format.

## Implemented programming model

R-type operations write `Rd[10:8]` and read `Rs1[7:5]` and `Rs2[4:2]`. `INC`, `DEC`, and `NOT` use source A; source B is still decoded but does not affect those ALU operations.

`MOVI` writes `immediate[3:0]`. In the integrated memory datapath, `LOAD` reads from the address held in `Rs2`, and `STORE` writes `Rs1` to that address. The immediate is not used as a memory address.

## Control-flow status

`JMP`, `JZ`, and `JC` have allocated opcodes and the FSM asserts `pc_load` for them. Because PC enable is not asserted during execute, their jump target is not loaded. They are therefore **Not Functionally Implemented** as control transfers.

## Reserved for Future Version

`CMP`, `JNZ`, signed/extended immediate semantics, direct immediate memory addressing, and branches based on N/V are reserved for a future version.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Corrected instruction and control-flow status. |
| 1.0.0 | Initial ISA overview. |
