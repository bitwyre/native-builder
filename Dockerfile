FROM ubuntu:20.04

LABEL maintainer "Aditya Kresna <kresna@bitwyre.com>"

ENV DEBIAN_FRONTEND="noninteractive"
ENV PATH="/root/.cargo/bin:${PATH}"

# GCC-9 & Clang-10
RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential libssl-dev \
    pkg-config autoconf automake cmake autotools-dev ninja-build libtool \
    clang clang-format clangd clang-tidy clang-tools yasm nasm \
    ca-certificates wget curl git musl musl-dev musl-tools && \
    rm -rf /var/lib/apt/lists/*

# Rust 1.43
RUN curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y && \
    rustup target add x86_64-unknown-linux-musl

# Closure (show versions)
RUN echo "\n***************************************************************************\n" && \
    echo "[gcc]" && gcc --version && \
    echo "[g++]" && g++ --version && \
    echo "[clang]" && clang --version && \
    echo "\n[rust]" && rustc --version && \
    echo "\n***************************************************************************\n"
