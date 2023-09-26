#!/bin/sh

set -e

for file in "$@";
do
    test -f "$file"
done
