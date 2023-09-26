#!/bin/sh

n=1

while [ $n -le $1 ]; do
    mkdir -p "dir.$n"
    n=$((n + 1))
done
