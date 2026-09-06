# SPDX-License-Identifier: MIT
FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bc \
        binutils-aarch64-linux-gnu \
        binutils-arm-linux-gnueabihf \
        bison \
        build-essential \
        ca-certificates \
        cpio \
        device-tree-compiler \
        flex \
        gcc-aarch64-linux-gnu \
        gcc-arm-linux-gnueabihf \
        git \
        libelf-dev \
        libncurses-dev \
        libssl-dev \
        libusb-1.0-0-dev \
        make \
        patch \
        pkg-config \
        python3 \
        rsync \
        swig \
        u-boot-tools \
        xz-utils \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]
