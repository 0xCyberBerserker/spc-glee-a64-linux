# Mainline Linux submission / Envío a Linux mainline

## English

`v1/` contains a two-patch series ready for maintainer review, based on the
Allwinner maintainer branch `sunxi/for-next` at commit
`913f7eda9f3e3fb1c67285e144e202494d440049`.

The first patch registers the `spc` vendor prefix and board compatible. The
second adds one canonical board DTS. It describes the AXP803 PMIC, essential
CPU, DRAM and system rails, battery monitoring, microSD, UART and USB
peripheral mode. eMMC and hardware requiring local driver patches remain
disabled.

Apply and validate in a clean Linux tree:

```bash
git am /path/to/mainline/v1/0001-*.patch /path/to/mainline/v1/0002-*.patch
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image \
  allwinner/sun50i-a64-spc-glee.dtb
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  dt_binding_check \
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/sunxi.yaml
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  W=1 CHECK_DTBS=y allwinner/sun50i-a64-spc-glee.dtb
```

Recorded on 2026-09-06:

- Clean `git am`, `Image` build, targeted DTB build, `dt_binding_check` and
  `CHECK_DTBS=y` passed using dt-schema 2026.6.
- `W=1` reports only three warnings inherited from `sun50i-a64.dtsi`.
- The final DTB is 27,128 bytes with SHA-256
  `175870a3cfdb8db55396b7fab802e58c66527786692be57b3a6bab9b666ea74c`.
- That exact DTB cold-booted Linux `7.3.0-rc1-spc-mainline-v1-coldtest+`
  from microSD without `regulator_ignore_unused`.
- Linux detected four CPUs and 2 GiB RAM, probed the AXP803 over RSB,
  detected `mmc0`, mounted the ext4 root filesystem and started systemd.
- Author, committer and DCO sign-off use the maintainer's verified identity.

Before sending, refresh `sunxi/for-next`, rerun the validation commands and
review the generated recipients. Do not send the series automatically.

## Español

`v1/` contiene una serie de dos parches lista para revisión por los
mantenedores, basada en la rama del mantenedor
Allwinner `sunxi/for-next`, commit
`913f7eda9f3e3fb1c67285e144e202494d440049`.

El primer parche registra el prefijo `spc` y el compatible de la placa. El
segundo añade un único DTS canónico. Describe el PMIC AXP803, los raíles
esenciales de CPU, DRAM y sistema, la batería, microSD, UART y USB periférico.
La eMMC y el hardware que aún necesita parches locales permanecen
deshabilitados.

Validación registrada el 06-09-2026: `git am`, compilación de `Image` y DTB,
`dt_binding_check` y `CHECK_DTBS=y` correctos con dt-schema 2026.6. `W=1`
sólo muestra tres avisos heredados de `sun50i-a64.dtsi`. El DTB final mide
27.128 bytes y su SHA-256 es
`175870a3cfdb8db55396b7fab802e58c66527786692be57b3a6bab9b666ea74c`.

Ese DTB exacto arrancó en frío Linux
`7.3.0-rc1-spc-mainline-v1-coldtest+` desde microSD sin
`regulator_ignore_unused`. Linux detectó cuatro CPU y 2 GiB de RAM, inició el
AXP803 por RSB, detectó `mmc0`, montó la raíz ext4 y ejecutó systemd. Autor,
committer y firma DCO usan la identidad verificada del mantenedor.

Antes del envío hay que actualizar `sunxi/for-next`, repetir las validaciones y
revisar los destinatarios generados. La serie no debe enviarse automáticamente.
