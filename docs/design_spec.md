# Design Specification

> **Status:** Implementation-aligned
>
> **Authority:** Current VHDL source

## Implemented CPU

The CPU has a 4-bit datapath, 16-bit instructions, eight 4-bit registers, a 5-bit opcode field, and an 11-bit program counter. It is a single-clock, non-pipelined, multi-cycle design with synchronous active-high reset.

Instruction and data memory are separate RTL components. `instruction_memory` is a combinational 256-word, 16-bit ROM model. Its entity default names `tb/programs/program_add.mem`, while the integrated `cpu_core`/`system_top` default overrides it with `tb/programs/bin/movi.mem`. Data memory is a 256-word, 4-bit memory with combinational reads, synchronous writes, and synchronous clearing on reset.

## Implemented execution state machine

`STATE_RESET → FETCH → DECODE → EXECUTE → WRITE_BACK → FETCH`.

`HALT` transitions from `EXECUTE` to `STATE_HALTED`; it does not enter `WRITE_BACK`. The reset state occupies a clocked FSM state before fetch.

## Implemented instruction set

`ADD`, `SUB`, `INC`, `DEC`, `AND`, `OR`, `XOR`, `NOT`, `SHL`, `SHR`, `LOAD`, `STORE`, `MOVI`, `JMP`, `JZ`, `JC`, `NOP`, and `HALT` are allocated in the package. Exact encodings and operational restrictions are in [isa/reference/opcode_table.md](isa/reference/opcode_table.md).

`CMP` and `JNZ` are **Not Implemented**. Their former documentation is historical only and does not define processor behavior.

## Important implementation limitations

- R-type instructions use `Rd`, `Rs1`, and `Rs2`; they are not two-operand destructive operations.
- Data-memory address selection uses the zero-extended value of `Rs2`; the I-type immediate is not used as an address.
- `MOVI` writes only the low four immediate bits and does not update flags.
- `JMP` and taken `JZ`/`JC` assert both PC load and PC enable in execute, so they load the decoded 11-bit target without a delay slot.
- The instruction-memory text-file initialization is a simulation model; no successful synthesis result is documented.

## Reserved for Future Version

Pipelining, `CMP`, `JNZ`, stack support, interrupts, I/O, additional addressing modes, and any FPGA target are reserved for a future version.

## Revision history

| Version | Description |
|---|---|
| 1.1.0 | Aligned with current RTL. |
| 0.2.0 | Historical ISA-documentation update. |
| 0.1.0 | Initial specification. |
