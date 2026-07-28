# مستندات RISC-4

این مستندات پیاده‌سازی VHDL پردازنده آموزشی RISC-4 را توضیح می‌دهد. برای شناخت پردازنده، build و اجرای تست‌ها از این فهرست استفاده کنید. اگر متن مستندات با RTL تفاوت داشت، sourceهای زیر `src/` مرجع نهایی هستند.

## شروع از اینجا

- [مشخصات طراحی](design_spec.md) — پیکربندی پیاده‌سازی‌شده و مبنای معماری.
- [تصمیم‌های طراحی](design_decisions.md) — محدودیت‌ها و دلیل‌های ثبت‌شده برای پروژه.
- [نیازمندی‌ها](requirements.md) — نیازمندی‌های repository، ابزار و پیاده‌سازی.

## معماری

- [فهرست معماری](architecture/README.md) — راهنمای اسناد معماری.
- [نمای کلی CPU](architecture/cpu_overview.md) — entityهای سطح بالا و state معماری.
- [مسیر داده](architecture/datapath.md) — decode، operandها، ALU، data memory و write-back.
- [واحد کنترل](architecture/control_unit.md) — حالت‌ها و سیگنال‌های `control_fsm`.
- [حافظه](architecture/memory.md) — مدل‌های instruction و data memory.
- [زمان‌بندی](architecture/timing.md) — رفتار clocked و ترکیبی.

## معماری مجموعه‌دستور

- [فهرست ISA](isa/README.md) — مسیر‌یابی مجموعه‌دستور و گروه‌های پیاده‌سازی‌شده.
- [نمای کلی ISA](isa/overview.md) — مقادیر معماری و مدل برنامه‌نویسی.
- [کدگذاری instruction](isa/encoding.md) — fieldهای مشترک و طبقه‌بندی format.
- [Format نوع R](isa/formats/r_type.md) — کدگذاری ALU register-to-register.
- [Format نوع I](isa/formats/i_type.md) — کدگذاری memory و immediate.
- [Format نوع J](isa/formats/j_type.md) — کدگذاری هدف jump.
- [Format نوع S](isa/formats/s_type.md) — opcodeهای system و تخصیص‌نیافته.
- [دستورهای arithmetic](isa/instructions/arithmetic.md) — ADD، SUB، INC و DEC.
- [دستورهای logic و shift](isa/instructions/logic.md) — AND، OR، XOR، NOT، SHL و SHR.
- [دستورهای memory و immediate](isa/instructions/memory.md) — LOAD، STORE و MOVI.
- [دستورهای کنترل جریان](isa/instructions/control.md) — JMP، JZ و JC.
- [دستورهای system](isa/instructions/system.md) — NOP و HALT.
- [جدول opcode](isa/reference/opcode_table.md) — فهرست کامل opcodeهای تخصیص‌یافته.
- [Registerها](isa/reference/registers.md) — سازمان register file.
- [Flagها](isa/reference/flags.md) — رفتار Z، C، N و V.
- [زمان‌بندی instruction](isa/reference/timing.md) — زمان‌بندی اجرای هر state.
- [مثال‌های program image](isa/examples.md) — مثال‌های assembly و image hexadecimal.

## توسعه و اعتبارسنجی

- [راهنمای build](build.md) — فرمان‌های lint، simulation، synthesis و clean.
- [راهنمای scriptها](scripts.md) — scriptهای کمکی repository و ورودی/خروجی آن‌ها.
- [راهنمای تست](test.md) — سازمان unit test، integration test و program test.

## ساختار پوشه

```text
docs-fa/
├── architecture/  معماری CPU هماهنگ با پیاده‌سازی
├── isa/           مرجع مجموعه‌دستور
├── build.md       جریان build
├── design_decisions.md
├── design_spec.md
├── requirements.md
├── scripts.md
└── test.md
```
