# Repository instructions

## Scope

This repository documents and reproduces the Linux port for the SPC Glee 10.1
tablet based on the Allwinner A64 (`sun50iw1p1`). Keep it independent from any
private dashboard, workstation configuration, credentials, or home network.

## Safety boundaries

- Never write to eMMC or Android partitions.
- Treat microSD imaging as destructive and require explicit device identity,
  size, removability, confirmation, backup, and post-write verification.
- Prefer FEL and RAM-only tests before persistent media.
- Never commit firmware extracted from a user's device unless redistribution is
  explicitly permitted.
- Never commit private keys, passwords, `authorized_keys`, serial numbers, MAC
  addresses copied from personal infrastructure, or internal hostnames.

## Stack and commands

- Shell: Bash with `set -euo pipefail`.
- Device tree: Linux DTS for Allwinner A64.
- Cross toolchains: `aarch64-linux-gnu-` and, where required, `arm-linux-gnueabihf-`.
- Native validation: `scripts/validate.sh`.
- Container environment: `scripts/docker-build.sh` and `scripts/docker-shell.sh`.

## Conventions

- Code and comments are in English.
- Public documentation is bilingual: English first, Spanish second.
- Use SPDX identifiers where applicable.
- Distinguish confirmed hardware, inferred hardware, and pending validation.
- Keep patches small and attributable to an upstream version and commit.
