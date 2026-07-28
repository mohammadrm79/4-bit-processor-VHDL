# معماری Memory

## Instruction memory

`instruction_memory` به‌طور پیش‌فرض مدلی ۲۵۶ × ۱۶ بیتی است. با `hread` از فایل hexadecimal مقداردهی می‌شود و readهای آن ترکیبی هستند. پیش‌فرض entity برای `PROGRAM_FILE` برابر `tb/programs/program_add.mem` است، اما `cpu_core` و `system_top` آن را با مسیر موجود `tb/programs/bin/movi.mem` override می‌کنند. آدرس خارج از `DEPTH` یا دارای مقدار unknown، Instruction تمام-صفر برمی‌گرداند.

## Data memory

`data_memory` به‌طور پیش‌فرض مدل ۲۵۶ × ۴ بیتی است. در Reset به‌صورت همزمان صفر می‌شود، read ترکیبی و write در لبه بالارونده هنگام `write_enable='1'` است. readهای خارج از محدوده صفر برمی‌گردانند.

## رفتار address و access یکپارچه

اگرچه Instructionهای I-type شامل `immediate[7:0]` هستند، `cpu_core` از آن برای آدرس‌دهی data memory استفاده نمی‌کند. source B Register file را تا ۱۱ بیت zero-extend می‌کند. read data memory همیشه از نظر الکتریکی در دسترس است؛ `memory_read_enable` توسط FSM تولید می‌شود اما به `data_memory` متصل نیست.

## پیاده‌سازی نشده

آدرس‌دهی immediate مستقیم، bus memory خارجی، wait stateهای memory، حفاظت memory و پیاده‌سازی ROM Instruction امن برای Synthesis پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | اندازه memory، مقداردهی و منبع آدرس واقعی اصلاح شدند. |
| 1.0.0 | توصیف اولیه معماری memory. |
