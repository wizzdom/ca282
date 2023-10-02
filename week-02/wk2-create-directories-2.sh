#!/bin/sh

n=1

while [ $n -le $1 ]; do
    dir_name=$(printf "dir.%06d" $n)
    mkdir -p "$dir_name"
    n=$((n + 1))
done
