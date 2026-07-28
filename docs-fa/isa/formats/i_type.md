# Format Instruction I-Type

Opcodeهای I-type عبارت‌اند از `LOAD`، `STORE` و `MOVI`.

```text
15        11 10      8 7                       0
+------------+---------+-------------------------+
|   opcode   | register|        immediate        |
+------------+---------+-------------------------+
```

| Opcode | میدان Register | رفتار immediate |
|---|---|---|
| LOAD | `Rd[10:8]` | در `cpu_core` برای آدرس‌دهی استفاده نمی‌شود |
| STORE | `[10:8]` Register داده store نیست | در `cpu_core` برای آدرس‌دهی استفاده نمی‌شود |
| MOVI | `Rd[10:8]` | چهار بیت پایین نوشته می‌شوند |

Decoder حتی برای wordهای I-type، `source_a=instruction[7:5]` و `source_b=instruction[4:2]` را جداگانه ارائه می‌کند. در core یکپارچه، `LOAD`، `DMEM[source_b]` را می‌خواند؛ `STORE`، `source_a` را در `DMEM[source_b]` می‌نویسد. این رفتار واقعی، توصیف آدرس مستقیم-immediate را کنار می‌زند.

`MOVI`، `instruction[3:0]` را در Register انتخاب‌شده توسط `[10:8]` می‌نویسد و flagها را update نمی‌کند.

## پیاده‌سازی نشده

آدرس‌دهی memory immediate مستقیم، sign extension immediate و مسیر operand immediate به ALU پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | رفتار memory و immediate I-type اصلاح شد. |
| 1.0.0 | مشخصات اولیه I-type. |
