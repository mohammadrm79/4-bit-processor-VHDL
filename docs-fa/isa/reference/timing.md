# مشخصات زمان‌بندی Instruction

زمان‌بندی instruction با `control_fsm` کنترل می‌شود، نه با pipeline.

| نوع Instruction | توالی state پس از reset |
|---|---|
| ALU، memory، MOVI، NOP و opcode reserved | FETCH → DECODE → EXECUTE → WRITE_BACK |
| HALT | FETCH → DECODE → EXECUTE → STATE_HALTED |

fetch هم capture کردن IR و هم افزایش PC را enable می‌کند. result و flagهای ALU در execute برای opcodeهای ALU capture می‌شوند. write memory در execute و write register در write-back رخ می‌دهد. مسیر read data-memory ترکیبی است و برای write-back `LOAD` انتخاب می‌شود.

## انتقال کنترل

jump گرفته‌شده target را در `EXECUTE` load می‌کند و branch-delay slot وجود ندارد. طراحی wait-state یا stall حافظه ندارد.
