#!/usr/bin/env bash
# Read-only evidence collection; run locally on the tablet after boot.
set -euo pipefail

printf 'Kernel: '
uname -r
printf 'Command line: '
cat /proc/cmdline
printf '\nBoard compatible:\n'
tr '\0' '\n' < /proc/device-tree/compatible
printf '\nRoot filesystem:\n'
findmnt -nro SOURCE,FSTYPE /

shopt -s nullglob
files=(
    /sys/devices/system/cpu/cpufreq/policy*/scaling_driver
    /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
    /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq
    /sys/class/thermal/thermal_zone*/type
    /sys/class/thermal/thermal_zone*/temp
    /sys/class/thermal/cooling_device*/type
    /sys/class/thermal/cooling_device*/cur_state
    /sys/class/power_supply/*/type
    /sys/class/power_supply/*/present
    /sys/class/power_supply/*/online
    /sys/class/power_supply/*/status
    /sys/class/power_supply/*/capacity
    /sys/class/udc/*/state
)
for file in "${files[@]}"; do
    printf '\n%s: ' "$file"
    cat "$file" || printf '[unavailable]\n'
done

printf '\nKernel log (monotonic timestamps):\n'
dmesg
