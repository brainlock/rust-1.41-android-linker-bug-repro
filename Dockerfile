FROM rust:1.41

RUN rustup target add i686-unknown-linux-gnu

RUN apt-get update

RUN \
    apt-get install -y \
        vim binutils pax-utils\
        libc6-dev-i386;

WORKDIR /usr/src/repro

COPY . /usr/src/repro

