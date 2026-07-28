# Instructionهای Arithmetic

| Instruction | Opcode | Operation |
|---|---|---|
| ADD | 00000 | `Rd ← Rs1 + Rs2` |
| SUB | 00001 | `Rd ← Rs1 - Rs2` |
| INC | 00010 | `Rd ← Rs1 + 1` |
| DEC | 00011 | `Rd ← Rs1 - 1` |

هر چهار operation در `EXECUTE`، ALU-result register و flag register را enable می‌کنند و سپس در `WRITE_BACK`، `Rd` را از result ثبت‌شده می‌نویسند.

Arithmetic در مقصد modulo 16 است. Z، C و N توسط ALU تولید می‌شوند. V برای ADD و SUB علامت‌دار محاسبه می‌شود و برای INC روی `0111` و DEC روی `1000` نیز set می‌شود.

## پیاده‌سازی نشده

`CMP` پیاده‌سازی نشده است. هیچ Instruction Arithmetic وجود ندارد که فقط flagها را update کند و Register مقصد را ننویسد.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | مشخصات CMP منسوخ حذف و operandها اصلاح شدند. |
| 1.0.0 | مشخصات اولیه Instructionهای Arithmetic. |
