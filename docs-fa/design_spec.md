# مشخصات طراحی

> **وضعیت:** هم‌راستا با پیاده‌سازی
>
> **مرجع:** منبع VHDL فعلی

## CPU پیاده‌سازی‌شده

CPU دارای datapath چهار بیتی، Instructionهای ۱۶ بیتی، هشت Register چهار بیتی، میدان Opcode پنج بیتی و Program Counter یازده بیتی است. این طراحی تک-Clock، بدون Pipeline، چندچرخه‌ای و دارای Reset همزمان فعال-بالا است.

Instruction memory و data memory دو component RTL جدا هستند. `instruction_memory` یک مدل ROM ترکیبی ۲۵۶ word شانزده‌بیتی است. پیش‌فرض entity آن `tb/programs/program_add.mem` را نام می‌برد، اما پیش‌فرض یکپارچه `cpu_core`/`system_top` آن را با `tb/programs/bin/movi.mem` override می‌کند. Data memory یک حافظه ۲۵۶ word چهار بیتی با read ترکیبی، write همزمان و پاک‌سازی همزمان در Reset است.

## ماشین حالت اجرای پیاده‌سازی‌شده

`STATE_RESET → FETCH → DECODE → EXECUTE → WRITE_BACK → FETCH`.

`HALT` از `EXECUTE` به `STATE_HALTED` منتقل می‌شود؛ وارد `WRITE_BACK` نمی‌شود. حالت Reset پیش از Fetch یک حالت clocked در FSM اشغال می‌کند.

## مجموعه دستور پیاده‌سازی‌شده

`ADD`، `SUB`، `INC`، `DEC`، `AND`، `OR`، `XOR`، `NOT`، `SHL`، `SHR`، `LOAD`، `STORE`، `MOVI`، `JMP`، `JZ`، `JC`، `NOP` و `HALT` در package تخصیص یافته‌اند. encoding دقیق و محدودیت‌های عملیاتی در [isa/reference/opcode_table.md](isa/reference/opcode_table.md) آمده است.

`CMP` و `JNZ` **پیاده‌سازی نشده‌اند**. مستندات پیشین آن‌ها صرفاً تاریخی است و رفتار CPU را تعریف نمی‌کند.

## محدودیت‌های مهم پیاده‌سازی

- Instructionهای R-type از `Rd`، `Rs1` و `Rs2` استفاده می‌کنند؛ operation دو-عملوندیِ مخرب نیستند.
- انتخاب آدرس data memory از `Rs2` با zero-extension استفاده می‌کند؛ immediate نوع I به‌عنوان آدرس استفاده نمی‌شود.
- `MOVI` فقط چهار بیت پایین immediate را می‌نویسد و flagها را به‌روزرسانی نمی‌کند.
- `JMP` و `JZ`/`JC` گرفته‌شده در execute هم PC load و هم PC enable را assert می‌کنند؛ بنابراین target decode‌شده یازده‌بیتی را بدون delay slot load می‌کنند.
- مقداردهی Instruction memory از فایل متنی یک مدل Simulation است؛ نتیجه Synthesis موفقی مستند نشده است.

## رزرو برای نسخه آینده

Pipeline، `CMP`، `JNZ`، پشتیبانی stack، interrupt، I/O، modeهای آدرس‌دهی افزوده و هر target FPGA برای نسخه آینده رزرو شده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | هم‌راستا با RTL فعلی. |
| 0.2.0 | به‌روزرسانی تاریخی مستندات ISA. |
| 0.1.0 | مشخصات اولیه. |
