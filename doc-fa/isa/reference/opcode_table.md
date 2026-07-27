# جدول تخصیص Opcode

این جدول توسط `src/pkg/cpu_pkg.vhdl` تعریف شده است.

| Binary | Hex | Instruction | Format | رفتار یکپارچه |
|---|---:|---|---|---|
| 00000 | 00 | ADD | R | `Rd ← Rs1 + Rs2` |
| 00001 | 01 | SUB | R | `Rd ← Rs1 - Rs2` |
| 00010 | 02 | INC | R | `Rd ← Rs1 + 1` |
| 00011 | 03 | DEC | R | `Rd ← Rs1 - 1` |
| 00100 | 04 | AND | R | `Rd ← Rs1 AND Rs2` |
| 00101 | 05 | OR | R | `Rd ← Rs1 OR Rs2` |
| 00110 | 06 | XOR | R | `Rd ← Rs1 XOR Rs2` |
| 00111 | 07 | NOT | R | `Rd ← NOT Rs1` |
| 01000 | 08 | SHL | R | `Rd ← Rs1 << 1` |
| 01001 | 09 | SHR | R | `Rd ← Rs1 >> 1` |
| 01010 | 0A | LOAD | I | `Rd ← DMEM[Rs2]` |
| 01011 | 0B | STORE | I | `DMEM[Rs2] ← Rs1` |
| 01100 | 0C | MOVI | I | `Rd ← immediate[3:0]` |
| 01101 | 0D | JMP | J | signal PC-load assert می‌شود؛ target در integration load نمی‌شود |
| 01110 | 0E | JZ | J | همان مورد وقتی Z=1 |
| 01111 | 0F | JC | J | همان مورد وقتی C=1 |
| 10000 | 10 | NOP | S | هیچ write معماری ندارد |
| 10001 | 11 | HALT | S | وارد حالت halted می‌شود |

Opcodeهای `10010` تا `11111` تخصیص‌نیافته‌اند. FSM آن‌ها را رد نمی‌کند و عمل صریح Execute/Write Back ندارند.

## پیاده‌سازی نشده

`CMP` و `JNZ` تخصیص نیافته‌اند. `SHL` و `SHR` پیاده‌سازی شده‌اند، نه reserved.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | تخصیص منسوخ با Opcodeهای package جایگزین شد. |
| 1.0.0 | تخصیص اولیه Opcode. |
