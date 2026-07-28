# تصمیم‌های طراحی

این ثبت، تصمیم‌های پیاده‌سازی‌شده را از ایده‌های رزرو‌شده برای کار بعدی متمایز می‌کند. RTL فعلی مرجع است.

| ID | تصمیم | وضعیت | شواهد RTL |
|---|---|---|---|
| DD-001 | datapath چهار بیتی | پیاده‌سازی شده | `DATA_WIDTH = 4` |
| DD-002 | Instructionهای ثابت ۱۶ بیتی | پیاده‌سازی شده | `INSTRUCTION_WIDTH = 16` |
| DD-003 | Instruction/data memory جدا | پیاده‌سازی شده | `instruction_memory`، `data_memory` |
| DD-004 | هشت Register همه‌منظوره | پیاده‌سازی شده | `REGISTER_COUNT = 8` |
| DD-005 | کنترل چندچرخه‌ای | پیاده‌سازی شده | `control_fsm` |
| DD-006 | یک Clock با لبه بالارونده | پیاده‌سازی شده | componentهای RTL ترتیبی |
| DD-007 | Reset همزمان فعال-بالا | پیاده‌سازی شده | componentهای RTL ترتیبی |
| DD-008 | میدان Opcode پنج بیتی | پیاده‌سازی شده | `OPCODE_WIDTH = 5` |
| DD-009 | چهار format نام‌دار Instruction | برای decode پیاده‌سازی شده | `opcode_to_format` |

## شفاف‌سازی‌ها

«Harvard» حافظه‌های RTL جدا را توصیف می‌کند، اما هر دو حافظه مدل‌های داخلی Simulation هستند، نه interface خارجی. مدل Instruction memory از text I/O و فایل program پیش‌فرض استفاده می‌کند.

`memory_operation_t` و functionهای کمکی package در `cpu_pkg` تعریف شده‌اند. core یکپارچه از entityهای مستقیم و یک process محلی برای انتخاب write-back استفاده می‌کند؛ در source tree فعلی entityای با نام `counter`، `register_n` یا `mux` وجود ندارد.

## رزرو برای نسخه آینده

ادعای پیاده‌سازی کاملاً synthesizable و portable، interfaceهای memory خارجی، Verification کامل هر module و targetهای vendor، **برای نسخه آینده رزرو شده‌اند**. جریان Synthesis فعلی دارای ایرادهای path و source list شناخته‌شده است.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | تبدیل تصمیم‌ها به وضعیت هم‌راستا با پیاده‌سازی. |
| 1.0.0 | ثبت اولیه تصمیم‌ها. |
