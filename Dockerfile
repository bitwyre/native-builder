FROM ubuntu:18.04

# Basic Aptitude Packages
RUN apt-get update && \
    apt-get install -y software-properties-common wget curl build-essential libssl-dev \
    pkg-config autoconf automake cmake autotools-dev

# GCC 9
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get install -y gcc-9 g++-9 && \
    update-alternatives --install \
    /usr/bin/gcc gcc /usr/bin/gcc-9 90 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-9 \
    --slave /usr/bin/gcov gcov /usr/bin/gcov-9

# Clang 10
RUN cd ~ && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    add-apt-repository -y "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-10 main" && \
    apt-get install -y libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples \
    llvm-10-runtime clang-10 clang-tools-10 clang-10-doc libclang-common-10-dev libclang-10-dev libclang1-10 \
    clang-format-10 clangd-10 libfuzzer-10-dev lldb-10 lld-10 libc++-10-dev libc++abi-10-dev \
    libomp-10-dev

# Rust 1.42
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Closure (show versions)
RUN echo "\n===========================================================================\n" && \
    echo "[gcc]" && gcc --version && \
    echo "[g++]" && g++ --version && \
    echo "[clang]" && /usr/lib/llvm-10/bin/clang --version && \
    echo "\n[rust]" && /root/.cargo/bin/./cargo --version && \
    echo "\n===========================================================================\n"
