#!/bin/bash

# tree_struct.sh
# نمایش ساختار درختی پوشه (مسیر دلخواه یا پوشه فعلی)

TARGET_DIR="${1:-.}"  # اگر آرگومان داده نشد، پوشه فعلی

# اگر tree نصب است، از آن استفاده کن
if command -v tree &> /dev/null; then
    tree -F "$TARGET_DIR"
else
    # نسخهٔ ساده با find و awk
    echo "$TARGET_DIR"
    find "$TARGET_DIR" -type d -o -type f | sort | awk '
        BEGIN { FS = "/" }
        {
            depth = NF - 1
            indent = ""
            for (i = 1; i < depth; i++) indent = indent "│   "
            if (depth > 0) {
                if (depth == 1) print indent "├── " $NF
                else print indent "├── " $NF
            }
        }
    ' | sed 's/├── $//g' | sed 's/│   $//g'
fi