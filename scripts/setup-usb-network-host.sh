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
device_address=$(read_value SPC_USB_DEVICE_ADDRESS)
device_ip=${device_address%/*}

[[ "${host_mac}" =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]] || exit 2
[[ "${host_address}" =~ ^[0-9.]+/[0-9]+$ ]] || exit 2
[[ "${device_address}" =~ ^[0-9.]+/[0-9]+$ ]] || exit 2

interface=
for address_file in /sys/class/net/*/address; do
	if [[ $(<"${address_file}") == "${host_mac,,}" ]]; then
		interface=$(basename "$(dirname "${address_file}")")
		break
	fi
done

if [[ -z "${interface}" ]]; then
	printf 'SPC Glee ECM interface not found.\n' >&2
	exit 1
fi

ip link set "${interface}" up
ip address replace "${host_address}" dev "${interface}"
printf 'Interface: %s\nSSH: ssh root@%s\n' "${interface}" "${device_ip}"
