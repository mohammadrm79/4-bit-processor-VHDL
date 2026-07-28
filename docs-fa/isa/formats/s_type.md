# Format Instruction S-Type

`NOP` (`10000`) و `HALT` (`10001`) Opcodeهای system هستند. `opcode_to_format` هر Opcode تخصیص‌نیافته را نیز S-type طبقه‌بندی می‌کند.

```text
15        11 10                     0
+------------+------------------------+
|   opcode   |      unused bits       |
+------------+------------------------+
```

یازده بیت پایین بر رفتار `NOP`، `HALT` یا Opcode تخصیص‌نیافته اثر ندارند.

`NOP` عمل Execute یا Write Back assert‌شده‌ای ندارد. `HALT` از `EXECUTE` به `STATE_HALTED` منتقل می‌شود؛ `halted='1'` فقط در همان حالت assert می‌شود.

Opcodeهای تخصیص‌نیافته trap یا halt نمی‌شوند؛ بدون عمل صریح از Execute/Write Back عبور می‌کنند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | رفتار Opcode تخصیص‌نیافته واقعی اضافه شد. |
| 1.0.0 | مشخصات اولیه S-type. |
