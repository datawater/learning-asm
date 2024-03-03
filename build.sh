#!/bin/bash

set -x

rm -fdr build
mkdir build

set -e

find ./src -type f -name "*.asm" -exec nasm -felf64 -g {} \;

for i in src/*.o; do
    gcc -O3 -nostartfiles $i -o ${i%.*}.elf
done