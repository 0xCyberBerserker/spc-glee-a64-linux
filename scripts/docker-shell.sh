#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
exec docker run --rm -it \
	--user "$(id -u):$(id -g)" \
	-e HOME=/tmp \
	-v "${repo_dir}:/workspace" \
	-w /workspace \
	spc-glee-a64-cross:local bash
