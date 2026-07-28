# مرجع ISA RISC-4

این مرجع ISA، تخصیص Opcode و رفتار پیاده‌سازی‌شده در VHDL فعلی را توصیف می‌کند و رفتار آرمانی را تعریف نمی‌کند.

## Instructionهای پیاده‌سازی‌شده

| کلاس | Instructionها |
|---|---|
| Arithmetic | ADD, SUB, INC, DEC |
| Logic/shift | AND, OR, XOR, NOT, SHL, SHR |
| Memory/immediate | LOAD, STORE, MOVI |
| Control | JMP, JZ, JC |
| System | NOP, HALT |

`CMP` و `JNZ` **پیاده‌سازی نشده‌اند**. Opcodeهای reserved trap صریح ندارند و در FSM مانند no-op اجرا می‌شوند.

## نقشه مرجع

- [نمای کلی](overview.md) و [encoding](encoding.md)
- Formatها: [R-type](formats/r_type.md)، [I-type](formats/i_type.md)، [J-type](formats/j_type.md) و [S-type](formats/s_type.md)
- Instructionها: [arithmetic](instructions/arithmetic.md)، [logic و shift](instructions/logic.md)، [memory و immediate](instructions/memory.md)، [کنترل جریان](instructions/control.md) و [system](instructions/system.md)
- مرجع: [تخصیص opcode](reference/opcode_table.md)، [registerها](reference/registers.md)، [flagها](reference/flags.md) و [timing](reference/timing.md)
- [مثال‌های program image](examples.md)

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | بر مبنای تخصیص Opcode VHDL فعلی بازنویسی شد. |
| 1.0.0 | فهرست اولیه ISA. |
