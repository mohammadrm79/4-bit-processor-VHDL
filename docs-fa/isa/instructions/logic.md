# Instructionهای Logic و Shift

| Instruction | Opcode | Operation |
|---|---|---|
| AND | 00100 | `Rd ← Rs1 AND Rs2` |
| OR | 00101 | `Rd ← Rs1 OR Rs2` |
| XOR | 00110 | `Rd ← Rs1 XOR Rs2` |
| NOT | 00111 | `Rd ← NOT Rs1` |
| SHL | 01000 | `Rd ← Rs1 << 1` |
| SHR | 01001 | `Rd ← Rs1 >> 1` |

هر شش Instruction، result ALU و هر چهار flag را در Execute capture می‌کنند، سپس result ثبت‌شده را در Write Back به `Rd` می‌نویسند. operationهای Logic، C=0 و V=0 تولید می‌کنند، زیرا مقدارهای پیش‌فرض temporary/result ALU چنین هستند. C در `SHL`، MSB پیش از shift و در `SHR`، LSB پیش از shift است.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | shiftهای پیاده‌سازی‌شده و تخصیص Opcode اصلاح شدند. |
| 1.0.0 | مشخصات اولیه Instructionهای Logic. |
