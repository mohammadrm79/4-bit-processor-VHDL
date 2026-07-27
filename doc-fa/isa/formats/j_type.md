# Format Instruction J-Type

Opcodeهای J-type، `JMP`، `JZ` و `JC` هستند.

```text
15        11 10                     0
+------------+------------------------+
|   opcode   |        address         |
+------------+------------------------+
```

Decoder، `instruction[10:0]` را به port `next_address` PC می‌فرستد. در Execute، FSM برای `JMP`، برای `JZ` هنگام set بودن Z و برای `JC` هنگام set بودن C، `pc_load` را assert می‌کند.

## به‌صورت عملی پیاده‌سازی نشده

PC فقط هنگامی `next_address` را load می‌کند که `enable` و `load` هر دو assert باشند. FSM در Execute، `pc_enable` را assert نمی‌کند؛ بنابراین هیچ‌یک از این Instructionها PC را در CPU یکپارچه تغییر نمی‌دهد.

`JNZ` **پیاده‌سازی نشده است**.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | decode پیاده‌سازی‌شده و PC load غیرعملی ثبت شد. |
| 1.0.0 | مشخصات اولیه J-type. |
