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

WORKDIR /usr/src/repro

COPY . /usr/src/repro

