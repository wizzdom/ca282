#!/bin/sh

content="$1"

for file in *.txt; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        if grep -q "$content" "$file"; then
            echo "$file"
        fi
    fi
done
