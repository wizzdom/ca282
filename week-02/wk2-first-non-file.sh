#!/bin/sh

while IFS= read -r file; do
    [ ! -f "$file" ] && { echo "$file"; break; }
done
