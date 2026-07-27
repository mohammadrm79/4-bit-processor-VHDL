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

- [Encoding](encoding.md)
- [تخصیص Opcode](reference/opcode_table.md)
- [Flagها](reference/flags.md)
- [Timing](reference/timing.md)
- [مثال‌ها](examples.md)

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | بر مبنای تخصیص Opcode VHDL فعلی بازنویسی شد. |
| 1.0.0 | فهرست اولیه ISA. |
