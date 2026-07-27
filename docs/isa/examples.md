# Programming and Program-Image Examples

There is no assembler in this repository. Program files contain one 16-bit hexadecimal word per line and are loaded by `instruction_memory`.

## Default integration image

`tb/programs/program_add.mem` contains:

| Word | Meaning under current decode |
|---|---|
| `6109` | `MOVI R1, 9` |
| `6204` | `MOVI R2, 4` |
| `0328` | `ADD R3, R1, R2` |
| `8800` | `HALT` |

The intended architectural result is R3=13 (`1101`), not R3=8. The current integration testbench expectation of R3=8 is inconsistent with this image.

## Logic image

`tb/programs/program_logic.mem` contains `2120`, `3230`, `4310`, and `F800`. The last word is an unallocated opcode, not `HALT`: `HALT` has opcode `10001`, whose high hex representation begins `8`. The image therefore does not halt through the implemented HALT instruction.

## Jump image

`tb/programs/program_jump.mem` ends with `F800`, also an unallocated opcode. Even correctly encoded jump instructions would not redirect the PC in the current integration because of the PC-enable limitation.

## Not Implemented

Assembly syntax for `CMP`, `JNZ`, direct immediate loads/stores, labels, and an assembler are not implemented by the repository.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Replaced non-implemented assembly examples with actual program images. |
| 1.0.0 | Initial programming examples. |
