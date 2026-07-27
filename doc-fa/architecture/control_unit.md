# معماری Control Unit

`control_fsm` Clock، Reset، Opcode، flag Z و flag C را دریافت می‌کند. state، enableهای PC/IR، enableهای Register و flags، signalهای enable memory، operation ALU، source Write Back، enable register-result ALU و `halted` را تولید می‌کند.

## حالت‌ها

| حالت | رفتار |
|---|---|
| `STATE_RESET` | enable عملیاتی assert نشده است؛ حالت بعدی `FETCH` است. |
| `FETCH` | IR enable و PC enable assert می‌شوند. |
| `DECODE` | enable عملیاتی assert نشده است. |
| `EXECUTE` | کنترل ALU، flag، memory-write یا PC-load وابسته به Opcode است. |
| `WRITE_BACK` | برای Instructionهای لازم مقدار ALU، immediate یا memory را می‌نویسد. |
| `STATE_HALTED` | `halted` را assert می‌کند و باقی می‌ماند. |

`HALT` مستقیماً از `EXECUTE` وارد `STATE_HALTED` می‌شود. `NOP` و Opcodeهای reserved در Execute/Write Back عملی ندارند و توالی حالت عادی را ادامه می‌دهند.

## محدودیت Control flow

`JMP`، `JZ` و `JC` در `EXECUTE`، `pc_load` را assert می‌کنند. component PC فقط وقتی `enable='1'` باشد load می‌کند و `pc_enable` در `EXECUTE` assert نیست. بنابراین این Instructionها در طراحی یکپارچه PC را redirect نمی‌کنند.

## پیاده‌سازی نشده

ورودی branchهای N/V، `JNZ`، trap Opcode نامعتبر، read gating memory و کنترل memory با latency متغیر پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | رفتار state/control و محدودیت jump فعلی به‌روزرسانی شد. |
| 1.0.0 | توصیف اولیه Control Unit. |
