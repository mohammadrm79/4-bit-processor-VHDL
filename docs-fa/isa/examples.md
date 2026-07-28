# مثال‌های Programming و Program Image

repository یک assembler در `scripts/assembler.sh` و `scripts/assembler.awk` دارد. sourceهای assembly زیر `tb/programs/asm/` و imageهای hexadecimal تولیدشده زیر `tb/programs/bin/` قرار دارند. `instruction_memory` در هر خط یک word hexadecimal شانزده‌بیتی می‌خواند.

## مثال: add

[`tb/programs/asm/add.asm`](../../tb/programs/asm/add.asm) به این صورت assemble می‌شود:

```text
MOVI R0,5
MOVI R1,3
ADD R2,R0,R1
HALT
```

image آن، [`tb/programs/bin/add.mem`](../../tb/programs/bin/add.mem)، چنین است:

```text
6005
6103
0204
8800
```

پس از HALT، R2 برابر `8` است.

## مثال‌های branch

برنامه‌های `jump.asm`، `jz.asm` و `jc.asm` به‌ترتیب `JMP`، `JZ` و `JC` را آزمایش می‌کنند. target یک آدرس مطلق یازده‌بیتی در instruction memory است. انتقال گرفته‌شده در execute PC را به‌روزرسانی می‌کند و branch شرطی گرفته‌نشده به‌صورت ترتیبی ادامه می‌یابد.

## محدودیت‌ها

assembler از instructionهای تخصیص‌یافته repository پشتیبانی می‌کند. `CMP`، `JNZ`، آدرس‌دهی مستقیم immediate برای memory، label فراتر از syntax پشتیبانی‌شده assembler و semantics immediate علامت‌دار/extended، ویژگی CPU نیستند.
