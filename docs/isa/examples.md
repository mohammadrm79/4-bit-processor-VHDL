# Programming and Program-Image Examples

The repository provides an assembler in `scripts/assembler.sh` and `scripts/assembler.awk`. Assembly sources are under `tb/programs/asm/`; generated hexadecimal images are under `tb/programs/bin/`. `instruction_memory` reads one 16-bit hexadecimal word per line.

## Example: add

[`tb/programs/asm/add.asm`](../../tb/programs/asm/add.asm) is assembled as:

```text
MOVI R0,5
MOVI R1,3
ADD R2,R0,R1
HALT
```

Its image, [`tb/programs/bin/add.mem`](../../tb/programs/bin/add.mem), is:

```text
6005
6103
0204
8800
```

After HALT, R2 contains `8`.

## Branch examples

The supplied `jump.asm`, `jz.asm`, and `jc.asm` programs exercise `JMP`, `JZ`, and `JC`. A target is an absolute 11-bit instruction-memory address. Taken transfers update the PC during execute; a non-taken conditional branch continues sequentially.

## Limits

The assembler supports the repository's allocated instructions. `CMP`, `JNZ`, direct immediate memory addressing, labels beyond the assembler's supported syntax, and signed/extended immediate semantics are not CPU features.
