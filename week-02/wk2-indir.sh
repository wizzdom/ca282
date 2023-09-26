#!/bin/sh

dir="$1"
shift

cd "$dir"

for v in "$@";
do
    "$v"
done
