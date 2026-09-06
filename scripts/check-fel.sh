#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -u

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
sunxi_fel=${repo_dir}/src/sunxi-tools/sunxi-fel

if [[ ! -x "${sunxi_fel}" ]]; then
	printf 'ERROR: build sunxi-tools first: %s\n' "${sunxi_fel}" >&2
	exit 1
fi

printf '%s\n' 'Allwinner FEL USB device:'
if ! lsusb -d 1f3a:efe8; then
	printf '%s\n' 'Not detected. Connect the powered-off tablet while holding Volume Up.'
fi

printf '\nsunxi-fel ver:\n'
exec "${sunxi_fel}" ver
