#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

if (( EUID != 0 )); then
	printf 'Run as root.\n' >&2
	exit 1
fi

if (( $# != 2 )); then
	printf 'Usage: %s TARGET_ROOTFS PUBLIC_KEY_FILE\n' "$0" >&2
	exit 2
fi

target_rootfs=$(realpath -e -- "$1")
public_key=$(realpath -e -- "$2")

if [[ "${target_rootfs}" == / || ! -f "${target_rootfs}/etc/os-release" ]]; then
	printf 'Refusing invalid target root filesystem: %s\n' "${target_rootfs}" >&2
	exit 1
fi

if [[ ! -f "${public_key}" ]] || ! grep -Eq '^(ssh-ed25519|sk-ssh-ed25519@openssh.com|ecdsa-sha2-nistp(256|384|521)|sk-ecdsa-sha2-nistp256@openssh.com) ' "${public_key}"; then
	printf 'Only a supported public SSH key is accepted.\n' >&2
	exit 1
fi

if [[ -e "${target_rootfs}/root/.ssh/authorized_keys" ]]; then
	printf 'Refusing to overwrite an existing authorized_keys file.\n' >&2
	exit 1
fi

install -d -m 0700 -o root -g root "${target_rootfs}/root/.ssh"
install -m 0600 -o root -g root "${public_key}" "${target_rootfs}/root/.ssh/authorized_keys"
printf 'Installed public key in %s/root/.ssh/authorized_keys\n' "${target_rootfs}"
