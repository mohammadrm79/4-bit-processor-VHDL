# معماری Timing

تمام componentهای یکپارچه stateful از لبه بالارونده یک Clock و Reset همزمان فعال-بالا استفاده می‌کنند.

## timing Instruction عادی

پس از آزاد شدن Reset و خروج FSM از `STATE_RESET`، یک Instruction غیر-HALT این حالت‌ها را دارد:

| حالت clocked | عمل قابل مشاهده |
|---|---|
| `FETCH` | IR Instruction در PC فعلی را capture می‌کند؛ PC increment می‌شود. |
| `DECODE` | Decoder و read Register ترکیبی هستند. |
| `EXECUTE` | result/flag ALU ممکن است capture شود؛ write data memory ممکن است رخ دهد. |
| `WRITE_BACK` | Register file ممکن است result را capture کند. |

`HALT` Fetch، Decode و Execute را طی می‌کند، سپس بدون حالت Write Back وارد `STATE_HALTED` می‌شود.

## timing Data

- read Register و هر دو read memory ترکیبی هستند.
- write Register file، write data memory، update PC، update IR، update result ALU و update flag همگی در لبه بالارونده هستند.
- flagهای ALU برای Opcodeهای ALU در `EXECUTE`، پیش از اجرای Instruction بعدی capture می‌شوند.

در `EXECUTE`، `JMP`، `JZ` یا `JC` گرفته‌شده target PC را در لبه بالارونده load می‌کند. افزایش ترتیبی PC پیش‌تر در `FETCH` رخ داده است و delay slot وجود ندارد.

## پیاده‌سازی نشده

wait-state، stall، clock-gating یا Pipeline پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | timing HALT و رفتار control-flow یکپارچه اصلاح شدند. |
| 1.0.0 | توصیف اولیه timing architecture. |
