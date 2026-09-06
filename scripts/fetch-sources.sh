#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
source_dir=${repo_dir}/src
mkdir -p "${source_dir}"

requested=("$@")
if (( ${#requested[@]} == 0 )); then
	requested=(linux u-boot trusted-firmware-a sunxi-tools)
fi

wants() {
	local target=$1
	local item
	for item in "${requested[@]}"; do
		[[ "${item}" == "${target}" ]] && return 0
	done
	return 1
}

fetch_tree() {
	local name=$1
	local url=$2
	local commit=$3
	local destination=${source_dir}/${name}

	if [[ ! -d "${destination}/.git" ]]; then
		mkdir -p "${destination}"
		git -C "${destination}" init
		git -C "${destination}" remote add origin "${url}"
	fi

	test "$(git -C "${destination}" remote get-url origin)" = "${url}"
	git -C "${destination}" fetch --depth=1 origin "${commit}"
	git -C "${destination}" checkout --detach FETCH_HEAD
	test "$(git -C "${destination}" rev-parse HEAD)" = "${commit}"
}

wants linux && fetch_tree linux \
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git \
	ffc82ed665314ccf141abc4710830f3f424d98ea
wants u-boot && fetch_tree u-boot \
	https://github.com/u-boot/u-boot.git \
	ece349ade2973e220f524ce59e59711cc919263f
wants trusted-firmware-a && fetch_tree trusted-firmware-a \
	https://github.com/ARM-software/arm-trusted-firmware.git \
	da738d5eae93af342fdc4995dd3c05acb4c9d757
wants sunxi-tools && fetch_tree sunxi-tools \
	https://github.com/linux-sunxi/sunxi-tools.git \
	d7bbd172a5da601a08f94479de308c6fb714a19a

if wants sunxi-tools; then
	make -C "${source_dir}/sunxi-tools" -j"$(nproc)"
fi
