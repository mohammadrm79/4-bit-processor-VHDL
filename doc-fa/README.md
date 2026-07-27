# مستندات

این مستندات پیاده‌سازی فعلی مخزن را توصیف می‌کنند. هر زمان یک سند و RTL با هم تفاوت داشته باشند، منبع VHDL مرجع است.

## محتوا

| حوزه | مسیر | دامنه |
|---|---|---|
| مبنای طراحی | `design_spec.md`، `design_decisions.md` | معماری پیاده‌سازی‌شده و تصمیم‌های ثبت‌شده |
| معماری | `architecture/` | یکپارچه‌سازی CPU، datapath، کنترل، حافظه و timing |
| ISA | `isa/` | encoding، Opcode، operation و محدودیت‌های پیاده‌سازی‌شده |
| گزارش‌ها | `reports/` | وضعیت فعلی build، Simulation و Verification |
| برنامه‌ریزی | `roadmap.md` | کار تکمیل‌شده و کار رزرو‌شده برای آینده |

## ساختار دایرکتوری

```text
docs/
├── architecture/     توضیحات معماری هم‌راستا با پیاده‌سازی
├── diagrams/         placeholderهای خالی Draw.io؛ نموداری پیاده‌سازی نشده است
├── isa/              مرجع ISA
├── reports/          وضعیت build و Verification
├── design_decisions.md
├── design_spec.md
└── roadmap.md
```

چهار فایل در `diagrams/` placeholder خالی هستند و نباید به‌عنوان نمودار معماری تفسیر شوند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | بازنویسی برای توصیف پیاده‌سازی فعلی VHDL. |
| 1.0.0 | فهرست اولیه مستندات. |
