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

## کنترل جریان

`JMP` در `EXECUTE` هر دو سیگنال `pc_enable` و `pc_load` را assert می‌کند. `JZ` هنگام `zero_flag='1'` و `JC` هنگام `carry_flag='1'` همین کار را می‌کنند. چون `pc` برای load کردن `next_address` هر دو سیگنال را لازم دارد، این Instructionها در لبه execute، PC را به `jump_address` یازده‌بیتی decoder هدایت می‌کنند. branch شرطیِ برقرارنشده هیچ‌کدام از سیگنال‌ها را assert نمی‌کند؛ PC پیش‌تر در fetch افزایش یافته است.

## پیاده‌سازی نشده

ورودی branchهای N/V، `JNZ`، trap Opcode نامعتبر، read gating memory و کنترل memory با latency متغیر پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | رفتار state/control و محدودیت jump فعلی به‌روزرسانی شد. |
| 1.0.0 | توصیف اولیه Control Unit. |
