# Format Instruction J-Type

Opcodeهای J-type، `JMP`، `JZ` و `JC` هستند.

```text
15        11 10                     0
+------------+------------------------+
|   opcode   |        address         |
+------------+------------------------+
```

Decoder، `instruction[10:0]` را به port `next_address` PC می‌فرستد. در Execute، FSM برای `JMP`، برای `JZ` هنگام set بودن Z و برای `JC` هنگام set بودن C، `pc_load` را assert می‌کند.

## اجرا

component `pc` وقتی `next_address` را load می‌کند که `enable` و `load` هر دو assert باشند. FSM برای `JMP` و `JZ` و `JC` گرفته‌شده، هر دو سیگنال را در execute assert می‌کند؛ پس این Instructionها PC را در CPU یکپارچه تغییر می‌دهند. شرط نادرست هر دو سیگنال را low نگه می‌دارد و اجرای ترتیبی از PC تعیین‌شده در fetch ادامه می‌یابد.

`JNZ` **پیاده‌سازی نشده است**.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | decode پیاده‌سازی‌شده و PC load غیرعملی ثبت شد. |
| 1.0.0 | مشخصات اولیه J-type. |
