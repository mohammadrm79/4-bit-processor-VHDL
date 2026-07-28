# دستورهای System

| Instruction | Opcode | رفتار |
|---|---|---|
| NOP | 10000 | عمل assert‌شده‌ای در execute/write-back ندارد؛ PC پیش‌تر در fetch افزایش یافته است. |
| HALT | 10001 | از execute به `STATE_HALTED` می‌رود. |

`halted` در همه حالت‌ها به‌جز `STATE_HALTED` low است. در حالت halted هیچ enable مربوط به PC/IR/register/memory/flag assert نیست؛ reset، FSM را به `STATE_RESET` بازمی‌گرداند.

opcodeهای تخصیص‌نیافته از دید semantic دستور system نیستند، اما `opcode_to_format` آن‌ها را S-type برمی‌گرداند. برای آن‌ها trap وجود ندارد.
