# دستورهای کنترل جریان

| Instruction | Opcode | شرط FSM |
|---|---|---|
| JMP | 01101 | target را در execute load می‌کند |
| JZ | 01110 | target را هنگام Z=1 load می‌کند |
| JC | 01111 | target را هنگام C=1 load می‌کند |

هر instruction یک target یازده‌بیتی را از `instruction[10:0]` decode می‌کند.

FSM برای هر انتقال گرفته‌شده، `pc_enable` و `pc_load` را هم‌زمان assert می‌کند. بنابراین entity `pc` در لبه execute، PC ترتیبیِ افزایش‌یافته را با target جایگزین می‌کند. delay slot وجود ندارد.

`JNZ` **پیاده‌سازی نشده است**.
