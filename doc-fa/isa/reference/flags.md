# Flagهای وضعیت پردازنده

`flags_register` چهار مقدار یک‌بیتی Z (zero)، C (carry)، N (negative) و V (overflow) ذخیره می‌کند. به‌صورت همزمان به صفر Reset می‌شود. core فقط Z و C را به `control_fsm` وصل می‌کند؛ N و V ذخیره می‌شوند اما در کنترل استفاده نمی‌شوند.

## خروجی‌های ALU

| Flag | پیاده‌سازی |
|---|---|
| Z | وقتی result چهار بیتی ALU برابر `0000` است set می‌شود. |
| N | بیت ۳ result. |
| C | بیت ۴ temporary result پنج‌بیتی ALU. |
| V | فقط برای ADD و SUB محاسبه می‌شود؛ در غیر این صورت پیش‌فرض ۰ است. |

برای هر Instruction ALU (`ADD` تا `SHR`)، FSM در Execute flag capture را enable می‌کند. `MOVI`، `LOAD`، `STORE`، `NOP`، `HALT` و همه Opcodeهای control flag capture را enable نمی‌کنند.

کد convention جداگانه «بدون borrow» را برای subtraction پیاده‌سازی نمی‌کند؛ C دقیقاً high bit temporary result است.

## پیاده‌سازی نشده

`CMP`، `JNZ`، دسترسی مستقیم software به flagها و branchهای شرطی N/V پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | قواعد write flag و semantics subtraction به‌روزرسانی شدند. |
| 1.0.0 | مشخصات اولیه flagها. |
