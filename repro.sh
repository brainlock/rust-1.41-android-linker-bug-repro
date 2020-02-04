#!/bin/bash

set -eu
set -o pipefail

ANDROID_NDK=/Users/albe/Library/Android/sdk/ndk/20.0.5594570

echo
echo "*** Running with ANDROID_NDK=$ANDROID_NDK"
echo

build() {
    cargo build --release --target i686-linux-android --verbose

    "$ANDROID_NDK"/toolchains/llvm/prebuilt/darwin-x86_64/bin/i686-linux-android23-clang \
        c/main.c \
        -Wall \
        -fPIC \
        -c \
        -o target/main.o

    "$ANDROID_NDK"/toolchains/llvm/prebuilt/darwin-x86_64/i686-linux-android/bin/ld \
        -shared -o foo.so -soname foo.so \
        --warn-shared-textrel --fatal-warnings \
        target/main.o \
        target/i686-linux-android/release/librepro.a
}


cargo clean

rustup default 1.40.0

rustc --version

build

printf "\n\n*** Everything's fine on 1.40.0 ***\n\n"


cargo clean

rustup default stable

rustc --version

build # this fails

printf "\n\n*** Everything's fine on stable ***\n\n"  ## Nope, doesn't get here
