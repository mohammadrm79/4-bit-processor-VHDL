# معماری پردازنده

این اسناد یکپارچه‌سازی پیاده‌سازی‌شده `system_top` → `cpu_core` را توضیح می‌دهند.

- [نمای کلی CPU](cpu_overview.md) — entityها، اتصال‌ها و state معماری.
- [مسیر داده](datapath.md) — fieldهای instruction، operandها، ALU، data memory و write-back.
- [واحد کنترل](control_unit.md) — حالت‌ها و سیگنال‌های کنترل `control_fsm`.
- [حافظه](memory.md) — پیاده‌سازی و آدرس‌دهی instruction/data memory.
- [زمان‌بندی](timing.md) — زمان‌بندی state و به‌روزرسانی داده در یک clock.
