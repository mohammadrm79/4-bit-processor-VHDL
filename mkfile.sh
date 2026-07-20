#!/bin/sh

# ایجاد پوشه‌های اصلی
mkdir -p tb/unit tb/integration tb/programs scripts constraints build/sim build/synth build/waves build/logs tools/yosys

# ایجاد فایل‌های تست واحد
touch tb/unit/tb_alu.vhdl
touch tb/unit/tb_register_file.vhdl
touch tb/unit/tb_pc.vhdl
touch tb/unit/tb_ir.vhdl
touch tb/unit/tb_control.vhdl

# ایجاد فایل تست یکپارچه‌سازی
touch tb/integration/tb_cpu.vhdl

# ایجاد فایل‌های حافظه برنامه
touch tb/programs/program_add.mem
touch tb/programs/program_logic.mem
touch tb/programs/program_jump.mem

# ایجاد اسکریپت‌ها و قابل‌اجرا کردن آنها
for script in sim synth lint clean; do
    touch scripts/${script}.sh
    chmod +x scripts/${script}.sh
done

echo "ساختار دایرکتوری با موفقیت ایجاد شد."