# معماری Datapath

## decode Instruction

Decoder همیشه این میدان‌ها را assign می‌کند:

| خروجی | بیت‌های Instruction |
|---|---|
| Opcode | `[15:11]` |
| Register مقصد | `[10:8]` |
| Source A | `[7:5]` |
| Source B | `[4:2]` |
| Immediate | `[7:0]` |
| آدرس jump | `[10:0]` |

برای operationهای R-type دودویی، `Rd`، `Rs1` و `Rs2` میدان‌های فعال هستند. `INC`، `DEC`، `NOT`، `SHL` و `SHR` فقط از `Rs1` استفاده می‌کنند؛ `Rs2` decode می‌شود اما بر result ALU آن‌ها اثری ندارد. بیت‌های `[1:0]` خروجی decode ندارند.

## ALU و Write Back

ALU source A و source B از Register file را مصرف می‌کند. result آن برای operationهای ALU وارد `alu_result_register` می‌شود. Write Back انتخاب می‌کند:

| منبع | مقدار |
|---|---|
| `WB_ALU` | result ثبت‌شده ALU |
| `WB_IMMEDIATE` | `immediate[3:0]` |
| `WB_MEMORY` | read ترکیبی data memory |

`MOVI` immediate را از ALU عبور نمی‌دهد.

## datapath Data memory

`memory_address <= "0000000" & register_data_b`. `STORE`، `register_data_a` را به‌عنوان write data می‌دهد. بنابراین operation یکپارچه، مستقل از immediate نوع I، مبتنی بر Register است.

## پیاده‌سازی نشده

انتخاب immediate به ALU، آدرس‌دهی immediate data memory، address-generation unit و کنترل قابل مشاهده N/V پیاده‌سازی نشده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.2.0 | operationهای تک-source R-type روشن شدند. |
| 1.1.0 | datapathهای R-type و memory اصلاح شدند. |
| 1.0.0 | توصیف اولیه datapath. |
