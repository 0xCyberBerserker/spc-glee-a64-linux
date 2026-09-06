#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

expected_sha256=abad43e66f9ee9a4848f4fc1e18f5618fa1518b3c0da575d82a661af971686d6

if (( EUID != 0 )); then
	printf 'Run as root.\n' >&2
	exit 1
fi

if (( $# != 2 )); then
	printf 'Usage: %s TARGET_ROOTFS OWNER_FIRMWARE_FILE\n' "$0" >&2
	exit 2
fi

target_rootfs=$(realpath -e -- "$1")
firmware=$(realpath -e -- "$2")
target_dir=$(realpath -m -- "${target_rootfs}/usr/lib/firmware/silead")
target_file=${target_dir}/spc-glee-a102.fw

if [[ "${target_rootfs}" == / || ! -f "${target_rootfs}/etc/os-release" ||
	"${target_dir}" != "${target_rootfs}"/* ]]; then
	printf 'Refusing invalid target root filesystem.\n' >&2
	exit 1
fi

actual_sha256=$(sha256sum -- "${firmware}" | cut -d ' ' -f 1)
if [[ "${actual_sha256}" != "${expected_sha256}" ]]; then
	printf 'Firmware does not match the known-good SPC Glee blob.\n' >&2
	exit 1
fi

if [[ -L "${target_file}" ]]; then
	printf 'Refusing symbolic-link destination.\n' >&2
	exit 1
fi

install -d -m 0755 "${target_dir}"
install -m 0644 -- "${firmware}" "${target_file}"
printf 'Installed verified owner-supplied firmware: %s\n' "${target_file}"
