#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

if (( EUID != 0 )); then
	printf 'Run as root.\n' >&2
	exit 1
fi

interface=
for address_file in /sys/class/net/*/address; do
	if [[ $(<"${address_file}") == 02:64:00:00:00:01 ]]; then
		interface=$(basename "$(dirname "${address_file}")")
		break
	fi
done

if [[ -z "${interface}" ]]; then
	printf 'SPC Glee ECM interface not found.\n' >&2
	exit 1
fi

ip link set "${interface}" up
ip address replace 10.64.0.1/24 dev "${interface}"
printf 'Interface: %s\nSSH: ssh root@10.64.0.2\n' "${interface}"
