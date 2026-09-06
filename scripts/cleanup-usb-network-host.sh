#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

if (( EUID != 0 )); then
	printf 'Run as root.\n' >&2
	exit 1
fi

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
config=${SPC_USB_CONFIG:-${repo_dir}/rootfs-overlay/etc/default/spc-usb-gadget}
read_value() { sed -n "s/^$1=//p" "${config}" | tail -n 1; }
host_mac=$(read_value SPC_USB_HOST_MAC)
host_address=$(read_value SPC_USB_HOST_ADDRESS)

[[ "${host_mac}" =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]] || exit 2
[[ "${host_address}" =~ ^[0-9.]+/[0-9]+$ ]] || exit 2

for address_file in /sys/class/net/*/address; do
	if [[ $(<"${address_file}") == "${host_mac,,}" ]]; then
		interface=$(basename "$(dirname "${address_file}")")
		ip address delete "${host_address}" dev "${interface}" 2>/dev/null || true
		exit 0
	fi
done

printf 'SPC Glee ECM interface not found.\n' >&2
exit 1
