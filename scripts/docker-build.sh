#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
exec docker build -t spc-glee-a64-cross:local -f "${repo_dir}/docker/Dockerfile" "${repo_dir}"
