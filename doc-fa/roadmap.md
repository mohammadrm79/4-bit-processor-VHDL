# نقشه راه پروژه

## محتوای تکمیل‌شده فعلی مخزن

- منبع VHDL package، datapath، memory، control و top-level وجود دارد.
- منبع Testbenchهای unit و integration وجود دارد.
- scriptهای lint، Simulation، Synthesis و clean وجود دارند.
- مستندات ISA و معماری با RTL فعلی هم‌راستا هستند.

## محدودیت‌های فعلی که باید رفع شوند

- jumpهای یکپارچه PC را load نمی‌کنند، زیرا PC load enable نشده است.
- Instructionهای memory از آدرس مشتق‌شده از Register استفاده می‌کنند، نه میدان immediate.
- چند Testbench unit interfaceهایی دارند که با entity DUT فعلی منطبق نیستند.
- نتیجه مورد انتظار Testbench integration با `program_add.mem` منطبق نیست.
- Makefile target ندارد؛ script Synthesis به path ناموجود mux اشاره می‌کند و `alu_result_register.vhdl` را حذف می‌کند.
- scriptهای lint و Simulation هر دو `src/rtl/common/mux.vhdl` را analyse می‌کنند؛ خطای syntax فعلی آن از تکمیل این جریان‌های پیکربندی‌شده جلوگیری می‌کند.

## رزرو برای نسخه آینده

موارد زیر پیاده‌سازی نشده‌اند: `CMP`، `JNZ`، modeهای آدرس‌دهی افزوده، call/return، stack، interrupt، I/O، Pipeline، استقرار FPGA، closure پوشش و نتیجه Synthesis معتبر.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.2.0 | محدودیت syntax جریان پیکربندی‌شده اضافه شد. |
| 1.1.0 | ادعاهای برنامه‌ریزی با وضعیت فعلی مخزن جایگزین شد. |
| 1.0.0 | نقشه راه اولیه. |
