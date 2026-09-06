#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
linux_dir=${repo_dir}/src/linux
build_dir=${repo_dir}/build/linux
config=${build_dir}/.config

make -C "${linux_dir}" O="${build_dir}" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

"${linux_dir}/scripts/config" --file "${config}" \
	--enable DEVTMPFS --enable DEVTMPFS_MOUNT --enable BLOCK \
	--enable MMC --enable MMC_BLOCK --enable MMC_SUNXI --enable DMA_SUN6I \
	--enable EXT4_FS --enable NET --enable INET --enable SERIAL_8250 \
	--enable SERIAL_8250_CONSOLE --enable SERIAL_8250_DW --enable SUNXI_RSB \
	--enable MFD_AXP20X --enable MFD_AXP20X_RSB --enable REGULATOR_AXP20X \
	--enable RESET_GPIO --module RTL8723BS --enable RFKILL --enable BT \
	--enable BT_HCIUART --enable BT_HCIUART_RTL --enable BT_RTL \
	--enable DRM --enable DRM_SUN4I --enable DRM_SUN8I_MIXER --enable DRM_LIMA \
	--enable DRM_PANEL_LVDS --enable BACKLIGHT_PWM --enable PWM --enable PWM_SUN4I \
	--enable KEYBOARD_SUN4I_LRADC --enable INPUT_AXP20X_PEK --module TOUCHSCREEN_SILEAD \
	--enable STK8BA50 --enable SOUND --enable SND --enable SND_SOC \
	--enable SND_DMAENGINE_PCM --enable SND_SUN4I_I2S --enable SND_SUN8I_CODEC \
	--enable SND_SUN50I_CODEC_ANALOG --enable SND_SIMPLE_CARD \
	--enable POWER_SUPPLY --module AXP20X_ADC --module BATTERY_AXP20X \
	--disable AXP20X_POWER --enable NOP_USB_XCEIV --enable PHY_SUN4I_USB \
	--enable CONFIGFS_FS --enable USB_GADGET --enable USB_MUSB_HDRC \
	--enable USB_MUSB_GADGET --enable USB_MUSB_SUNXI --enable USB_LIBCOMPOSITE \
	--enable USB_CONFIGFS --enable USB_CONFIGFS_SERIAL --enable USB_CONFIGFS_ACM \
	--enable USB_CONFIGFS_ECM --disable USB_MASS_STORAGE --disable USB_F_MASS_STORAGE \
	--disable USB_CONFIGFS_MASS_STORAGE --disable MTD --disable SCSI --disable ATA \
	--disable BLK_DEV_NVME --disable HIBERNATION

make -C "${linux_dir}" O="${build_dir}" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig

grep -q '^CONFIG_MMC_SUNXI=y$' "${config}"
grep -q '^CONFIG_TOUCHSCREEN_SILEAD=m$' "${config}"
grep -q '^CONFIG_USB_CONFIGFS_ECM=y$' "${config}"
if grep -Eq '^CONFIG_(USB_MASS_STORAGE|USB_F_MASS_STORAGE|USB_CONFIGFS_MASS_STORAGE|MTD|SCSI|ATA)=[ym]$' "${config}"; then
	printf 'Excluded storage path is enabled.\n' >&2
	exit 1
fi

make -C "${linux_dir}" O="${build_dir}" ARCH=arm64 \
	CROSS_COMPILE=aarch64-linux-gnu- -j"$(nproc)" Image modules \
	allwinner/sun50i-a64-spc-glee-sd-minimal.dtb

mkdir -p "${repo_dir}/build/artifacts"
install -m 0644 "${build_dir}/arch/arm64/boot/Image" "${repo_dir}/build/artifacts/Image"
install -m 0644 "${build_dir}/arch/arm64/boot/dts/allwinner/sun50i-a64-spc-glee-sd-minimal.dtb" \
	"${repo_dir}/build/artifacts/sun50i-a64-spc-glee.dtb"
sha256sum "${repo_dir}/build/artifacts/Image" "${repo_dir}/build/artifacts/sun50i-a64-spc-glee.dtb"
