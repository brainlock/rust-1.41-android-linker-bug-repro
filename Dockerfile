FROM rust:1.41

RUN rustup target add i686-unknown-linux-gnu

# good
RUN rustup install nightly-2019-12-09 && rustup default nightly-2019-12-09 && rustup target add i686-unknown-linux-gnu

# bad
RUN rustup install nightly-2019-12-10 && rustup default nightly-2019-12-10 && rustup target add i686-unknown-linux-gnu


RUN apt-get update

RUN \
    apt-get install -y \
    vim binutils pax-utils\
    libc6-dev-i386;

RUN cargo install rustup-toolchain-install-master

RUN rustup-toolchain-install-master 76a252ea9e7be93a61ffdf33b3533e24a9cf459d \
    --targets i686-unknown-linux-gnu

RUN rustup-toolchain-install-master 7de9402b77ded0d8ec9e1c554521b2121449ef2b \
    --targets i686-unknown-linux-gnu

WORKDIR /usr/src/repro

COPY . /usr/src/repro
