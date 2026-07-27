# Encoding Instruction

## برش‌های مشترک Decoder

Decoder Instruction بدون شرط این میدان‌ها را استخراج می‌کند:

```text
15        11 10      8 7       5 4       2 1     0
+------------+---------+---------+---------+-------+
|   opcode   |   Rd    |   Rs1   |   Rs2   | low2  |
+------------+---------+---------+---------+-------+
```

`immediate = instruction[7:0]` و `address = instruction[10:0]` نیز همیشه تولید می‌شوند.

## طبقه‌بندی format انتخاب‌شده با Opcode

| Format | گروه Opcode پیاده‌سازی‌شده |
|---|---|
| R-type | ADD, SUB, INC, DEC, AND, OR, XOR, NOT, SHL, SHR |
| I-type | LOAD, STORE, MOVI |
| J-type | JMP, JZ, JC |
| S-type | NOP، HALT و هر Opcode دیگر |

### R-type

`Rd[10:8]`، `Rs1[7:5]` و `Rs2[4:2]` در operationهای ALU دودویی استفاده می‌شوند. بیت‌های `[1:0]` توسط Decoder یا CPU core مصرف نمی‌شوند.

### I-type

```text
15        11 10      8 7                       0
+------------+---------+-------------------------+
|   opcode   | register|        immediate        |
+------------+---------+-------------------------+
```

immediate فقط توسط `MOVI` استفاده می‌شود که چهار بیت کم‌ارزش آن را می‌نویسد. با وجود این میدان، آدرس memory در `cpu_core` از `Rs2[4:2]` که از بیت‌های پایین immediate decode شده استفاده می‌کند.

### J-type

`address[10:0]` به ورودی PC `next_address` داده می‌شود. کنترل PC-enable فعلی از اثر load جلوگیری می‌کند.

### S-type

یازده بیت باقی‌مانده برای `NOP`، `HALT` یا Opcodeهای reserved اثری ندارند.

## رزرو برای نسخه آینده

بیت‌های reserved در RTL برای صفر بودن بررسی نمی‌شوند، sign extension پیاده‌سازی نشده و رفتار illegal-instruction وجود ندارد.

## تاریخچه بازنگری

| نسخه | شرح |
|---|---|
| 1.1.0 | کاربرد میدان و رفتار format اصلاح شد. |
| 1.0.0 | مشخصات اولیه encoding. |
