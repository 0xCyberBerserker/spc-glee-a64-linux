#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "${repo_dir}"

required=(
	README.md AGENTS.md CHANGELOG.md manual_usuario.md arquitectura.md roadmap.md
	docs/sources.md docs/hardware-support.md
	device-tree/sun50i-a64-spc-glee-sd-minimal.dts
	docker/Dockerfile scripts/build-kernel.sh
)

for file in "${required[@]}"; do
	test -s "${file}" || { printf 'Missing required file: %s\n' "${file}" >&2; exit 1; }
done

while IFS= read -r script; do
	bash -n "${script}"
done < <(find scripts rootfs-overlay/usr/local/sbin -type f -name '*.sh' -o -path 'rootfs-overlay/usr/local/sbin/spc-usb-gadget')

if command -v shellcheck >/dev/null; then
	shellcheck scripts/*.sh rootfs-overlay/usr/local/sbin/spc-usb-gadget
fi

if rg -n --hidden --glob '!.git/**' --glob '!scripts/validate.sh' \
	'(BEGIN (OPENSSH|RSA|EC) PRIVATE KEY|password\s*=|passwd\s*=|/home/[[:alnum:]_-]+/|100\.[0-9]+\.[0-9]+\.[0-9]+)' .; then
	printf 'Potential private material found.\n' >&2
	exit 1
fi

git diff --check
printf 'Validation passed.\n'
