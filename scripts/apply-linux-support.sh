#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
linux_dir=${repo_dir}/src/linux
patch_file=${repo_dir}/patches/linux/0001-spc-glee-runtime-support.patch
dts_dir=${linux_dir}/arch/arm64/boot/dts/allwinner
expected_commit=ffc82ed665314ccf141abc4710830f3f424d98ea

if [[ ! -d "${linux_dir}/.git" ]] || [[ $(git -C "${linux_dir}" rev-parse HEAD) != "${expected_commit}" ]]; then
	printf 'Expected a clean Linux baseline at commit %s.\n' "${expected_commit}" >&2
	exit 1
fi

if git -C "${linux_dir}" apply --unidiff-zero --check "${patch_file}"; then
	git -C "${linux_dir}" apply --unidiff-zero "${patch_file}"
elif ! git -C "${linux_dir}" apply --unidiff-zero --reverse --check "${patch_file}"; then
	printf 'Linux patch is neither applicable nor already applied.\n' >&2
	exit 1
fi

install -m 0644 "${repo_dir}"/device-tree/*.dts "${dts_dir}/"
