# نمای کلی ISA

## مقادیر معماری

| ویژگی | مقدار |
|---|---|
| Datapath | ۴ بیت |
| Instruction | ۱۶ بیت |
| Opcode | ۵ بیت |
| Register file | هشت Register چهار بیتی |
| PC/jump field | ۱۱ بیت |
| مدل‌های memory | Instruction و data memory جدا |
| اجرا | FSM بدون Pipeline |

## Formatها

package، Opcodeهای ALU/logic/shift را R-type، `LOAD`، `STORE` و `MOVI` را I-type، `JMP`، `JZ` و `JC` را J-type و همه Opcodeهای دیگر را S-type طبقه‌بندی می‌کند. Decoder برش‌های مشترک bit را مستقل از format ارائه می‌کند.

## مدل programming پیاده‌سازی‌شده

operationهای R-type در `Rd[10:8]` می‌نویسند و `Rs1[7:5]` و `Rs2[4:2]` را می‌خوانند. `INC`، `DEC` و `NOT` از source A استفاده می‌کنند؛ source B همچنان decode می‌شود اما در result ALU آن‌ها اثر ندارد.

`MOVI`، `immediate[3:0]` را می‌نویسد. در datapath memory یکپارچه، `LOAD` از آدرس `Rs2` می‌خواند و `STORE`، `Rs1` را در آن آدرس می‌نویسد. immediate به‌عنوان آدرس memory استفاده نمی‌شود.

## کنترل جریان

`JMP`، `address[10:0]` را در execute در PC load می‌کند. `JZ` و `JC` وقتی flag ثبت‌شده Z یا C set باشد همین target را load می‌کنند. PC در fetch پیشین افزایش یافته است؛ پس branch شرطیِ گرفته‌نشده با instruction ترتیبی بعدی ادامه می‌دهد و delay slot وجود ندارد.

## رزرو برای نسخه آینده

`CMP`، `JNZ`، semantics immediate signed/extended، آدرس‌دهی memory immediate مستقیم و branchهای مبتنی بر N/V برای نسخه آینده رزرو شده‌اند.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | وضعیت Instruction و Control flow اصلاح شد. |
| 1.0.0 | نمای کلی اولیه ISA. |
