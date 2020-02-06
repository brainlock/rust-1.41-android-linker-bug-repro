#!/bin/bash

set -eu
set -o pipefail

rm -rf target/i686-unknown-linux-gnu

mkdir -p target/i686-unknown-linux-gnu/release/deps

rustc --edition=2018 --crate-name repro src/lib.rs\
    --crate-type cdylib --crate-type staticlib --emit=dep-info,link \
    -C opt-level=3 -C metadata=6d5fb5aef29585f9 \
    --out-dir /usr/src/repro/target/i686-unknown-linux-gnu/release/ \
    --target i686-unknown-linux-gnu \
    -L dependency=/usr/src/repro/target/i686-unknown-linux-gnu/release/deps \
    -L dependency=/usr/src/repro/target/release/deps

gcc -m32 c/main.c -Wall -fPIC -c -o target/main.o

ld -shared -o target/foo.so -soname foo.so --warn-shared-textrel --fatal-warnings target/main.o target/i686-unknown-linux-gnu/release/librepro.a -lc -lpthread -ldl -melf_i386 -A elf32-i386
