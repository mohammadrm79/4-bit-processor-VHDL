# نمای کلی معماری CPU

`system_top`، `cpu_core` را instantiate می‌کند. خروجی‌های عمومی آن `halted` و نسخه‌های debug از R0–R3 هستند.

## componentهای یکپارچه

```text
PC → instruction_memory → instruction_register → instruction_decoder
                                              ↓
register_file → ALU → alu_result_register → write-back selection → register_file
                    ↓
               flags_register

register_file operands → data_memory
control_fsm → enables, ALU operation, write-back source, halt output
```

PC آدرس‌های Instruction memory را فراهم می‌کند. Instruction register در `FETCH` load می‌شود؛ PC در همان لبه Fetch increment می‌شود. «Write-back selection» یک process در `cpu_core` است، نه instantiation entity عمومی `mux`.

## حالت معماری

- PC: Register همزمان ۱۱ بیتی.
- IR: Register همزمان ۱۶ بیتی.
- Register file: هشت Register چهار بیتی، دو port read ترکیبی و یک port write همزمان.
- ALU result register: resultها را برای Write Back ALU capture می‌کند.
- Flags register: Z، C، N و V را capture می‌کند؛ فقط Z و C به کنترل وصل هستند.
- Data memory: ۲۵۶ × ۴ بیت.

## پیاده‌سازی نشده

entity با نام `cpu_top`، `control_unit` یا `status_register` وجود ندارد؛ این نام‌های تاریخی RTL فعلی نیستند. interface memory خارجی یا Pipeline وجود ندارد.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.2.0 | روشن شد که Write Back selection entity `mux` نیست. |
| 1.1.0 | نام‌ها و اتصال‌ها با `system_top` و `cpu_core` هم‌راستا شدند. |
| 1.0.0 | نمای کلی اولیه CPU. |
