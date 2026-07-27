# Instructionهای Memory و Immediate

| Instruction | Opcode | رفتار واقعی یکپارچه |
|---|---|---|
| LOAD | 01010 | `Rd ← DMEM[Rs2]` |
| STORE | 01011 | `DMEM[Rs2] ← Rs1` |
| MOVI | 01100 | `Rd ← immediate[3:0]` |

Data memory چهار بیت عرض دارد. core، داده source-B Register را برای آدرس ۱۱ بیتی data memory zero-extend می‌کند. میدان immediate I-type آدرس memory را انتخاب نمی‌کند.

`LOAD` در Execute، `memory_read_enable` را assert می‌کند، اما data memory ورودی read-enable ندارد؛ خروجی read آن همواره ترکیبی است. `LOAD` مقدار انتخاب‌شده را در Write Back می‌نویسد. `STORE` در Execute data-memory write enable را assert می‌کند و در همان لبه به‌صورت همزمان می‌نویسد. `MOVI` در Write Back می‌نویسد و flagها را update نمی‌کند.

## پیاده‌سازی نشده

آدرس‌دهی مستقیم مانند `LOAD Rd, Address`، `STORE` با آدرس immediate، modeهای indexed/base-offset و update flag توسط `MOVI` پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | Opcodeها، منبع آدرس و flagهای MOVI اصلاح شدند. |
| 1.0.0 | مشخصات اولیه Instructionهای Memory. |
