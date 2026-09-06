#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

if (( EUID != 0 )); then
	printf 'Run as root.\n' >&2
	exit 1
fi

for address_file in /sys/class/net/*/address; do
	if [[ $(<"${address_file}") == 02:64:00:00:00:01 ]]; then
		interface=$(basename "$(dirname "${address_file}")")
		ip address delete 10.64.0.1/24 dev "${interface}" 2>/dev/null || true
		exit 0
	fi
done

printf 'SPC Glee ECM interface not found.\n' >&2
exit 1
