#!/bin/bash

set -eu
set -o pipefail

cargo clean

cargo build --release --target i686-unknown-linux-gnu

gcc -m32 c/main.c -Wall -fPIC -c -o target/main.o

ld -shared -o target/foo.so -soname foo.so --warn-shared-textrel --fatal-warnings target/main.o target/i686-unknown-linux-gnu/release/librepro.a -lc -lpthread -ldl -melf_i386 -A elf32-i386
